#!/bin/sh

JDBC_IMPORTER_HOME=/data/elasticsearch-jdbc-2.3.3.0
bin=$JDBC_IMPORTER_HOME/bin
lib=$JDBC_IMPORTER_HOME/lib


num=$(curl -s 'http://resource.adbug.cn/api/v3/getmaxid?type=9')

echo '
{
    "type" : "jdbc",
    "jdbc" : {
        "url" : "jdbc:mysql://rm-bp1c5x1rhig246p88.mysql.rds.aliyuncs.com:3306/adbugnew",
        "user" : "adbug",
        "password" : "2YeoyszrQoUhzubO",
        "sql" : [ { 
          "statement" : "SELECT id,id as _id,ad_id,md5,subject_md5,advertiser,advertiser as advertiser_na,trackers,trackers as trackers_na,CONCAT(\"[\",replace(trackers_list,\";\",\",\"),\"]\") as tracker_list,tags ,tags as tags_na,CONCAT(\"[\",replace(tags,\";\",\",\"),\"]\") as tag_list,publisher,publisher as publisher_na,width,height,wharea,role,date5,title,size,type,shape,score,platform,ids_items,max_ids_items,screen_ratio,area_ratio,range_type,created_date from addata_rank_role where id>?",
          "parameter" : '${num}'
        } ],
        "index" : "rank_role_v9",
        "type" : "addata_index",
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
