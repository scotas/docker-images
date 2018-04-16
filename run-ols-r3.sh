#!/bin/bash
docker run -d -v /dev/shm --tmpfs /dev/shm:rw,nosuid,nodev,exec,size=1g \
--name test18c --hostname test18c \
-e ORACLE_PWD=Oracle_2017 \
-e ORACLE_SID=TEST \
-e ORACLE_PDB=PDB1 \
-p 1521:1521 -p 8080:8080 -p 9099:9099 \
-v $PWD/ols-scripts-r3:/scratch/app/user/scripts/setup \
-v /home/data/db/test18c:/scratch/app/user/oradata \
oracle/database:18.0.0.0-ee
