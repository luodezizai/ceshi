#!/bin/sh

for (( i = 20000; i < 1000000; i++ )); do
    #statements
    echo '{ "create" : { "_index" : "test", "_type" : "type1", "_id" : "'${i}'" } }
{ "field1" : "value3" }' >> test.json
done

#curl -XPOST es-cn-0pp09r5nv000ekqbw.elasticsearch.aliyuncs.com:9200/shb01/student -d '{"name":"tom","age":21,"info":"tom"}'
