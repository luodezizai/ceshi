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
          "statement" : "select s.*,s.id as _id,a.type as type from subjects as s JOIN addata_2018 as a on s.ad_id=a.id where s.id>?",
          "parameter" : '${1}'
        } ],
        "index" : "subject_v5",
        "type" : "subject_index",
        "elasticsearch" : {
            "cluster" : "adbuges2",
            "host" : "192.168.1.47",
            "port" : 9300
        }
    }
}
' | java \
    -cp "${lib}/*" \
    -Dlog4j.configurationFile=${bin}/log4j2.xml \
    org.xbib.tools.Runner \
    org.xbib.tools.JDBCImporter
