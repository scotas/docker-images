#!/bin/bash
cd $ORACLE_HOME/rdbms/admin
su -p oracle -c "sqlplus / as sysdba <<EOF
@utltcp.sql
EOF"
su -p oracle -c "sqlplus / as sysdba <<EOF
@utlhttp.sql
EOF"
cd $ORACLE_BASE/scripts/setup/pc
su -p oracle -c "ant -Ddba.usr=sys -Ddba.pwd=$ORACLE_PWD -Ddb.str=XE install-pc"
export SOLR_HOST=${SOLR_HOST:-"solr"}
export SOLR_PORT=${SOLR_PORT:-"8983"}
su -p oracle -c "sqlplus / as sysdba <<EOF
@db/change-deployment-server.plb solr $SOLR_HOST $SOLR_PORT
EOF"
