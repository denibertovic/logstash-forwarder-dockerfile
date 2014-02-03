# logstash-forwarder
#
# A tool to collect logs locally in preparation for processing elsewhere
#
# VERSION               0.3.1

FROM      debian:sid
MAINTAINER Deni Bertovic "deni@kset.org"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

# install deps
RUN apt-get install -y wget git golang ruby1.9.1 ruby1.9.1-dev rubygems1.9.1 irb1.9.1 ri1.9.1 rdoc1.9.1 build-essential libopenssl-ruby1.9.1 libssl-dev zlib1g-dev

# clone logstash-forwarder
RUN git clone git://github.com/elasticsearch/logstash-forwarder.git /tmp/logstash-forwarder
RUN cd /tmp/logstash-forwarder && go build

# Install fpm
RUN gem install fpm

# Build deb
RUN cd /tmp/logstash-forwarder && make deb
RUN dpkg -i /tmp/logstash-forwarder/logstash-forwarder_0.3.1_amd64.deb

# Cleanup
RUN rm -rf /tmp/*

# Add FIFO
RUN mkdir /tmp/feeds/ && mkfifo /tmp/feeds/fifofeed

ADD run.sh /usr/local/bin/run.sh
RUN chmod 755 /usr/local/bin/run.sh

RUN mkdir /opt/certs/
ADD certs/logstash-forwarder.crt /opt/certs/logstash-forwarder.crt
ADD certs/logstash-forwarder.key /opt/certs/logstash-forwarder.key

CMD /usr/local/bin/run.sh
