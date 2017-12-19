#!/bin/bash
docker run -d --shm-size=1g --name pc --hostname pc \
-e ORACLE_PWD=oracle \
-e SOLR_HOST=solr \
-e SOLR_PORT=8983 \
--link solr \
-p 1521:1521 -p 8080:8080 \
-v $PWD/pc-11gXE:/u01/app/oracle/scripts/setup \
-v pc-1.2.0:/u01/app/oracle/oradata \
oracle/database:11.2.0.2-xe
