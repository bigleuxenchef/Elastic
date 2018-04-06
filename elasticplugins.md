
<!-- TOC -->

- [List of Plugins](#list-of-plugins)
    - [Elasticsearch plugins](#elasticsearch-plugins)
    - [Kibana plugins](#kibana-plugins)
    - [Logstash plugins](#logstash-plugins)
        - [server-side (optional for blueprism, required for openspan in case of using filebeat)](#server-side-optional-for-blueprism-required-for-openspan-in-case-of-using-filebeat)
        - [Client side (on windows when using `blueprism` or `openspan`)](#client-side-on-windows-when-using-blueprism-or-openspan)
    - [Notes](#notes)

<!-- /TOC -->

# List of Plugins

here under you will find the list of plugins installed for running elastic sandbox to cover all sample under this repository. As what is included standard with either `elasticsearch`, `kibana` or `logstash`, we will give a snapshot that can travel with us along the different versions.

## Elasticsearch plugins

Only x-pack is relevant unless you want to use hadoop to snapshot your data, you can use file system to snapshot instead of hadoop.

```bash
bin/elasticsearch-plugin list
repository-hdfs
ingest-geoip
x-pack
x-pack-core
x-pack-deprecation
x-pack-graph
x-pack-logstash
x-pack-ml
x-pack-monitoring
x-pack-security
x-pack-upgrade
x-pack-watcher
```

## Kibana plugins

Only x-pack is mandatory, the other one are listed as it has been tested with the integration of other plugin.

```bssh
bin/kibana-plugin list
c3_charts@5.0.0-rc1
kibana_sample_plugin@kibana
kibana_sample_visualization@kibana
prelert_swimlane_
x-pack@6.0.x-pack@6.2.1 # or whatever version
```

## Logstash plugins

### server-side (optional for blueprism, required for openspan in case of using filebeat)

```bash
bin/logstash-plugin list
logstash-codec-cef
logstash-codec-collectd
logstash-codec-dots
logstash-codec-edn
logstash-codec-edn_lines
logstash-codec-es_bulk
logstash-codec-fluent
logstash-codec-graphite
logstash-codec-json
logstash-codec-json_lines
logstash-codec-line
logstash-codec-msgpack
logstash-codec-multiline
logstash-codec-netflow
logstash-codec-plain
logstash-codec-rubydebug
logstash-filter-aggregate
logstash-filter-anonymize
logstash-filter-cidr
logstash-filter-clone
logstash-filter-csv
logstash-filter-date
logstash-filter-de_dot
logstash-filter-dissect
logstash-filter-dns
logstash-filter-drop
logstash-filter-elapsed
logstash-filter-elasticsearch
logstash-filter-fingerprint
logstash-filter-geoip
logstash-filter-grok
logstash-filter-jdbc_static
logstash-filter-jdbc_streaming
logstash-filter-json
logstash-filter-json_encode
logstash-filter-kv
logstash-filter-metrics
logstash-filter-mutate
logstash-filter-ruby
logstash-filter-sleep
logstash-filter-split
logstash-filter-syslog_pri
logstash-filter-throttle
logstash-filter-translate
logstash-filter-truncate
logstash-filter-urldecode
logstash-filter-useragent
logstash-filter-xml
logstash-input-beats
logstash-input-dead_letter_queue
logstash-input-elasticsearch
logstash-input-exec
logstash-input-file
logstash-input-ganglia
logstash-input-gelf
logstash-input-generator
logstash-input-graphite
logstash-input-heartbeat
logstash-input-http
logstash-input-http_poller
logstash-input-imap
logstash-input-jdbc
logstash-input-kafka
logstash-input-pipe
logstash-input-rabbitmq
logstash-input-redis
logstash-input-s3
logstash-input-snmptrap
logstash-input-sqs
logstash-input-stdin
logstash-input-syslog
logstash-input-tcp
logstash-input-twitter
logstash-input-udp
logstash-input-unix
logstash-output-cloudwatch
logstash-output-csv
logstash-output-elasticsearch
logstash-output-email
logstash-output-file
logstash-output-graphite
logstash-output-http
logstash-output-kafka
logstash-output-lumberjack
logstash-output-nagios
logstash-output-null
logstash-output-pagerduty
logstash-output-pipe
logstash-output-rabbitmq
logstash-output-redis
logstash-output-s3
logstash-output-sns
logstash-output-sqs
logstash-output-stdout
logstash-output-tcp
logstash-output-udp
logstash-output-webhdfs
logstash-patterns-core
x-pack

```

### Client side (on windows when using `blueprism` or `openspan`)

the one really important to check if they are included are :

```bash
logstash-input-jdbc
logstash-filter-grok
logstash-filter-xml
logstash-filter-csv
logstash-filter-ruby
logstash-filter-date
logstash-filter-elapsed
```

```bash
Windows PowerShell
Copyright (C) Microsoft Corporation. All rights reserved.

> .\bin\logstash-plugin.bat list
logstash-codec-cef
logstash-codec-collectd
logstash-codec-dots
logstash-codec-edn
logstash-codec-edn_lines
logstash-codec-es_bulk
logstash-codec-fluent
logstash-codec-graphite
logstash-codec-json
logstash-codec-json_lines
logstash-codec-line
logstash-codec-msgpack
logstash-codec-multiline
logstash-codec-netflow
logstash-codec-plain
logstash-codec-rubydebug
logstash-filter-aggregate
logstash-filter-anonymize
logstash-filter-cidr
logstash-filter-clone
logstash-filter-csv
logstash-filter-date
logstash-filter-de_dot
logstash-filter-dissect
logstash-filter-dns
logstash-filter-drop
logstash-filter-elapsed
logstash-filter-elasticsearch
logstash-filter-fingerprint
logstash-filter-geoip
logstash-filter-grok
logstash-filter-jdbc_streaming
logstash-filter-json
logstash-filter-kv
logstash-filter-metrics
logstash-filter-mutate
logstash-filter-ruby
logstash-filter-sleep
logstash-filter-split
logstash-filter-syslog_pri
logstash-filter-throttle
logstash-filter-translate
logstash-filter-truncate
logstash-filter-urldecode
logstash-filter-useragent
logstash-filter-xml
logstash-input-beats
logstash-input-dead_letter_queue
logstash-input-elasticsearch
logstash-input-exec
logstash-input-file
logstash-input-ganglia
logstash-input-gelf
logstash-input-generator
logstash-input-graphite
logstash-input-heartbeat
logstash-input-http
logstash-input-http_poller
logstash-input-imap
logstash-input-jdbc
logstash-input-kafka
logstash-input-pipe
logstash-input-rabbitmq
logstash-input-redis
logstash-input-s3
logstash-input-snmptrap
logstash-input-sqs
logstash-input-stdin
logstash-input-syslog
logstash-input-tcp
logstash-input-twitter
logstash-input-udp
logstash-input-unix
logstash-output-cloudwatch
logstash-output-csv
logstash-output-elasticsearch
logstash-output-email
logstash-output-file
logstash-output-graphite
logstash-output-http
logstash-output-kafka
logstash-output-lumberjack
logstash-output-nagios
logstash-output-null
logstash-output-pagerduty
logstash-output-pipe
logstash-output-rabbitmq
logstash-output-redis
logstash-output-s3
logstash-output-sns
logstash-output-sqs
logstash-output-stdout
logstash-output-tcp
logstash-output-udp
logstash-output-webhdfs
logstash-patterns-core
x-pack
```

## Notes

An error can be generated when using `<logstash|elasticsearch|kibana>-plugin list` if something unexpected is stored by accident in plugins directory. In this case here under, if it happens that you browse the directory with `Finder` on osx, it may create a dile `.DS_Store` can conflict with plugins. MAke sure to keep it clear.

```java
bin/elasticsearch-plugin list
.DS_Store
Exception in thread "main" java.nio.file.FileSystemException: /usr/local/Cellar/elasticsearch/6.2.1/libexec/plugins/.DS_Store/plugin-descriptor.properties: Not a directory
	at sun.nio.fs.UnixException.translateToIOException(UnixException.java:91)
	at sun.nio.fs.UnixException.rethrowAsIOException(UnixException.java:102)
	at sun.nio.fs.UnixException.rethrowAsIOException(UnixException.java:107)
	at sun.nio.fs.UnixFileSystemProvider.newByteChannel(UnixFileSystemProvider.java:214)
	at java.nio.file.Files.newByteChannel(Files.java:361)
	at java.nio.file.Files.newByteChannel(Files.java:407)
	at java.nio.file.spi.FileSystemProvider.newInputStream(FileSystemProvider.java:384)
	at java.nio.file.Files.newInputStream(Files.java:152)
	at org.elasticsearch.plugins.PluginInfo.readFromProperties(PluginInfo.java:202)
	at org.elasticsearch.plugins.PluginInfo.readFromProperties(PluginInfo.java:184)
	at org.elasticsearch.plugins.ListPluginsCommand.printPlugin(ListPluginsCommand.java:88)
	at org.elasticsearch.plugins.ListPluginsCommand.execute(ListPluginsCommand.java:80)
	at org.elasticsearch.cli.EnvironmentAwareCommand.execute(EnvironmentAwareCommand.java:86)
	at org.elasticsearch.cli.Command.mainWithoutErrorHandling(Command.java:124)
	at org.elasticsearch.cli.MultiCommand.execute(MultiCommand.java:75)
	at org.elasticsearch.cli.Command.mainWithoutErrorHandling(Command.java:124)
	at org.elasticsearch.cli.Command.main(Command.java:90)
	at org.elasticsearch.plugins.PluginCli.main(PluginCli.java:48)

```