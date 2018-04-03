# OpenSpan logging configuration

OpenSpan configuration file : [`RuntimeConfig.xml`](./conf/RuntimeConfig.xml)

## Publisher Types

Here is a snippet of [`RuntimeConfig.xml`](./conf/RuntimeConfig.xml), where we can find the definition of the different type of publishers. Those publishers are responsible to define how the logging information is being generated and formatted.

```xml
<Diagnostics mode="on" hook_unhandled_exception="on" hook_trace="on" hook_debug="on" trace_level="4">
    <email mode="off" subject="Exception Information" server="" from="" to="" />
    <publisher mode="on" trace_mode="on" exception_mode="on" assembly="OpenSpan" type="OpenSpan.Diagnostics.Publishers.FilePublisher" fileName="RuntimeLog.txt" filesToKeep="1" initMode="ClearLog" InnerXml="," />
    <publisher mode="on" trace_mode="on" exception_mode="on" assembly="OpenSpan" type="OpenSpan.Diagnostics.Publishers.TracePublisher" fileName="STDiagnosticLog.txt" txtOutput="off" xmlOutput="on" deleteLogs="on" logProcessorProgress="on" logProcessor="on" InnerXml="," />
    <publisher mode="on" trace_mode="on" exception_mode="on" assembly="OpenSpan" type="OpenSpan.Diagnostics.Publishers.OutputWindowPublisher" InnerXml="," />
    <publisher mode="on" trace_mode="on" exception_mode="on" assembly="OpenSpan" type="OpenSpan.Diagnostics.Publishers.Log4NetPublisher" InnerXml="&lt;!-- Settings for Runtime Log4Net logging --&gt;&#xD;&#xA;&lt;appender name=&quot;RollingFileAppender&quot; type=&quot;log4net.Appender.RollingFileAppender, log4net&quot;&gt;&#xD;&#xA;  &lt;!-- Name to save the log file to --&gt;&#xD;&#xA;  &lt;file type=&quot;log4net.Util.PatternString&quot; value=&quot;%property{ConfigurationDirectory}/%property{ProgramShortName}_Log4Net.txt&quot; /&gt;&#xD;&#xA;  &lt;!-- Set whether to create a new file every run (backing up old ones) --&gt;&#xD;&#xA;  &lt;appendToFile value=&quot;false&quot; /&gt;&#xD;&#xA;  &lt;!-- Set the maximum size of each log file --&gt;&#xD;&#xA;  &lt;rollingStyle value=&quot;Size&quot; /&gt;&#xD;&#xA;  &lt;maximumFileSize value=&quot;1MB&quot; /&gt;&#xD;&#xA;  &lt;!-- Maximum files to back up, will be named filename.1, filename.2, ..., filename.n --&gt;&#xD;&#xA;  &lt;maxSizeRollBackups value=&quot;3&quot; /&gt;&#xD;&#xA;  &lt;staticLogFileName value=&quot;true&quot; /&gt;&#xD;&#xA;  &lt;!-- Allow multiple instances to log to the same file --&gt;&#xD;&#xA;  &lt;lockingModel type=&quot;log4net.Appender.FileAppender+MinimalLock&quot; /&gt;&#xD;&#xA;  &lt;layout type=&quot;log4net.Layout.PatternLayout&quot;&gt;&#xD;&#xA;    &lt;conversionPattern value=&quot;%-5level | %date | %7.7thread | %message%newline&quot; /&gt;&#xD;&#xA;  &lt;/layout&gt;&#xD;&#xA;&lt;/appender&gt;&#xD;&#xA;&lt;root&gt;&#xD;&#xA;  &lt;!-- You can enter ERROR, WARN, INFO, DEBUG, ALL, or OFF.  ALL and DEBUG provide the same results.  FATAL means nothing will be logged. --&gt;&#xD;&#xA;  &lt;level value=&quot;DEBUG&quot; /&gt;&#xD;&#xA;  &lt;appender-ref ref=&quot;RollingFileAppender&quot; /&gt;&#xD;&#xA;&lt;/root&gt;," />
  </Diagnostics>
```

There are 4 types of publisher in OpenSpan as depicted in the snippet above , lets focus on the two of interest for now :

- File publisher `OpenSpan.Diagnostics.Publishers.FilePublisher`, this generates a sample like [:eye:here](./logs/RuntimeLog.txt)
- Log4Net `OpenSpan.Diagnostics.Publishers.Log4NetPublisher`, this generates a sample like [:eye:here](./logs/Runtime_Log4Net.txt)
## Explose key parameters

```xml

<!-- Settings for Runtime Log4Net logging -->
<appender name='RollingFileAppender' type='log4net.Appender.RollingFileAppender, log4net'>
	<!-- Name to save the log file to -->
	<file type='log4net.Util.PatternString'
		value='%property{ConfigurationDirectory}/%property{ProgramShortName}_Log4Net.txt' />
	<!-- Set whether to create a new file every run (backing up old ones) -->
	<appendToFile value='false' />
	<!-- Set the maximum size of each log file -->
	<rollingStyle value='Size' />
	<maximumFileSize value='1MB' />
	<!-- Maximum files to back up, will be named filename.1, filename.2, ..., 
		filename.n -->
	<maxSizeRollBackups value='3' />
	<staticLogFileName value='true' />
	<!-- Allow multiple instances to log to the same file -->
	<lockingModel type='log4net.Appender.FileAppender+MinimalLock' />
	<layout type='log4net.Layout.PatternLayout'>
		<conversionPattern value='%-5level | %date | %7.7thread | %message%newline' />
	</layout>
</appender>
<root>
	<!-- You can enter ERROR, WARN, INFO, DEBUG, ALL, or OFF. ALL and DEBUG 
		provide the same results. FATAL means nothing will be logged. -->
	<level value='DEBUG' />
	<appender-ref ref='RollingFileAppender' />
</root>
```

### Rolling log configuration


### Number of log file


### Size of each log file

In order to avoid file to grow beyond reason, the maximum size allocated to a log file before it rolls over can be setup at the publisher level by setting the options : `
