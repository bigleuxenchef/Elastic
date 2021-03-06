---
Title | Author | Date 
---|---|---
OpenSpan telemetry through `filebeat` | Rumi | ** April 2018**
---

# OpenSpan RDA monitoring through `filebeat`

## How OpenSpan RDA works

In this example, we would like to ship the log files generated by OpenSpan RDA into elastic. As RDA is a desktop tool that can run standalone without server based component or back-end, it becomes paramount to deploy a very light agent in each desktop whose sole role will be to ship the log to elasticsearch. Any transformation of data will be done centrally in `logstash`. In other words we can hve as many `filebeat` installed as we have desktop running OpenSpan RDA. The picture below describe the architecture suggested to deploy `filebeat` `logstash`, `elastic` and `kibana` :

<a align="center">
 <figure align="center">
<img src="./Images/relationship-between-filebeat-and-logstash.png" width=50%/>
<figcaption>Chart taken <a href="https://logz.io/blog/filebeat-vs-logstash/">here</a></figcaption>
 </figure>
 </a>

&nbsp;
&nbsp;
> Note we will not discuss here whether we need to use kafka or not, there is a post explaining 

To make this solution working, here are the different elements of `filebeat-logstash-elastic-kibana` being used :

- `logstash` plugins : elapsed, date, csv
- `logstash` grok matching rules and regular expression.

## log files

In this example we have implemented both format : *RuntimeLog.txt* and *Runtime_Log4Net.txt*, you can find more information [here](./OpenSpan-logs.md)

## `filebeat` multiline

https://www.elastic.co/guide/en/beats/filebeat/current/multiline-examples.html

Here is the configuration of filebeat to manage multiline output for the same log message

```yaml
 ### Multiline options

  # Mutiline can be used for log messages spanning multiple lines. This is common
  # for Java Stack Traces or C-Line Continuation

  # The regexp Pattern that has to be matched. The example pattern matches all lines starting with [
  multiline.pattern: '[A-Z]+[ ]+[|]+' # detect pattern like "INFO |" or "ERROR |" or "DEBUG |"

  # Defines if the pattern set under pattern should be negated or not. Default is false.
  multiline.negate: true

  # Match can be set to "after" or "before". It is used to define if lines should be append to a pattern
  # that was (not) matched before or after or as long as a pattern is not matched based on negate.
  # Note: After is the equivalent to previous and before is the equivalent to to next in Logstash
  multiline.match: after
```

## `filebeat` elastic monitoring
`
`filebeat` monitoring means, visualizing system level information about how each `filebeat` instance is performing.

```yaml
xpack.monitoring:
  enabled: true
  elasticsearch:
          hosts: ["http://mbp15.local:9200"]
```

## Connecting `filebeat` to logstash

Configruation on `filebeat` side :

```yaml
#----------------------------- Logstash output --------------------------------
output.logstash:
  # The Logstash hosts
  hosts: ["mbp15.local:5044"]

  # Optional SSL. By default is off.
  # List of root certificates for HTTPS server verifications
  #ssl.certificate_authorities: ["/etc/pki/root/ca.pem"]

  # Certificate for SSL client authentication
  #ssl.certificate: "/etc/pki/client/cert.pem"

  # Client Certificate Key
  #ssl.key: "/etc/pki/client/cert.key"
```

Configuration on `logstash` side:

```yaml
input {
  beats {
    port => 5044
  }
}

```

## transforming the data within `logstash` filter

As highlighted above we will provide the two filter to ingest either *RuntimeLog.txt* or *Runtime_Log4Net.txt*.

here is the example of mapping for the file *Runtime_Log4Net.txt*

```yaml
if [source] =~ /Runtime_Log4Net.txt/
  {
#(?<type>(.*?))[ ]+[|]?[ ]*(?<date>%{YEAR}-%{MONTHNUM}-%{MONTHDAY}[T ]%{HOUR}:?%{MINUTE}(?::?%{SECOND})?)[ ]+[|]?[ ]+(?<thread>[0-9|\w]+)[ ]+[|]?[ ]+(?<TID>[0-9]+)[ ]+[|]?[ ]+(?<PID>[0-9]+)[ ]+[|]?[ ]+(?<State>\w+)[ ]+[|]?[ ](?<Category>[\w+ ]*)[ ]+[|]?[ ](?<DesignComponent>[\w+ -]*)[ ]+[|]?[ ](?<Component>[\w+ -]*)[ ]+[|]?[ ](?<Message>.*?$)
grok {
          match => ["message","(?<type>(.*?))[ ]+[|]?[ ]*(?<date>%{YEAR}-%{MONTHNUM}-%{MONTHDAY}[T ]%{HOUR}:?%{MINUTE}(?::?%{SECOND})?)[ ]+[|]?[ ]+(?<thread>[0-9|\w]+)[ ]+[|]?[ ]+(?<TID>[0-9]+)[ ]+[|]?[ ]+(?<PID>[0-9]+)[ ]+[|]?[ ]+(?<State>\w+)[ ]+[|]?[ ](?<Category>[\w+ ]*)[ ]+[|]?[ ](?<DesignComponent>[\w+ -]*)[ ]+[|]?[ ](?<Component>[\w+ -]*)[ ]+[|]?[ ](?<Message>.*?$)"]

        }
    if [date]
     {
       date {
        # 2018-04-01 16:30:36,199
        match => ["date","yyyy-MM-dd HH:mm:ss,SSS"]
        target => "date"
        }
    }
}
```

to test such a regular expression you may use elastic dev dools the following way :

![Grok-debugger](./Images/Grok-debugger.png)


## Other consideration : using Kafka

> Note we will not discuss here whether we need to use kafka or not, there is a great post  [here](https://www.elastic.co/blog/just-enough-kafka-for-the-elastic-stack-part1) that explain the value and when to use kafka. But keep in minf the anti-pattern : **If you can tolerate a relaxed search latency, you can completely skip the use of Kafka. Filebeat, which follows and ships file content from edge nodes, is resilient to log rotations.**