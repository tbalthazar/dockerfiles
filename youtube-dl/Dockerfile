FROM ubuntu

RUN apt-get update && apt-get install -y --no-install-recommends \
  ca-certificates \
  curl \
  ffmpeg \
  python3 \
  python3-pip \
  unzip \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p ~/.local/bin \
  && curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o ~/.local/bin/yt-dlp \
  && chmod a+rx ~/.local/bin/yt-dlp

# yt-dlp-ejs solves YouTube's JS challenges but needs an external JS runtime (Deno) on PATH to run
# curl_cffi enables yt-dlp's target impersonation (--impersonate) support
RUN pip install --break-system-packages -U yt-dlp-ejs curl_cffi \
  && curl -fsSL https://deno.land/install.sh | sh

ENV PATH="/root/.local/bin:/root/.deno/bin:$PATH"
