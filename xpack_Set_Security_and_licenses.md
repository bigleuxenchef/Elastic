---
Title | Author | Date 
---|---|---
Elasticsearch x-pack security |Rumi | ** June 2018**
---

# Xpack security

## Pre-requisite for the very first time

- have a valid license file
- make sure xpack secutiry is off




## Setup licenses

using Postman or curl, on my side I have used both but postman is very convenient as all request can be saved and reuse easily across environment. As elastic provides almost unlimited dev license unless you pay for a production environment, it will happen very often that you will spin up a new instance, upgrade or reinstall. In few click the installation is done!

### Step 1 : load elasticsearch cluster in a green state
```curl
curl -X GET \
  http://MBP15.local:9200/_cluster/health?pretty
```

It should return something like:

```json
{
  "cluster_name" : "elasticsearch_rumi",
  "status" : "green",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 1778,
  "active_shards" : 1778,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 0,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 100.0
}
```

### Step 2 : Load the license file

```curl
curl -X PUT \
>   http://MBP15.local:9200/_xpack/license \
> -H 'Content-Type: application/json' \
> -d '{"license":{"uid":"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX","type":"platinum","issue_date_in_millis":1515715200000,"expiry_date_in_millis":1547251199999,"max_nodes":3,"issued_to":"Coolest company (non-production environments)","issuer":"joe doe","signature":"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX","start_date_in_millis":1515715200000}'
```

It should return something like :

```json
{"acknowledged":true,"license_status":"valid"}
```

### step 3 : acknowledge the license

```curl
curl -X PUT \
>   'http://MBP15.local:9200/_xpack/license?acknowledge=true' \
> -H 'Content-Type: application/json' \
> -d '{"license":{"uid":"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX","type":"platinum","issue_date_in_millis":1515715200000,"expiry_date_in_millis":1547251199999,"max_nodes":3,"issued_to":"Coolest company (non-production environments)","issuer":"joe doe","signature":"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX","start_date_in_millis":1515715200000}'
```

It should return something like:

```json
{"acknowledged":true,"license_status":"valid"}
```


### step 4 : setup xpack security

- stop elaticsearch
- edit `elasticsearch.yml` and add the following :

    ```bash
    xpack.security.enabled: true
    xpack.security.http.ssl.enabled: true
    ```
- reload elasticsearch
- wait until green status
- Setup the password
    ```bash
    bin/x-pack/setup-passwords auto|interactive
    ```
# X-PACK security on docker.

Let's assume we do not have ssh in place and we have never setup license and security before.

Start docker container with security off

``` docker exec -i -t <container of elastisearch node 1> /bin/bash```











