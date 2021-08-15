#!/bin/bash
FILE=$ORACLE_BASE/oradata/dbconfig/$ORACLE_SID/PC_INSTALLED
if [ ! -f "$FILE" ]; then
    yum -y --enablerepo ol7_optional_latest install ant ant-contrib ant-junit apache-ivy
    yum clean all
    PC_VERSION=2.0.0
    curl -L -o $ORACLE_BASE/scripts/setup/scotas-pc-bin-$PC_VERSION.zip \
        https://github.com/scotas/pc/releases/download/v${PC_VERSION}/scotas-pc-bin-$PC_VERSION.zip
    unzip $ORACLE_BASE/scripts/setup/scotas-pc-bin-$PC_VERSION.zip -d $ORACLE_BASE/scripts/setup
    rm -f $ORACLE_BASE/scripts/setup/scotas-pc-bin-$PC_VERSION.zip
fi
