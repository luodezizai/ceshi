#!/bin/sh
JDBC_IMPORTER_HOME=/data/elasticsearch-jdbc-2.3.3.0
bin=$JDBC_IMPORTER_HOME/bin
lib=$JDBC_IMPORTER_HOME/lib
echo '{
    "type" : "jdbc",
    "jdbc" : {
        "url" : "jdbc:mysql://192.168.1.43:3306/fraud",
        "user" : "root",
        "password" : "1qaz2wsx",
        "sql" : "select \"geoips\" as _index, \"iprange\" as _type, id as _id, latitude as \"location.lat\", longitude as \"location.lon\",startIp,endIp,country,region,city,zip,metroCode,areaCode,timeZone,ISP,organization,netspeed,domain from fraud_geoips;",
        "index" : "geoips",
        "type" : "iprange",
        "metrics" : {
            "enabled" : true
        },
        "type_mapping" : {
            "iprange" : {
                "properties" : {
                     "location" : {
                         "type" : "geo_point"
                     }
                }
            }
        },
        "elasticsearch" : {
            "cluster" : "adbuges",
            "host" : ["192.168.1.1","192.168.1.2","192.168.1.4"],
            "port" : 9300
        }
    }
}' | java \
       -cp "${lib}/*" \
       -Dlog4j.configurationFile=${bin}/log4j2.xml \
       org.xbib.tools.Runner \
       org.xbib.tools.JDBCImporter
