#!/bin/bash
FILE=$ORACLE_BASE/oradata/dbconfig/$ORACLE_SID/PC_INSTALLED
PC_VERSION=2.0.1
ANT_VERSION=1.10.11
ANT_CONTRIB_VERSION=1.0b3
if [ ! -f "$FILE" ]; then
    curl -L -o /home/oracle/scotas-pc-bin-$PC_VERSION.zip \
        https://github.com/scotas/pc/releases/download/v${PC_VERSION}/scotas-pc-bin-$PC_VERSION.zip
    curl -s -L -o /home/oracle/apache-ant-"$ANT_VERSION"-bin.zip https://www-us.apache.org/dist/ant/binaries/apache-ant-"$ANT_VERSION"-bin.zip
    curl -s -L -o /home/oracle/ant-contrib-"$ANT_CONTRIB_VERSION"-bin.zip https://sourceforge.net/projects/ant-contrib/files/ant-contrib/"$ANT_CONTRIB_VERSION"/ant-contrib-"$ANT_CONTRIB_VERSION"-bin.zip/download
    unzip /home/oracle/scotas-pc-bin-$PC_VERSION.zip -d /home/oracle/
    unzip /home/oracle/apache-ant-"$ANT_VERSION"-bin.zip -d /home/oracle/
    unzip /home/oracle/ant-contrib-"$ANT_CONTRIB_VERSION"-bin.zip -d /home/oracle/
    rm -f /home/oracle/scotas-pc-bin-$PC_VERSION.zip
    rm -f /home/oracle/apache-ant-"$ANT_VERSION"-bin.zip
    rm -f /home/oracle/ant-contrib-"$ANT_CONTRIB_VERSION"-bin.zip
fi
