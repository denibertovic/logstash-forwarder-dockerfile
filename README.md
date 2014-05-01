# Logstash-forwarder Dockerfile

logstash-forwarder 0.3.1

This Dockerfile requires you to first setup Logstash ([dockerfile here.](https://github.com/denibertovic/logstash-dockerfile))

Clone the repo:

    git clone https://github.com/denibertovic/logstash-forwarder-dockerfile

Create OpenSSL certificates for secure communication with logstash.
IMPROTANT: these need to be the same certificates used with [logstash.](https://github.com/denibertovic/logstash-dockerfile)
Create them or copy them over from logstash:

    cd logstash-forwarder-dockerfile && mkdir certs && cd certs
    openssl req -x509 -batch -nodes -newkey rsa:2048 -keyout logstash-forwarder.key -out logstash-forwarder.crt


Build

    docker build -t forwarder .

Run
    
    docker run --name forwarder -d -v /tmp/feeds -e LOGSTASH_SERVER="1.2.3.4:5043" -t forwarder

Test it:

    docker run -volumes-from forwarder -i -t ubuntu /bin/bash -c "echo 'test' >> /tmp/feeds/fifofeed"
    # Go to logstash/kibana web interface on port 9292 and confirm that the messages got through

A couple of things to note:

    * An ENV variable LOGSTASH_SERVER must be set to be able to connect to Logstash (form: IP_ADDRESS:PORT)
    * The forwarder is set up to read logs from a pipe located in /tmp/feeds/fifofeed
    * Expose /tmp/feeds as a volume so other container can mount it and write to it
