#!/bin/bash
FILE=$ORACLE_BASE/oradata/dbconfig/$ORACLE_SID/PC_INSTALLED
if [ ! -f "$FILE" ]; then
    rm -rf $ORACLE_BASE/pc
    echo "pc 21cXE 2.0.1 installed" > "$FILE"
fi
