#!/bin/bash
docker run -ti --rm --name dev-r4 --hostname dev --link xe-18c:ols \
-v /home/oracle/ols_12c:/home/ols \
-v /home/oracle/lucene_solr_4_0/solr:/home/lucene_solr_4_0/solr \
-v /home/oracle/lucene_solr_4_0/lucene:/home/lucene_solr_4_0/lucene \
ols-dev:2.0.4
