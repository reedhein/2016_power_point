FROM ubuntu:14.04
MAINTAINER Doug Headley <headley.douglas@gmail.com>

LABEL container=hatorade-ember
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y build-essential curl zlib1g-dev zlib1g zlibc openssl libssl-dev libreadline-dev

ENV CONFIGURE_OPTS --disable-install-rdoc

ENV RUBY_VERSION=2.3.1
RUN curl -O http://ftp.ruby-lang.org/pub/ruby/2.3/ruby-${RUBY_VERSION}.tar.gz && \
    tar -zxvf ruby-${RUBY_VERSION}.tar.gz && \
    cd ruby-${RUBY_VERSION} && \
    ./configure --disable-install-doc --enable-shared && \
    make && \
    make install && \
    cd .. && \
    rm -r ruby-${RUBY_VERSION} ruby-${RUBY_VERSION}.tar.gz && \
    echo 'gem: --no-document' > /usr/local/etc/gemrcdoc

RUN apt-get install -y git

RUN apt-get clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN gem install bundler

WORKDIR /tmp
ADD ./Gemfile Gemfile
ADD ./Gemfile.lock Gemfile.lock
RUN bundle

ADD ./ /opt/impres
WORKDIR /opt/impres

#
EXPOSE 4567

CMD RACK_ENV=production rackup -p 4567 -b 0.0.0.0

