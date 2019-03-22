#!/bin/sh

JDBC_IMPORTER_HOME=/data/elasticsearch-jdbc-2.3.3.0
bin=$JDBC_IMPORTER_HOME/bin
lib=$JDBC_IMPORTER_HOME/lib


num=$(curl -s 'http://resource.adbug.cn/api/v3/getmaxid?type=10')

echo '
{
    "type" : "jdbc",
    "jdbc" : {
        "url" : "jdbc:mysql://rm-bp1c5x1rhig246p88.mysql.rds.aliyuncs.com:3306/adbugnew",
        "user" : "adbug",
        "password" : "2YeoyszrQoUhzubO",
        "sql" : [ { 
          "statement" : "SELECT addata.id,addata.id as _id,IF((addata.platform=\"\" || addata.platform is NULL) || (addata.platform=1 && (addata.attribute07=\"\" || addata.attribute07 is NULL || left(addata.attribute07,1)!=\"{\" || right(addata.attribute07,1)!=\"}\")) || (addata.platform=2),\"{'width':0,'height':0}\",addata.attribute07) as attribute07 from addata WHERE addata.id>?",
          "parameter" : '${num}'
        } ],
        "index" : "addata_attr7",
        "type" : "addata_index",
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
