#!/bin/bash
docker run -ti --rm --name dev-r5-xe --hostname dev --link 18c-xe:db \
-v /home/oracle/github/ols:/home/ols \
ols-dev-xe:2.0.5
