# Bulk Translate on existing index

## Background

> Note
> Many of us use to test technology by generating or building a lot of samples (many variation of "helloworld"). Overtime we end up  having built a toolbox that allow us to assemble rapidly quick use cases. In my learning of elastic I have tried to manipulate my data like production data, I have rarely deleted data (I would not like to say never it would be a little pretentious, but I simply don't remember if I did it). Even though my data may look a little weird, this is my data 😍. I still have 10 version of elastic in my repository and I have always migrated my data, this is the best exercise to get prepared for real production.

# The case!

> One day while I was preparing a demo for my business, I thought I could not show dashboard with data being constantly tagged with weird acronyms or technical terms like it is actually in my sandbox. Then came the idea to change my data and map some key names with business relevant terms.

# Using logstash to remap the data that are already stored in elastic

- Let's assume we have an index pattern called `blueprism.process.completed-*`
- Let's assume we have a field called `processprocessname`
- Lets assume we would like to change the content of `processprocessname` the following way and in the same time for now just recreate a new index (same principal can be apply in simply updating instead of recreacting):

 *"HelloWorld" => "MortgagePayment"
 *"HelloWorld No Delay" => "Payment Cancellation"
 *"10 times Hello World" => "BulkMortgagePayment"
 *"Loop on simple SQL to Rest" => "LoanOnBoarding"
 *"Check Logged In" => "CreditOnBoarding"
 *"Hello World Random" => "MortgagePaymentReversal" 


```json
input {
elasticsearch {
        hosts => "http://${ELKMASTERHOSTNAME}:${ELKMASTERPORT}"
        index => "blueprism.process.completed-*"
        docinfo => true
        query => '{
  "query": {
    "match_all": { }
  },
  "sort": [
    
    {
      "sessionnumber": {
        "order": "asc"
      }
    },
   {
      "seqnum": {
        "order": "asc"
      }
    },
    {
      "_index": {
        "order": "asc"
      }
    }
  ]
  
}'

}

}
filter {
grok{
        match => ["startdatetime", "%{YEAR:[@metadata][filedateYYYY]}[/-]%{MONTHNUM2:[@metadata][filedateMM]}[/-]%{MONTHDAY:[@metadata][filedateDD]}"]
        }
translate {
    field => "processprocessname"
    destination => "processprocessname"
    override => true
    dictionary => {
      "HelloWorld" => "MortgagePayment"
      "HelloWorld No Delay" => "Payment Cancellation"
      "10 times Hello World" => "BulkMortgagePayment"
      "Loop on simple SQL to Rest" => "LoanOnBoarding"
      "Check Logged In" => "CreditOnBoarding"
      "Hello World Random" => "MortgagePaymentReversal"
    }
  }

}
output {
 elasticsearch { 
        hosts => "http://${ELKMASTERHOSTNAME}:${ELKMASTERPORT}"
        index => "blueprism.process.completed-v1-%{[@metadata][filedateYYYY]}-%{[@metadata][filedateMM]}"
        #index => "blueprism.test.-%{[@metadata][filedateYYYY]}-%{[@metadata][filedateMM]}-%{[@metadata][filedateDD]}b"
        document_type => "%{[@metadata][_type]}"
        document_id => "%{[@metadata][_id]}"
        doc_as_upsert => "true"
    }

# display to the console any of the output stream, this can be commented for performance reason
        
 # stdout { codec => rubydebug }
}



```
