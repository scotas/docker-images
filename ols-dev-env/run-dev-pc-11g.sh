#!/bin/bash
docker run -ti --rm --name dev-pc-11g --hostname dev --link pc \
-v /home/oracle/ols_12c:/home/ols \
-v /home/oracle/lucene_solr_4_0/solr:/home/lucene_solr_4_0/solr \
-v /home/oracle/lucene_solr_4_0/lucene:/home/lucene_solr_4_0/lucene \
pc-dev:1.2.0
