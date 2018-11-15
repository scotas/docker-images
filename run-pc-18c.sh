#!/bin/bash
docker run -d --name pc --hostname pc \
-e ORACLE_PWD=Oracle_2018 \
-e SOLR_HOST=solr \
-e SOLR_PORT=8983 \
--link solr \
-p 1521:1521 -p 8080:8080 \
-v $PWD/pc-18cXE:/opt/oracle/scripts/setup \
-v /home/data/db/xe-18c-pc:/opt/oracle/oradata \
oracle/database:18.4.0-xe
