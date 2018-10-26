#!/bin/bash
docker run -d -v /dev/shm --tmpfs /dev/shm:rw,nosuid,nodev,exec,size=1g \
--name xe-18c --hostname xe-18c \
-e ORACLE_PWD=Oracle_2018 \
-e ORACLE_SID=XE \
-e ORACLE_PDB=XEPDB1 \
-p 1521:1521 -p 8080:8080 -p 9099:9099 \
-v $PWD/ols-scripts-r4:/opt/oracle/scripts/setup \
-v /home/data/db/xe-18c:/opt/oracle/oradata \
oracle/database:18.4.0-xe
