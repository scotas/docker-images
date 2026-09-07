#!/bin/bash
OLS_VERSION=2.0.6
ANT_VERSION=1.10.17
ANT_CONTRIB_VERSION=1.0b3
curl -s -L -o $HOME/apache-ant-"$ANT_VERSION"-bin.zip https://www.apache.org/dist/ant/binaries/apache-ant-"$ANT_VERSION"-bin.zip
curl -s -L -o $HOME/ant-contrib-"$ANT_CONTRIB_VERSION"-bin.zip https://sourceforge.net/projects/ant-contrib/files/ant-contrib/"$ANT_CONTRIB_VERSION"/ant-contrib-"$ANT_CONTRIB_VERSION"-bin.zip/download

curl -s -L -o $HOME/valid.ols "https://github.com/scotas/ols/releases/download/v$OLS_VERSION/valid.ols"
curl -s -L -o $HOME/lucene-ols-bin-"$OLS_VERSION".zip "https://github.com/scotas/ols/releases/download/v$OLS_VERSION/lucene-ols-bin-$OLS_VERSION.zip"
unzip -o $HOME/lucene-ols-bin-"$OLS_VERSION".zip -d $HOME/
unzip -o $HOME/apache-ant-"$ANT_VERSION"-bin.zip -d $HOME/
unzip -o $HOME/ant-contrib-"$ANT_CONTRIB_VERSION"-bin.zip -d $HOME/
cp $HOME/ant-contrib/ant-contrib-"$ANT_CONTRIB_VERSION".jar $HOME/apache-ant-"$ANT_VERSION"/lib
cp $HOME/valid.ols $HOME/ols/bin/com/scotas/license
rm -f $ORACLE_HOME/jdbc/lib/ojdbc6.jar
ln -s $ORACLE_HOME/jdbc/lib/ojdbc8.jar $ORACLE_HOME/jdbc/lib/ojdbc6.jar
