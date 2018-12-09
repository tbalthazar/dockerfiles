FROM ruby:2.5.3
LABEL maintainer=thomas@balthazar.info

EXPOSE 3000

ENV USER tb
ENV HOME /home/$USER
ENV GEM_HOME /gems
ENV BUNDLE_PATH $GEM_HOME
ENV PATH "${BUNDLE_PATH}/bin:${PATH}"

RUN useradd --create-home --home-dir $HOME $USER \
  && chown -R $USER:$USER $HOME \
  && mkdir -p $GEM_HOME \
  && chown -R $USER:$USER $GEM_HOME

RUN apt-get update && apt-get install -y \
  nodejs \
  --no-install-recommends \
  && rm -rf /var/lib/apt/lists/*

USER $USER

COPY Gemfile* /usr/src/app/
WORKDIR /usr/src/app
COPY . /usr/src/app
RUN bundle install --jobs=20 --retry=5
CMD ["rails", "s", "-b", "0.0.0.0"]
