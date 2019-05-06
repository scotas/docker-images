#!/bin/bash
FILE=$ORACLE_BASE/oradata/dbconfig/$ORACLE_SID/PC_INSTALLED
if [ ! -f "$FILE" ]; then
    rm -rf $ORACLE_BASE/scripts/setup/pc
    echo "pc 18cXE 2.0.0 installed" > "$FILE"
fi
