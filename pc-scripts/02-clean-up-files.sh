#!/bin/bash
FILE=$ORACLE_BASE/oradata/dbconfig/$ORACLE_SID/PC_INSTALLED
if [ ! -f "$FILE" ]; then
    rm -rf /home/oracle/pc
    echo "pc 2.0.1 installed" > "$FILE"
fi
