# Installing x-pack offline

# Download x-pack

- [:eyes:Installing x-pack offline](https://www.elastic.co/guide/en/elasticsearch/reference/6.0/installing-xpack-es.html)

## Download x-pack

```
https://artifacts.elastic.co/downloads/packs/x-pack/x-pack-<version>.zip

```

## Install x-pack

```
# X-pack is same for kibana, elasticsearch and logstash

elasticsearch> .\bin\elasticsearch-plugin.bat install file:///Downlo
ads/x-pack-<version>.zip
kibana> .\bin\kibana-plugin.bat install file:///Downloads/x-p
ack-<version>.zip


```