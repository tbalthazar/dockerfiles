FROM ubuntu

RUN apt-get update && apt-get install -y --no-install-recommends \
  ca-certificates \
  curl \
  ffmpeg \
  python3 \
  && rm -rf /var/lib/apt/lists/*

RUN curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp \
  && chmod a+rx /usr/local/bin/yt-dlp
