# logstash-forwarder
#
# A tool to collect logs locally in preparation for processing elsewhere
#
# VERSION               0.3.1

FROM      debian:jessie
MAINTAINER Deni Bertovic "me@denibertovic.com"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

# install deps
RUN apt-get install -y git golang

# clone logstash-forwarder
RUN git clone git://github.com/elasticsearch/logstash-forwarder.git /tmp/logstash-forwarder
RUN cd /tmp/logstash-forwarder && git checkout v0.3.1 && go build

RUN mkdir /opt/forwarder && cp /tmp/logstash-forwarder/logstash-forwarder /opt/forwarder/logstash-forwarder

ADD start_forwarder.sh /usr/local/bin/start_forwarder.sh
RUN chmod 755 /usr/local/bin/start_forwarder.sh

RUN rm -rf /tmp/*

CMD /usr/local/bin/start_forwarder.sh

