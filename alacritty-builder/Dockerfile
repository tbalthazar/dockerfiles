FROM ubuntu:20.04
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y \
  cmake \
  curl \
  git \
  pkg-config \
  libfreetype6-dev \
  libfontconfig1-dev \
  libxcb-xfixes0-dev \
  libxkbcommon-dev \
  python3
  
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y
ENV PATH "$PATH:/root/.cargo/bin"
RUN bash -c 'source "$HOME/.cargo/env"'
RUN rustup override set stable && \
      rustup update stable

ENV REPO_URL https://github.com/alacritty/alacritty.git
ENV CLONE_DIR /src/alacritty
RUN mkdir -p $CLONE_DIR
RUN git clone  $REPO_URL $CLONE_DIR
WORKDIR $CLONE_DIR
RUN cargo build --release

ENV TARGET_DIR /mnt/alacritty
RUN mkdir -p $TARGET_DIR

COPY ./entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh
ENTRYPOINT [ "./entrypoint.sh" ]
