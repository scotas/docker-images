#!/bin/bash
docker run -d --privileged=true --name ols --hostname ols --shm-size=1g \
-p 1521:1521 -p 5500:5500 -p 9099:9099 \
-e ORACLE_SID=TEST \
-e ORACLE_PDB=PDB1 \
-e ORACLE_PWD='Oracle2017!' \
-v /home/data/db/ols:/opt/oracle/oradata \
ols-official:2.0.3
