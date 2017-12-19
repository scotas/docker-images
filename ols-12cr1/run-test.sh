#!/bin/bash
docker run -d --privileged=true --name ols-test --hostname ols-test --shm-size=1g \
-p 1521:1521 -p 5500:5500 -p 9099:9099 \
-e ORACLE_SID=TEST \
-e ORACLE_PDB=PDB1 \
-e ORACLE_PWD="Oracle!2017" \
-v /etc/timezone:/etc/timezone:ro -e TZ="America/Argentina/Buenos_Aires" \
-v ols-test-2.0.1:/opt/oracle/oradata \
ols-official:2.0.1
