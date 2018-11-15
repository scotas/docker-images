#!/bin/bash
cd $ORACLE_BASE/scripts/setup/pc
su -p oracle -c "ant -Ddba.usr=sys -Ddba.pwd=$ORACLE_PWD -Ddb.str=${ORACLE_PDB:-XEPDB1} install-pc"
export SOLR_HOST=${SOLR_HOST:-"solr"}
export SOLR_PORT=${SOLR_PORT:-"8983"}
su -p oracle -c "sqlplus / as sysdba <<EOF
ALTER SESSION SET CONTAINER = ${ORACLE_PDB:-XEPDB1};
@db/change-deployment-server.plb solr $SOLR_HOST $SOLR_PORT
EOF"
