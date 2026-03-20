# YouTube Transcript Pipeline

Download YouTube auto-captions and save them as searchable Markdown files with YAML frontmatter. No audio download required — runs entirely on free YouTube auto-captions via `yt-dlp`.

## What it does

1. Fetches video metadata (title, channel, date, duration) via `yt-dlp --dump-json`
2. Downloads the auto-generated VTT caption file (English first, any language fallback)
3. Parses and deduplicates the VTT into clean plain text
4. Writes a `.md` file with YAML frontmatter + transcript body, organized by channel slug

## Output structure

```
~/transcripts/
├── grab-transcript.sh
└── <channel-slug>/
    └── YYYY-MM-DD_Video_Title_Here.md
```

Each `.md` file looks like:

```markdown
---
title: "Video Title Here"
date: 2024-06-15
video_id: dQw4w9WgXcQ
channel: "Channel Name"
channel_id: @ChannelHandle
url: https://www.youtube.com/watch?v=dQw4w9WgXcQ
duration_seconds: 213
word_count: 291
---

Full transcript text here as a single paragraph...
```

## Requirements

| Tool | Install |
|------|---------|
| `yt-dlp` | `brew install yt-dlp` |
| `python3` | `brew install python` |
| `ffmpeg` | `brew install ffmpeg` (optional — not needed for captions-only) |

All paths use `/opt/homebrew/bin/` (Apple Silicon Mac default). If you're on Intel Mac or Linux, edit the script's tool paths or replace with bare `yt-dlp` / `python3` if they're on your `$PATH`.

## Setup

```bash
mkdir -p ~/transcripts
cp grab-transcript.sh ~/transcripts/
chmod +x ~/transcripts/grab-transcript.sh
```

## Usage

### Single video
```bash
~/transcripts/grab-transcript.sh "https://www.youtube.com/watch?v=VIDEO_ID"
```

### Bulk channel download
```bash
yt-dlp --flat-playlist --print "%(url)s" "https://youtube.com/@ChannelHandle" \
  | while read url; do ~/transcripts/grab-transcript.sh "$url"; done
```

### Search transcripts with grep
```bash
grep -r "topic keyword" ~/transcripts/ --include="*.md" -l
```

### Use with Claude
> "Grab the transcript for this video and save it to my library: [url]"

> "Search my ~/transcripts folder for anything about [topic] and summarize what you find."

## Accuracy

Auto-captions are ~85–90% accurate for clear English speech. Music, accents, and technical jargon reduce accuracy. The VTT deduplication pass removes the repetition artefact common in YouTube auto-captions (where the same phrase appears 2–3 times in consecutive cues).

## Limitations

- Videos without any captions (auto or manual) will exit with an error.
- The transcript is output as a single paragraph — no sentence boundaries are preserved from the VTT timing.
- Rate limits: YouTube may throttle bulk downloads. Add `sleep 2` between iterations for large channels.

## Optional next step: semantic search

For semantic search across many transcripts, embed them into a vector store (e.g. Supabase pgvector) and query with natural language. The YAML frontmatter makes chunking and metadata filtering straightforward.
