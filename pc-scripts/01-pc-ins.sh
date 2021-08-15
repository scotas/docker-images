#!/bin/bash
FILE=$ORACLE_BASE/oradata/dbconfig/$ORACLE_SID/PC_INSTALLED
PC_VERSION=2.0.1
ANT_VERSION=1.10.11
ANT_CONTRIB_VERSION=1.0b3
export ANT_HOME=/home/oracle/apache-ant-"$ANT_VERSION"
export JAVA_HOME=$ORACLE_HOME/jdk

export PATH=$JAVA_HOME/bin:$ANT_HOME/bin:$ORACLE_HOME/bin:$ORACLE_HOME/OPatch/:/usr/sbin:$PATH
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/usr/lib
export CLASSPATH=$ANT_HOME/lib:$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib

if [ ! -f "$FILE" ]; then
    cd /home/oracle/pc
    ant -Ddba.usr=sys -Ddba.pwd=$ORACLE_PWD -Ddb.str=${ORACLE_PDB:-XEPDB1} install-pc
    export SOLR_HOST=${SOLR_HOST:-"solr"}
    export SOLR_PORT=${SOLR_PORT:-"8983"}
    sqlplus / as sysdba <<EOF
ALTER SESSION SET CONTAINER = ${ORACLE_PDB:-XEPDB1};
ALTER USER PC NO AUTHENTICATION;
@db/change-deployment-server.plb solr $SOLR_HOST $SOLR_PORT
EOF

fi
