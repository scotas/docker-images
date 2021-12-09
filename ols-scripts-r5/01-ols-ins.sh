#!/bin/bash
OLS_VERSION=2.0.5
ANT_VERSION=1.10.11
ANT_CONTRIB_VERSION=1.0b3

export ANT_HOME=$HOME/apache-ant-"$ANT_VERSION"
export JAVA_HOME=$ORACLE_HOME/jdk

export PATH=$JAVA_HOME/bin:$ANT_HOME/bin:$ORACLE_HOME/bin:$ORACLE_HOME/OPatch/:/usr/sbin:$PATH
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/usr/lib
export CLASSPATH=$ANT_HOME/lib:$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib

# Install OLS
cd $HOME
echo "ORACLE PASSWORD FOR SYS, SYSTEM AND PDBADMIN: $ORACLE_PWD";
echo "Patching ODCI library..."
mv $ORACLE_HOME/rdbms/jlib/ODCI.jar $ORACLE_HOME/rdbms/jlib/ODCI.jar.orig
mv $ORACLE_HOME/rdbms/admin/initsoxx.sql $ORACLE_HOME/rdbms/admin/initsoxx.sql.orig
cp $HOME/ODCI.jar $HOME/converter.jar $HOME/translator.jar $ORACLE_HOME/rdbms/jlib/
cp $HOME/initsoxx.sql $ORACLE_HOME/rdbms/admin/
$ORACLE_HOME/perl/bin/perl $ORACLE_HOME/rdbms/admin/catcon.pl -d $ORACLE_HOME/rdbms/admin -b initsoxx_output initsoxx.sql
echo "ODCI patched"

echo "Installing OLS..."
cd $HOME/ols;ant -Ddba.usr=sys -Ddba.pwd=$ORACLE_PWD -Ddb.str=${ORACLE_PDB:-ORCLPDB1} install-ols >$HOME/install-OLS.log 2>$HOME/install-OLS.err
echo "OLS installed see $HOME/install-OLS.log and $HOME/install-OLS.err files for details"

sqlplus sys/$ORACLE_PWD@${ORACLE_PDB:-ORCLPDB1} as sysdba <<EOF
ALTER USER LUCENE NO AUTHENTICATION;
EOF

echo "$OLS_VERSION" > $ORACLE_BASE/oradata/$ORACLE_SID/OLS_IS_INSTALLED
echo "OLS Installed OK...."
