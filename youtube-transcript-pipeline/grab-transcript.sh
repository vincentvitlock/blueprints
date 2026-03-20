#!/usr/bin/env bash
# grab-transcript.sh — Download YouTube auto-captions and save as Markdown
# Usage: ./grab-transcript.sh "https://www.youtube.com/watch?v=VIDEO_ID"

set -euo pipefail

VIDEO_URL="${1:?Usage: $0 <youtube-url>}"
TRANSCRIPTS_DIR="$(cd "$(dirname "$0")" && pwd)"
TMPDIR_WORK="$(mktemp -d)"
trap 'rm -rf "$TMPDIR_WORK"' EXIT

# ── 1. Fetch metadata ─────────────────────────────────────────────────────────
echo "Fetching metadata…"
/opt/homebrew/bin/yt-dlp --no-playlist --dump-json "$VIDEO_URL" 2>/dev/null \
  > "$TMPDIR_WORK/meta.json"

# Parse metadata via Python (safe — no shell quoting of title needed)
/opt/homebrew/bin/python3 - "$TMPDIR_WORK/meta.json" "$TMPDIR_WORK/env.sh" <<'PYEOF'
import json, sys, shlex

with open(sys.argv[1]) as f:
    d = json.load(f)

env = {
    "TITLE":       d.get("title", ""),
    "UPLOADER":    d.get("uploader", ""),
    "UPLOADER_ID": d.get("uploader_id", ""),
    "UPLOAD_DATE": d.get("upload_date", ""),
    "VIDEO_ID":    d.get("id", ""),
    "DURATION_SEC": str(int(d.get("duration") or 0)),
}

with open(sys.argv[2], "w") as f:
    for k, v in env.items():
        f.write(f"{k}={shlex.quote(v)}\n")
PYEOF

# shellcheck source=/dev/null
source "$TMPDIR_WORK/env.sh"

# Sanitise for filenames
CHANNEL_SLUG="$(echo "$UPLOADER_ID" | tr '[:upper:]' '[:lower:]' | \
  sed 's/[^a-z0-9_-]/-/g' | sed 's/^-*//')"
SAFE_TITLE="$(echo "$TITLE" | sed 's/[^a-zA-Z0-9 _-]/ /g' | \
  tr -s ' ' | sed 's/ /_/g' | cut -c1-80)"

DATE_FMT="${UPLOAD_DATE:0:4}-${UPLOAD_DATE:4:2}-${UPLOAD_DATE:6:2}"
OUT_DIR="$TRANSCRIPTS_DIR/$CHANNEL_SLUG"
mkdir -p "$OUT_DIR"
OUT_FILE="$OUT_DIR/${DATE_FMT}_${SAFE_TITLE}.md"

# ── 2. Download auto-captions (VTT) ──────────────────────────────────────────
echo "Downloading captions…"
/opt/homebrew/bin/yt-dlp \
  --no-playlist \
  --write-auto-sub \
  --sub-lang "en" \
  --sub-format "vtt" \
  --skip-download \
  --output "$TMPDIR_WORK/%(id)s.%(ext)s" \
  "$VIDEO_URL" 2>/dev/null || true

VTT_FILE="$(find "$TMPDIR_WORK" -name "*.vtt" | head -1)"

if [[ -z "$VTT_FILE" ]]; then
  echo "⚠️  No English auto-captions found. Trying all languages…"
  /opt/homebrew/bin/yt-dlp \
    --no-playlist \
    --write-auto-sub \
    --sub-format "vtt" \
    --skip-download \
    --output "$TMPDIR_WORK/%(id)s.%(ext)s" \
    "$VIDEO_URL" 2>/dev/null || true
  VTT_FILE="$(find "$TMPDIR_WORK" -name "*.vtt" | head -1)"
fi

if [[ -z "$VTT_FILE" ]]; then
  echo "❌ No captions available for this video."
  exit 1
fi

# ── 3. Parse VTT → plain text ─────────────────────────────────────────────────
echo "Parsing captions…"
TRANSCRIPT="$(/opt/homebrew/bin/python3 - "$VTT_FILE" <<'PYEOF'
import sys, re

with open(sys.argv[1], encoding="utf-8") as f:
    raw = f.read()

# Remove WEBVTT header block and any key: value header lines that follow
raw = re.sub(r'^WEBVTT[^\n]*\n(^[A-Za-z][A-Za-z\s]*:[^\n]*\n)*', '', raw, flags=re.MULTILINE)
# Remove NOTE blocks
raw = re.sub(r'NOTE\s.*?\n\n', '', raw, flags=re.DOTALL)

lines = []
for line in raw.splitlines():
    line = line.strip()
    if not line:
        continue
    if re.match(r'^\d{2}:\d{2}', line):   # timestamp line
        continue
    if re.match(r'^\d+$', line):           # cue number
        continue
    # Strip VTT inline tags like <00:00:00.000> and <c>
    line = re.sub(r'<[^>]+>', '', line)
    line = line.strip()
    if line:
        lines.append(line)

# De-duplicate consecutive identical lines (caption repetition artefact)
deduped = []
for line in lines:
    if not deduped or line != deduped[-1]:
        deduped.append(line)

print(' '.join(deduped))
PYEOF
)"

WORD_COUNT="$(echo "$TRANSCRIPT" | wc -w | tr -d ' ')"

# ── 4. Write Markdown with YAML frontmatter ───────────────────────────────────
# Use Python to write the file safely (avoids shell quoting issues in title)
/opt/homebrew/bin/python3 - "$OUT_FILE" <<PYEOF
import sys

out_file   = "$OUT_FILE"
title      = """$TITLE"""
date_fmt   = "$DATE_FMT"
video_id   = "$VIDEO_ID"
uploader   = """$UPLOADER"""
channel_id = "$UPLOADER_ID"
url        = "$VIDEO_URL"
duration   = "$DURATION_SEC"
word_count = "$WORD_COUNT"
transcript = r"""$TRANSCRIPT"""

# Escape quotes in YAML string values
def yaml_str(s):
    return s.replace('"', '\\"')

md = f"""---
title: "{yaml_str(title)}"
date: {date_fmt}
video_id: {video_id}
channel: "{yaml_str(uploader)}"
channel_id: {channel_id}
url: {url}
duration_seconds: {duration}
word_count: {word_count}
---

{transcript}
"""

with open(out_file, "w", encoding="utf-8") as f:
    f.write(md)
PYEOF

echo ""
echo "✅ Saved: $OUT_FILE"
echo "   Channel : $UPLOADER ($UPLOADER_ID)"
echo "   Title   : $TITLE"
echo "   Date    : $DATE_FMT"
echo "   Words   : $WORD_COUNT"
