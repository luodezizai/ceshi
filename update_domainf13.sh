#!/bin/sh

JDBC_IMPORTER_HOME=/data/elasticsearch-jdbc-2.3.3.0
bin=$JDBC_IMPORTER_HOME/bin
lib=$JDBC_IMPORTER_HOME/lib



echo '
{
    "type" : "jdbc",
    "jdbc" : {
        "url" : "jdbc:mysql://rm-bp1c5x1rhig246p88.mysql.rds.aliyuncs.com:3306/adbugnew",
        "user" : "adbug",
        "password" : "2YeoyszrQoUhzubO",
        "sql" : [ { 
          "statement" : "select domains.*,domains.id as _id,domains.cname as cname_no,domains.host as host_no,host_meta.description from domains LEFT JOIN host_meta on host_meta.host=domains.host WHERE domains.id>?",
          "parameter" : '${1}'
        } ],
        "index" : "domain_v13",
        "type" : "domain_index",
        "elasticsearch" : {
            "cluster" : "adbuges2",
            "host" : "192.168.1.58",
            "port" : 9300
        }
    }
}
' | java \
    -cp "${lib}/*" \
    -Dlog4j.configurationFile=${bin}/log4j2.xml \
    org.xbib.tools.Runner \
    org.xbib.tools.JDBCImporter
