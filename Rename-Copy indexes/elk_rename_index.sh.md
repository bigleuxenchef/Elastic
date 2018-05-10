---
Title | Author | Date 
---|---|---
Elastic indice Bulk Rename/Copy   | Rumi | ** April 2018**
---

# Purpose

During the development and learning or even while migrating or moving data in production, everyone is getting confronted to copy, rename or move data file, database table. In elastic, there is a curl command to rename an index, where the problem start to be fun is for example when you have files like logstash-YYYY.MM.DD, and for example you have hundreds to rename from logstash-YYYY.MM.DD to let's say newlogstash-YYYY.MM.DD, you are no going to type the commands hundred times. this is where this script gets very useful.

## Use case \#1 : Reindex/Rename

In elastic, there is nothing else than `reindex` command to achieve both reindex and rename, you cannot reindex the current index like you would do in the databas where you keep the original table and change it. In elastic, reindexing means creating a new one from the old one.

The script `elk_rename_index.sh` is achieving that using pattern, such as :

```
# This will recreate new indexes newlogstash for any source index called logstash, such as:
# logstash-1955.02.24 to new_logstash-1955.02.24
# logstash-steve-job-birthdate to  new_logstash-steve-job-birthdate
# logstash-2011-10-05 to new_logstash-2011-10-05
# Assuming you have three index like above, the command here under will reindex all 3 in one call.
# of course if you have a logstash file for each day of the year, the command will rename them all
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# !!!!! Be careful it can take some time and resources to reindex too much in one command !!!!!!!
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
elk_rename_index.sh -e localhost:9200 -s logstash -d new_logstash
```

## Use case \#2 : Extract data from index to create another index

What happened very often is when using logstash from the beginning, we tend to put everything in the logstash index, this is what happened to me at the beginning, I use to put my `syslog` file, my `collectd` data and a whole lot of other files. As I am the kind of person who does not like top through away data just because it needs some work to make it look the way I like, I migrate my data in a way that collectd data goes in `collectd` index even though it was coming from the logstash file. The script can achieve this the following way :

```
# this will extract all collectd information from logstash and put it in the new created index collectd
elk_rename_index.sh -e localhost:9200 -s logstash -d collectd -t collectd

```




## Rename index and reindex

```bash
#!/bin/bash -x

usage()
{
    echo "usage: elk_rename_index [-e HOST:PORT  -s STRING -d STRING [-b <batch size>] [-t <type>]| [-h]]"
}

TYPE=""

while [ "$1" != "" ]; do
    case $1 in
        -e | --elk-host-port )	shift
				ELKHOSTPORT=$1
                                ;;
        -s | --source-pattern ) shift
				INDEXPATTERN=$1
                                ;;
        -d | --target-pattern ) shift
				NEWINDEXPATTERN=$1
                                ;;
        -b | --reindex-batchsize ) shift
				BATCHSIZE=$1
                                ;;
        -t | --index-type ) shift
				TYPE=$1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done
The 

indexes=$(curl -XGET "$ELKHOSTPORT/_cat/indices?v&pretty" | awk '{ if (NR > 1) { print $3}}'|grep $INDEXPATTERN)
for SOURCE in $indexes
do
  echo $SOURCE

DESTINATION=$(echo $SOURCE | sed "s/$INDEXPATTERN/$NEWINDEXPATTERN/")

echo $DESTINATION

if [[ -n $TYPE ]] 
then
TYPECODE=`echo -e ,\"type\" : \"${TYPE}\"`
echo ${TYPECODE}
fi



curl -XPOST "$ELKHOSTPORT/_reindex" -H 'Content-Type: application/json' -d"
{
  \"source\": {
    \"index\": \"${SOURCE}\"
    ${TYPECODE}
  },
  \"dest\": {
    \"index\": \"${DESTINATION}\"
    ${TYPECODE}
  }
}
"


done


```

## Rename index, reindex and take a snap from `type` field







