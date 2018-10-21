FROM debian:buster
LABEL maintainer "Thomas Balthazar <thomas@balthazar.info>"

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.utf8
ENV USER tb
ENV HOME /home/$USER

RUN apt-get update && apt-get install -y \
  apt-transport-https \
  ca-certificates \
	curl \
  git \
	locales \
  man \
	vim \
  libpq-dev \
  nodejs \
  tzdata \
  libsqlite3-dev \
  sudo \
  autoconf \
  bison \
  build-essential \
  libssl-dev \
  libyaml-dev \
  libreadline6-dev \
  zlib1g-dev \
  libncurses5-dev \
  libffi-dev \
  libgdbm5 \
  libgdbm-dev \
	--no-install-recommends \
  && rm -rf /var/lib/apt/lists/* \
  && locale-gen en_US.UTF-8 \
  && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
  && useradd --create-home --home-dir $HOME $USER \
  && chown -R $USER:$USER $HOME

WORKDIR $HOME
USER tb

RUN git clone https://github.com/rbenv/rbenv.git "$HOME/.rbenv" \
  && echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> "$HOME/.bash_profile" \
  && echo 'eval "$(rbenv init -)"' >> "$HOME/.bash_profile" \
  && echo "source $HOME/.bash_profile" >> "$HOME/.bashrc" \
  && /bin/bash -c "source $HOME/.bash_profile" \
  && $HOME/.rbenv/bin/rbenv init - \
  && mkdir -p $HOME/.rbenv/plugins \
  && git clone https://github.com/rbenv/ruby-build.git $HOME/.rbenv/plugins/ruby-build \
  && $HOME/.rbenv/bin/rbenv install 2.5.3 \
  && $HOME/.rbenv/bin/rbenv global 2.5.3 \
  gem install bundler rails --no-rdoc --no-ri
