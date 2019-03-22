#!/bin/sh
JDBC_IMPORTER_HOME=/data/elasticsearch-jdbc-2.3.3.0
bin=$JDBC_IMPORTER_HOME/bin
lib=$JDBC_IMPORTER_HOME/lib
echo '{
    "type" : "jdbc",
    "jdbc" : {
        "url" : "jdbc:mysql://60.191.192.214:3306/node10",
        "user" : "ding",
        "password" : "CSnw3uBeE53MQXYZ",
        "sql" : "select *,uid as _id from 702_log",
        "index" : "702",
        "type" : "702_log",
        "metrics" : {
            "enabled" : true
        },
        "elasticsearch" : {
            "cluster" : "adbuges",
            "host" : ["10.15.1.84","10.15.1.174","10.15.1.56"],
            "port" : 9300
        }
    }
}' | java \
       -cp "${lib}/*" \
       -Dlog4j.configurationFile=${bin}/log4j2.xml \
       org.xbib.tools.Runner \
       org.xbib.tools.JDBCImporter
