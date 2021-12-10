#!/bin/bash
FILE=$ORACLE_BASE/oradata/dbconfig/$ORACLE_SID/PC_INSTALLED
if [ ! -f "$FILE" ]; then
    PC_VERSION=2.0.1
    curl -L -o $ORACLE_BASE/scotas-pc-bin-$PC_VERSION.zip \
        https://github.com/scotas/pc/releases/download/v${PC_VERSION}/scotas-pc-bin-$PC_VERSION.zip
    unzip $ORACLE_BASE/scotas-pc-bin-$PC_VERSION.zip -d $ORACLE_BASE
    rm -f $ORACLE_BASE/scotas-pc-bin-$PC_VERSION.zip
fi
