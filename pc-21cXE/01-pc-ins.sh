#!/bin/bash
FILE=$ORACLE_BASE/oradata/dbconfig/$ORACLE_SID/PC_INSTALLED
if [ ! -f "$FILE" ]; then
    cd $ORACLE_BASE/pc
    export SOLR_HOST=${SOLR_HOST:-"solr"}
    export SOLR_PORT=${SOLR_PORT:-"8983"}

    sqlplus / as sysdba <<EOF
ALTER SESSION SET CONTAINER = ${ORACLE_PDB:-XEPDB1};
@db/create-user.plb
EOF
    sqlplus / as sysdba <<EOF
ALTER SESSION SET CONTAINER = ${ORACLE_PDB:-XEPDB1};
@db/create-pc-role.plb
EOF
    sqlplus PC/PC@${ORACLE_PDB:-XEPDB1} <<EOF
@db/json_dyn.plb
EOF
    sqlplus PC/PC@${ORACLE_PDB:-XEPDB1} <<EOF
@db/PushConnectorCommonTypes.plb
EOF
    sqlplus PC/PC@${ORACLE_PDB:-XEPDB1} <<EOF
@db/PushConnectorCommonTypes-bdy.plb
EOF
    sqlplus PC/PC@${ORACLE_PDB:-XEPDB1} <<EOF
@db/SolrPushConnector.plb
EOF
    sqlplus PC/PC@${ORACLE_PDB:-XEPDB1} <<EOF
@db/PushConnectorAdm.plb
EOF
    sqlplus PC/PC@${ORACLE_PDB:-XEPDB1} <<EOF
@db/PushConnectorAdm-bdy.plb
EOF
    sqlplus PC/PC@${ORACLE_PDB:-XEPDB1} <<EOF
@db/SolrPushConnector-bdy.plb
EOF
    sqlplus PC/PC@${ORACLE_PDB:-XEPDB1} <<EOF
@db/SolrPushConnectorType.plb
EOF

    sqlplus / as sysdba <<EOF
ALTER SESSION SET CONTAINER = ${ORACLE_PDB:-XEPDB1};
@db/grant-any-job.plb
EOF
    sqlplus / as sysdba <<EOF
ALTER SESSION SET CONTAINER = ${ORACLE_PDB:-XEPDB1};
@db/grant-acls-solr.plb
EOF
    sqlplus / as sysdba <<EOF
ALTER SESSION SET CONTAINER = ${ORACLE_PDB:-XEPDB1};
ALTER USER PC NO AUTHENTICATION;
@db/change-deployment-server.plb solr $SOLR_HOST $SOLR_PORT
EOF

fi
