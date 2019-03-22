#!/bin/sh
JDBC_IMPORTER_HOME=/data/elasticsearch-jdbc-2.3.3.0
bin=$JDBC_IMPORTER_HOME/bin
lib=$JDBC_IMPORTER_HOME/lib

cat ${bin}/addata_rank_role_configf10.json | java \
    -cp "${lib}/*" \
    -Dlog4j.configurationFile=${bin}/log4j2.xml \
    org.xbib.tools.Runner \
    org.xbib.tools.JDBCImporter





