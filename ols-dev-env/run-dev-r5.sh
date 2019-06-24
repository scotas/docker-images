#!/bin/bash
docker run -ti --rm --name dev-r5 --hostname dev --link 19c:ols \
-v /home/oracle/github/ols:/home/ols \
-v /home/oracle/lucene_solr_4_0/solr:/home/lucene_solr_4_0/solr \
-v /home/oracle/lucene_solr_4_0/lucene:/home/lucene_solr_4_0/lucene \
ols-dev:2.0.5
