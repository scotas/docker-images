#!/bin/bash
OLS_VERSION=2.0.1
ANT_VERSION=1.9.11
ANT_CONTRIB_VERSION=1.0b3
curl -s -o /home/oracle/apache-ant-"$ANT_VERSION"-bin.zip http://www-us.apache.org/dist/ant/binaries/apache-ant-"$ANT_VERSION"-bin.zip
curl -s -L -o /home/oracle/ant-contrib-"$ANT_CONTRIB_VERSION"-bin.zip https://sourceforge.net/projects/ant-contrib/files/ant-contrib/"$ANT_CONTRIB_VERSION"/ant-contrib-"$ANT_CONTRIB_VERSION"-bin.zip/download

curl -s -o /home/oracle/valid.ols http://www.scotas.com/download/ols/valid.ols
curl -s -o /home/oracle/lucene-ols-bin-"$OLS_VERSION".zip http://www.scotas.com/download/ols/lucene-ols-bin-"$OLS_VERSION".zip
curl -s -o /home/oracle/ODCI.jar http://www.scotas.com/download/ols/ODCI.jar
unzip /home/oracle/lucene-ols-bin-"$OLS_VERSION".zip -d /home/oracle/
unzip /home/oracle/apache-ant-"$ANT_VERSION"-bin.zip -d /home/oracle/
unzip /home/oracle/ant-contrib-"$ANT_CONTRIB_VERSION"-bin.zip -d /home/oracle/
cp /home/oracle/ant-contrib/ant-contrib-"$ANT_CONTRIB_VERSION".jar /home/oracle/apache-ant-"$ANT_VERSION"/lib
cp /home/oracle/valid.ols /home/oracle/ols/bin/com/scotas/license
mkdir -p $ORACLE_HOME/jdbc/lib/
cp $ORACLE_HOME/inventory/Scripts/ext/jlib/ojdbc6.jar $ORACLE_HOME/jdbc/lib/ojdbc6.jar
chmod a+r $ORACLE_HOME/jdbc/lib/ojdbc6.jar
