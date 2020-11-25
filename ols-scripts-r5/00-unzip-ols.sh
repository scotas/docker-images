#!/bin/bash
OLS_VERSION=2.0.5
ANT_VERSION=1.10.9
ANT_CONTRIB_VERSION=1.0b3
curl -s -L -o /home/oracle/apache-ant-"$ANT_VERSION"-bin.zip https://www-us.apache.org/dist/ant/binaries/apache-ant-"$ANT_VERSION"-bin.zip
curl -s -L -o /home/oracle/ant-contrib-"$ANT_CONTRIB_VERSION"-bin.zip https://sourceforge.net/projects/ant-contrib/files/ant-contrib/"$ANT_CONTRIB_VERSION"/ant-contrib-"$ANT_CONTRIB_VERSION"-bin.zip/download

curl -s -o /home/oracle/valid.ols https://www.scotas.com/download/ols/valid.ols
curl -s -o /home/oracle/lucene-ols-bin-"$OLS_VERSION".zip https://www.scotas.com/download/ols/19cR3/lucene-ols-bin-"$OLS_VERSION".zip
curl -s -o /home/oracle/ODCI.jar https://www.scotas.com/download/ols/19cR3/ODCI.jar
curl -s -o /home/oracle/converter.jar https://www.scotas.com/download/ols/19cR3/converter.jar
curl -s -o /home/oracle/translator.jar https://www.scotas.com/download/ols/19cR3/translator.jar
curl -s -o /home/oracle/initsoxx.sql https://www.scotas.com/download/ols/19cR3/initsoxx.sql
unzip -o /home/oracle/lucene-ols-bin-"$OLS_VERSION".zip -d /home/oracle/
unzip -o /home/oracle/apache-ant-"$ANT_VERSION"-bin.zip -d /home/oracle/
unzip -o /home/oracle/ant-contrib-"$ANT_CONTRIB_VERSION"-bin.zip -d /home/oracle/
cp /home/oracle/ant-contrib/ant-contrib-"$ANT_CONTRIB_VERSION".jar /home/oracle/apache-ant-"$ANT_VERSION"/lib
cp /home/oracle/valid.ols /home/oracle/ols/bin/com/scotas/license
rm -f $ORACLE_HOME/jdbc/lib/ojdbc6.jar
ln -s $ORACLE_HOME/jdbc/lib/ojdbc8.jar $ORACLE_HOME/jdbc/lib/ojdbc6.jar
