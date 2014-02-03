#!/bin/bash

cat << EOF > /tmp/config.json
{
  "network": {
    "servers": [ "$LOGSTASH_SERVER" ],
    "ssl certificate": "/opt/certs/logstash-forwarder.crt",
    "ssl key": "/opt/certs/logstash-forwarder.key",
    "ssl ca": "/opt/certs/logstash-forwarder.crt",
    "timeout": 15
  },
  "files": [
    {
      "paths": [ "/tmp/feeds/fifofeed" ],
      "fields": { "type": "stdin" }
    }
  ]
}
EOF

/opt/logstash-forwarder/bin/logstash-forwarder -config /tmp/config.json