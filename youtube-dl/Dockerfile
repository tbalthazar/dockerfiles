FROM ubuntu

RUN apt-get update && apt-get install -y --no-install-recommends \
  ca-certificates \
  curl \
  ffmpeg \
  python3 \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p ~/.local/bin \
  && curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o ~/.local/bin/yt-dlp \
  && chmod a+rx ~/.local/bin/yt-dlp

ENV PATH="/root/.local/bin:$PATH"
