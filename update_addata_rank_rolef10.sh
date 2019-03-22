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
          "statement" : "SELECT ar.id,ar.id as _id,a.parent_area as a_p_area,a.child_area as a_c_area, p.parent_area as p_p_area,p.child_area as p_c_area , ar.ad_id,ar.md5,ar.subject_md5,ar.advertiser,ar.advertiser as advertiser_na,ar.trackers,ar.trackers as trackers_na,CONCAT(\"[\",replace(ar.trackers_list,\";\",\",\"),\"]\") as tracker_list,ar.tags ,ar.tags as tags_na,CONCAT(\"[\",replace(ar.tags,\";\",\",\"),\"]\") as tag_list,ar.publisher,ar.publisher as publisher_na,ar.width,ar.height,ar.wharea,ar.role,ar.date5,ar.title,ar.size,ar.type,ar.shape,ar.score,ar.platform,ar.ids_items,ar.max_ids_items,ar.screen_ratio,ar.area_ratio,ar.range_type,ar.created_date from addata_rank_role as ar LEFT JOIN domains as a ON a.host= ar.advertiser LEFT JOIN domains as p ON p.host= ar.publisher where ar.id>?",
          "parameter" : '${num}'
        } ],
        "index" : "rank_role_v10",
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
