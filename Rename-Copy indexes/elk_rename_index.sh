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




