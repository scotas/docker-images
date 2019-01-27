#!/bin/bash
docker run -ti --rm --name dev-pc-18c --hostname dev --link pc:ols \
-v /home/oracle/github:/home/ols \
ols-dev:2.0.4
