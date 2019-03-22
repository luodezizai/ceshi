#!/bin/sh
if [[ $# -lt 1 ]]; then
  echo "Usage: "$0" <cid>"
  exit
fi
cid=$1
JDBC_IMPORTER_HOME=/data/elasticsearch-jdbc-2.3.3.0
bin=$JDBC_IMPORTER_HOME/bin
lib=$JDBC_IMPORTER_HOME/lib
echo '{
    "type" : "jdbc",
    "jdbc" : {
        "url" : "jdbc:mysql://192.168.1.43:3306/fraud",
        "user" : "root",
        "password" : "1qaz2wsx",
        "sql" : "select *,id as _id,ip_lat as \"location.lat\", ip_lon as \"location.lon\" from fraud_'${cid}'",
        "index" : "summary_'${cid}'",
        "type" : "log",
        "metrics" : {
            "enabled" : true
        },
        "type_mapping" : {
            "log" : {
                "properties" : {
                     "other_ip" : {
                         "type" : "ip"
                     },
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
