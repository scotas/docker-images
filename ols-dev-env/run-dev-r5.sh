#!/bin/bash
docker run -ti --rm --name dev-r5 --hostname dev --link 19c:db \
-v /home/oracle/github/ols:/home/ols \
ols-dev:2.0.5
