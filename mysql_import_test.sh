#!/bin/sh
JDBC_IMPORTER_HOME=/data/elasticsearch-jdbc-2.3.3.0
bin=$JDBC_IMPORTER_HOME/bin
lib=$JDBC_IMPORTER_HOME/lib
echo '{
    "type" : "jdbc",
    "jdbc" : {
        "url" : "jdbc:mysql://60.191.192.213:3306/zamplus",
        "user" : "ding",
        "password" : "CSnw3uBeE53MQXYZ",
        "sql" : "select *,id as _id from 732_log_2",
        "index" : "zamplus",
        "type" : "723_log",
        "metrics" : {
            "enabled" : true
        },
        "elasticsearch" : {
            "cluster" : "adbuges",
            "host" : ["192.168.1.1","192.168.1.2"],
            "port" : 9300
        }
    }
}' | java \
       -cp "${lib}/*" \
       -Dlog4j.configurationFile=${bin}/log4j2.xml \
       org.xbib.tools.Runner \
       org.xbib.tools.JDBCImporter
