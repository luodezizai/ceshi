#!/bin/sh

JDBC_IMPORTER_HOME=/data/elasticsearch-jdbc-2.3.3.0
bin=$JDBC_IMPORTER_HOME/bin
lib=$JDBC_IMPORTER_HOME/lib

#num=$(curl -s 'http://resource.adbug.cn/api/v2/getmaxid?type=2')

echo '
{
    "type" : "jdbc",
    "jdbc" : {
        "url" : "jdbc:mysql://rm-bp1c5x1rhig246p88.mysql.rds.aliyuncs.com:3306/adbugnew",
        "user" : "adbug",
        "password" : "2YeoyszrQoUhzubO",
        "sql" : "select main_index.*,main_index.index_id as _id from main_index JOIN addata_2018 as a on a.id=main_index.id  where main_index.index_id<=12844526",
        "index" : "main_index_v7",
        "type" : "main_index",
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
