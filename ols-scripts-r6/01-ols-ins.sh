#!/bin/bash
OLS_VERSION=2.0.6
ANT_VERSION=1.10.18
ANT_CONTRIB_VERSION=1.0b3

export ANT_HOME=$HOME/apache-ant-"$ANT_VERSION"
export JAVA_HOME=$ORACLE_HOME/jdk

export PATH=$JAVA_HOME/bin:$ANT_HOME/bin:$ORACLE_HOME/bin:$ORACLE_HOME/OPatch/:/usr/sbin:$PATH
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/usr/lib
export CLASSPATH=$ANT_HOME/lib:$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib

# Install OLS
cd $HOME
echo "ORACLE PASSWORD FOR SYS, SYSTEM AND PDBADMIN: $ORACLE_PASSWORD";

echo "Increase JOB_QUEUE_PROCESSES and set trace for OLS, Refer to Mos Note KB859740.1 for more details"
sqlplus / as sysdba <<EOF
ALTER SYSTEM SET JOB_QUEUE_PROCESSES = 50 SCOPE=BOTH;
ALTER SYSTEM SET EVENT = '29580 trace name context forever, level 4' SCOPE = SPFILE;
EOF

echo "Installing OLS..."
cd $HOME/ols;ant -Ddba.usr=sys -Ddba.pwd=$ORACLE_PASSWORD -Ddb.str=${ORACLE_PDB:-FREEPDB1} install-ols >$HOME/install-OLS.log 2>$HOME/install-OLS.err
ant -Ddba.usr=sys -Ddba.pwd=$ORACLE_PASSWORD -Ddb.str=${ORACLE_PDB:-FREEPDB1} enable-jobs
echo "OLS installed see $HOME/install-OLS.log and $HOME/install-OLS.err files for details"

echo "look LUCENE user"
sqlplus sys/$ORACLE_PASSWORD@${ORACLE_PDB:-FREEPDB1} as sysdba <<EOF
ALTER USER LUCENE NO AUTHENTICATION;
EOF

echo "$OLS_VERSION" > $ORACLE_BASE/oradata/$ORACLE_SID/OLS_IS_INSTALLED
echo "OLS Installed OK...."
