#!/bin/bash
docker run -d -v /dev/shm --tmpfs /dev/shm:rw,nosuid,nodev,exec,size=1g \
--name test-ols --hostname test-ols \
-e ORACLE_PWD=Oracle_2017 \
-e ORACLE_SID=TEST \
-e ORACLE_PDB=PDB1 \
-p 1521:1521 -p 8080:8080 -p 9099:9099 \
-v $PWD/ols-scripts-r1:/opt/oracle/scripts/setup \
-v test-ols-2.0.1:/opt/oracle/oradata \
oracle/database:12.1.0.2-ee
