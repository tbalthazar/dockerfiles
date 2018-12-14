FROM debian:buster-slim
LABEL maintainer "Thomas Balthazar <thomas@balthazar.info>"

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.utf8
ENV USER user
ENV HOME /home/$USER
ENV RUBY_VERSION 2.5.3

RUN apt-get update && apt-get install -y \
  apt-transport-https \
  ca-certificates \
	curl \
  git \
	locales \
  man \
	vim-nox \
  libpq-dev \
  nodejs \
  tmux \
  tzdata \
  libsqlite3-dev \
  sudo \
  autoconf \
  bison \
  build-essential \
  python \
  libssl-dev \
  libyaml-dev \
  libreadline6-dev \
  zlib1g-dev \
  libncurses5-dev \
  libffi-dev \
  libgdbm6 \
  libgdbm-dev \
	--no-install-recommends \
  && rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8 \
  && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

RUN useradd -s /bin/bash --create-home --home-dir $HOME $USER \
  && chown -R $USER:$USER $HOME

RUN curl -fsSL https://get.docker.com | sh \
  && usermod -aG docker $USER

WORKDIR $HOME
USER $USER

RUN git clone https://github.com/rbenv/rbenv.git "$HOME/.rbenv" \
  && echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> "$HOME/.bash_profile" \
  && echo 'eval "$(rbenv init -)"' >> "$HOME/.bash_profile" \
  && echo "source $HOME/.bash_profile" >> "$HOME/.bashrc" \
  && /bin/bash -c "source $HOME/.bash_profile" \
  && $HOME/.rbenv/bin/rbenv init - \
  && mkdir -p $HOME/.rbenv/plugins \
  && git clone https://github.com/rbenv/ruby-build.git $HOME/.rbenv/plugins/ruby-build \
  && $HOME/.rbenv/bin/rbenv install $RUBY_VERSION \
  && $HOME/.rbenv/bin/rbenv global $RUBY_VERSION \
  && $HOME/.rbenv/shims/gem install bundler --no-rdoc --no-ri \
  && $HOME/.rbenv/shims/gem install rails --no-rdoc --no-ri 

RUN git clone https://github.com/tbalthazar/dotfiles.git \
  && cd dotfiles \
  && git checkout v2 \
  && bin/install dotfiles

ENV PATH=/gems/bin:$PATH
