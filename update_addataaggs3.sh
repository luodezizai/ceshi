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
          "statement" : "SELECT addata_mid.id,addata_mid.id as _id,a.parent as a_p_area,a.child as a_c_area,p.parent as p_p_area,p.child as p_c_area,FROM_UNIXTIME(addata_mid.created_date/1000,\"%Y%m%d%H\") as date_hour_long,FROM_UNIXTIME(addata_mid.created_date/1000,\"%Y%m\") as date_mouth_long,FROM_UNIXTIME(addata_mid.created_date/1000,\"%Y%m%d\") as date_day_long,addata_mid.x,addata_mid.y,addata_mid.width,addata_mid.height,addata_mid.thumb_width,addata_mid.thumb_height,addata_mid.size,addata_mid.domain,addata_mid.domain as domain_na,addata_mid.title,addata_mid.title as title_na,addata_mid.metas,addata_mid.tags,addata_mid.tags as tags_na,addata_mid.trackers,addata_mid.trackers as trackers_na,replace(trackers,\";\",\",\") as tracker_list,addata_mid.type,addata_mid.original_url,addata_mid.target_url,addata_mid.thumb_url,addata_mid.share_url,addata_mid.thumbnail,addata_mid.audit,addata_mid.status,addata_mid.views,addata_mid.modified_date,addata_mid.machine_location,addata_mid.machine_ip,addata_mid.shape,addata_mid.advertiser,addata_mid.advertiser as advertiser_na,addata_mid.publisher,addata_mid.publisher as publisher_na,addata_mid.parent,addata_mid.platform,addata_mid.screen_width,addata_mid.screen_height,addata_mid.body_width,addata_mid.body_height,addata_mid.depth,addata_mid.iframes,addata_mid.attribute04,addata_mid.attribute05,addata_mid.attribute06 ,addata_mid.created_date,FROM_UNIXTIME(addata_mid.created_date/1000,\"%Y\") as date_year,FROM_UNIXTIME(addata_mid.created_date/1000,\"%Y-%m\") as date_mouth,FROM_UNIXTIME(addata_mid.created_date/1000,\"%Y-%m-%d\") as date_day,FROM_UNIXTIME(addata_mid.created_date/1000,\"%Y-%m-%d %H\") as date_hour,FROM_UNIXTIME(addata_mid.created_date/1000,\"%Y-%m-%d %H:%i\") as date_minute,FROM_UNIXTIME(addata_mid.created_date/1000,\"%Y-%m-%d %H:%i:%s\") as date,FROM_UNIXTIME(addata_mid.last_seen/1000,\"%Y-%m-%d %H:%i:%s\") as last_seen_date,md5(CONCAT(addata_mid.title,addata_mid.advertiser)) as subject_md5,addata_mid.last_seen,addata_mid.md5 from addata_mid LEFT JOIN domain_area_new as a on addata_mid.advertiser = a.host LEFT JOIN domain_area_new as p on addata_mid.publisher = p.host where addata_mid.id>?",
          "parameter" : '${1}'
        } ],
        "index" : "addata_aggs_v3",
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
