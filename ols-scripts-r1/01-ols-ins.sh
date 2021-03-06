#!/bin/bash
ANT_VERSION=1.9.11

export ANT_HOME=/home/oracle/apache-ant-"$ANT_VERSION"
export JAVA_HOME=$ORACLE_HOME/jdk

export PATH=$JAVA_HOME/bin:$ANT_HOME/bin:$ORACLE_HOME/bin:$ORACLE_HOME/OPatch/:/usr/sbin:$PATH
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/usr/lib
export CLASSPATH=$ANT_HOME/lib:$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib

# Install OLS
echo "ORACLE PASSWORD FOR SYS, SYSTEM AND PDBADMIN: $ORACLE_PWD";
echo "Patching ODCI library..."
mv $ORACLE_HOME/rdbms/jlib/ODCI.jar $ORACLE_HOME/rdbms/jlib/ODCI.jar.orig
cp /home/oracle/ODCI.jar $ORACLE_HOME/rdbms/jlib/
$ORACLE_HOME/perl/bin/perl $ORACLE_HOME/rdbms/admin/catcon.pl -d $ORACLE_HOME/rdbms/admin -b initsoxx_output initsoxx.sql
echo "ODCI patched"

echo "Installing OLS..."
cd ols;ant -Ddba.usr=sys -Ddba.pwd=$ORACLE_PWD -Ddb.str=$ORACLE_PDB install-ols >/home/oracle/install-OLS.log 2>/home/oracle/install-OLS.err
echo "OLS installed see /home/oracle/install-OLS.log and /home/oracle/install-OLS.err files for details"

touch $ORACLE_BASE/oradata/$ORACLE_SID/OLS_IS_INSTALLED
echo "OLS Installed OK...."
