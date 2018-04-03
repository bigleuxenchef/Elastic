# OpenSpan logging configuration

OpenSpan configuration file : [`RuntimeConfig.xml`](./conf/RuntimeConfig.xml)

## 

```xml
<Diagnostics mode="on" hook_unhandled_exception="on" hook_trace="on" hook_debug="on" trace_level="4">
    <email mode="off" subject="Exception Information" server="" from="" to="" />
    <publisher mode="on" trace_mode="on" exception_mode="on" assembly="OpenSpan" type="OpenSpan.Diagnostics.Publishers.FilePublisher" fileName="RuntimeLog.txt" filesToKeep="1" initMode="ClearLog" InnerXml="," />
    <publisher mode="on" trace_mode="on" exception_mode="on" assembly="OpenSpan" type="OpenSpan.Diagnostics.Publishers.TracePublisher" fileName="STDiagnosticLog.txt" txtOutput="off" xmlOutput="on" deleteLogs="on" logProcessorProgress="on" logProcessor="on" InnerXml="," />
    <publisher mode="on" trace_mode="on" exception_mode="on" assembly="OpenSpan" type="OpenSpan.Diagnostics.Publishers.OutputWindowPublisher" InnerXml="," />
    <publisher mode="on" trace_mode="on" exception_mode="on" assembly="OpenSpan" type="OpenSpan.Diagnostics.Publishers.Log4NetPublisher" InnerXml="&lt;!-- Settings for Runtime Log4Net logging --&gt;&#xD;&#xA;&lt;appender name=&quot;RollingFileAppender&quot; type=&quot;log4net.Appender.RollingFileAppender, log4net&quot;&gt;&#xD;&#xA;  &lt;!-- Name to save the log file to --&gt;&#xD;&#xA;  &lt;file type=&quot;log4net.Util.PatternString&quot; value=&quot;%property{ConfigurationDirectory}/%property{ProgramShortName}_Log4Net.txt&quot; /&gt;&#xD;&#xA;  &lt;!-- Set whether to create a new file every run (backing up old ones) --&gt;&#xD;&#xA;  &lt;appendToFile value=&quot;false&quot; /&gt;&#xD;&#xA;  &lt;!-- Set the maximum size of each log file --&gt;&#xD;&#xA;  &lt;rollingStyle value=&quot;Size&quot; /&gt;&#xD;&#xA;  &lt;maximumFileSize value=&quot;1MB&quot; /&gt;&#xD;&#xA;  &lt;!-- Maximum files to back up, will be named filename.1, filename.2, ..., filename.n --&gt;&#xD;&#xA;  &lt;maxSizeRollBackups value=&quot;3&quot; /&gt;&#xD;&#xA;  &lt;staticLogFileName value=&quot;true&quot; /&gt;&#xD;&#xA;  &lt;!-- Allow multiple instances to log to the same file --&gt;&#xD;&#xA;  &lt;lockingModel type=&quot;log4net.Appender.FileAppender+MinimalLock&quot; /&gt;&#xD;&#xA;  &lt;layout type=&quot;log4net.Layout.PatternLayout&quot;&gt;&#xD;&#xA;    &lt;conversionPattern value=&quot;%-5level | %date | %7.7thread | %message%newline&quot; /&gt;&#xD;&#xA;  &lt;/layout&gt;&#xD;&#xA;&lt;/appender&gt;&#xD;&#xA;&lt;root&gt;&#xD;&#xA;  &lt;!-- You can enter ERROR, WARN, INFO, DEBUG, ALL, or OFF.  ALL and DEBUG provide the same results.  FATAL means nothing will be logged. --&gt;&#xD;&#xA;  &lt;level value=&quot;DEBUG&quot; /&gt;&#xD;&#xA;  &lt;appender-ref ref=&quot;RollingFileAppender&quot; /&gt;&#xD;&#xA;&lt;/root&gt;," />
  </Diagnostics>
```

