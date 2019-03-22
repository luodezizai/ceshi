#!/bin/sh

JDBC_IMPORTER_HOME=/data/elasticsearch-jdbc-2.3.3.0
bin=$JDBC_IMPORTER_HOME/bin
lib=$JDBC_IMPORTER_HOME/lib

echo '
{
    "type" : "jdbc",
    "jdbc" : {
        "url" : "jdbc:mysql://192.168.1.24:3306/adbug",
        "user" : "ooM10",
        "password" : "Y5djQBVpHPWYH9tZ",
        "sql" : [ { 
          "statement" : "SELECT id,id as _id,FROM_UNIXTIME(created_date/1000,\"%Y%m%d%H\") as date_hour_long,FROM_UNIXTIME(created_date/1000,\"%Y%m\") as date_mouth_long,FROM_UNIXTIME(created_date/1000,\"%Y%m%d\") as date_day_long,x,y,width,height,thumb_width,thumb_height,size,domain,domain as domain_na,title,title as title_na,metas,tags,tags as tags_na,trackers,trackers as trackers_na,replace(trackers,\";\",\",\") as tracker_list,type,original_url,IF(LOCATE(\"biz_id\",target_url),\"\",target_url) as target_url ,thumb_url,share_url,thumbnail,audit,status,views,modified_date,machine_location,machine_ip,shape,advertiser,advertiser as advertiser_na,publisher,publisher as publisher_na,parent,platform,screen_width,screen_height,body_width,body_height,depth,iframes,attribute04,attribute05,attribute06 ,created_date,FROM_UNIXTIME(created_date/1000,\"%Y\") as date_year,FROM_UNIXTIME(created_date/1000,\"%Y-%m\") as date_mouth,FROM_UNIXTIME(created_date/1000,\"%Y-%m-%d\") as date_day,FROM_UNIXTIME(created_date/1000,\"%Y-%m-%d %H\") as date_hour,FROM_UNIXTIME(created_date/1000,\"%Y-%m-%d %H:%i\") as date_minute,FROM_UNIXTIME(created_date/1000,\"%Y-%m-%d %H:%i:%s\") as date,FROM_UNIXTIME(last_seen/1000,\"%Y-%m-%d %H:%i:%s\") as last_seen_date,md5(CONCAT(title,advertiser)) as subject_md5,last_seen,md5 from addata_mid where addata_mid.id>?",
          "parameter" : '${1}'
        } ],
        "index" : "addata_aggs_v2",
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
