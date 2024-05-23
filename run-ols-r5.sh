#!/bin/bash
docker run -d \
--name test19c --hostname ols \
-e ORACLE_PWD=Oracle_2024 \
-e ORACLE_SID=ORCLCDB \
-e ORACLE_PDB=ORCLPDB1 \
-p 1521:1521 -p 8080:8080 -p 9099:9099 \
-v "$PWD/ols-scripts-r5:/opt/oracle/scripts/setup" \
-v "$PWD/oradata:/opt/oracle/oradata" \
oracle/database:19.3.0-ee
