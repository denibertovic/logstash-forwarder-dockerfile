# Logstash-forwarder Dockerfile

logstash-forwarder 0.3.1

NOTE: First visit this repo and learn how to run the whole ELK stack : https://github.com/denibertovic/elk-stack-docker

Clone the repo:

    git clone https://github.com/denibertovic/logstash-forwarder-dockerfile

Make sure to use the certificates used to start Logstash from the ELK-stack repository above.

Pull

    docker pull denibertovic/logstash-forwarder

Run and test

    mkdir /tmp/test && touch /tmp/test/test.log
    docker run --name forwarder -d -v /tmp/test:/tmp/test -v `pwd`/conf-example:/opt/conf -v `pwd`/certs:/opt/certs -t denibertovic/logstash-forwarder

    cat >> /tmp/test/test.log
    test
    test
    test
    ^C

    Log in to the Kibana interface, you should see the logs 3 test messages there.

Volumes:

    /opt/conf  - Configuration folder with config.json
    /opt/certs - Certs folder with logstash-forwarder.crt and logstash-forwarder.key (used to start logstash)

