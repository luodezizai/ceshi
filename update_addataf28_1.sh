#!/bin/sh

JDBC_IMPORTER_HOME=/data/elasticsearch-jdbc-2.3.3.0
bin=$JDBC_IMPORTER_HOME/bin
lib=$JDBC_IMPORTER_HOME/lib


num=${1}

echo '
{
    "type" : "jdbc",
    "jdbc" : {
        "url" : "jdbc:mysql://rm-bp1c5x1rhig246p88.mysql.rds.aliyuncs.com:3306/adbugnew",
        "user" : "adbug",
        "password" : "2YeoyszrQoUhzubO",
        "sql" : [ { 
          "statement" : "SELECT addata.id,a.parent_area as p_p_area,a.child_area as p_c_area ,b.parent_area as a_p_area,b.child_area as a_c_area ,c.parent_area as t_p_area,c.child_area as t_c_area,(CASE WHEN u.risk_4=1 OR u.risk_1=1 OR u.risk_2=1 OR u.risk_3=1 THEN 1 ELSE 0 END ) as risk ,addata.tags as tags,CONCAT(\"[\",t.tags,\"]\") as tags_list,CONCAT(\"[\",t.trackers_list,\"]\") as tracker_list,addata.width/addata.height as whdivided,addata.advertiser as advertiser_na,addata.publisher as publisher_na,addata.trackers as tracker_na,addata.attribute08,addata.attribute06,(CASE WHEN (addata.title=\"\" OR addata.title=NULL) AND FIND_IN_SET(addata.domain,is_ott()) > 0  THEN o.title ELSE addata.title END ) as title_no,addata.id as _id,addata.width * addata.height as wharea,main_index.`subject`,addata.url,addata.session_id,addata.volume,addata.material,addata.screen,addata.url_md5,a.publisher_advertiser,main_index.ranker as ad_rank,b.tracker_subjects,b.role,b.host as domain_host,b.brand_ads,b.publisher_ads,b.tracker_advertiser,b.brand_subjects,b.tracker_ads,d.title as subject_title,d.md5 as subject_md5,addata.advertiser,addata.trackers, addata.publisher,addata.platform, addata.type,addata.created_date,FROM_UNIXTIME(addata.created_date/1000,\"%Y-%m-%d %H:%i:%s\") as date5,addata.shape,addata.domain,addata.attribute04,addata.width,addata.height ,addata.size,addata.x,addata.y,IF(LEFT(addata.target_url,1)=\"{\" || RIGHT(addata.target_url,1)=\"}\",\"\",addata.target_url) as target_url,addata.thumbnail,addata.last_seen,addata.md5,addata.thumb_width,addata.thumb_height,addata.original_url,addata.thumb_url,addata.share_url, (CASE WHEN (addata.title=\"\" OR addata.title=NULL) AND FIND_IN_SET(addata.domain,is_ott()) > 0  THEN o.title ELSE addata.title END ) as title,b.host as advertiser_name, concat(IFNULL(b.cname,\"\"), IFNULL(b.ename,\"\")) as advertiser_name_title, concat(b.host, \" \", concat(IFNULL(b.cname,\"\"), IFNULL(b.ename,\"\"))) as advertiser_full,  a.host as publisher_name,  concat(a.host, \" \", concat(IFNULL(a.cname,\"\"), IFNULL(a.ename,\"\"))) as publisher_full, c.host as tracker_name, concat(c.host, \" \", concat(IFNULL(c.cname,\"\"), IFNULL(c.ename,\"\"))) as tracker_full, d.rank as subject_rand FROM addata LEFT JOIN main_index on addata.id = main_index.id LEFT JOIN addata_tags as t ON (addata.id = t.id) LEFT JOIN addata_ott as o on addata.id = o.ad_id LEFT JOIN subjects as d ON (d.id = main_index.subject) LEFT JOIN domains as a ON (a.id = main_index.publisher) LEFT JOIN domains as b ON (b.id = main_index.advertiser) LEFT JOIN domains as c ON (c.id = main_index.tracker) LEFT JOIN original_urls AS u ON (u.md5=addata.url_md5) WHERE addata.id>?",
          "parameter" : '${num}'
        } ],
        "index" : "addata_v28",
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
