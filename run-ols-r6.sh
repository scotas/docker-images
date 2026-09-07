#!/bin/bash
docker run -d \
--name test26ai --hostname ols \
-e ORACLE_PASSWORD=Oracle_2026 \
-e ORACLE_SID=FREE \
-e ORACLE_PDB=FREEPDB1 \
-p 2521:1521 -p 8080:8080 -p 9099:9099 \
-v "$PWD/ols-scripts-r6:/container-entrypoint-initdb.d/" \
gvenzl/oracle-free:23.26.2-full
