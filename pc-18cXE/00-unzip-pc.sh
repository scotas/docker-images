#!/bin/bash
yum -y --enablerepo ol7_optional_latest install ant ant-contrib ant-junit apache-ivy
yum clean all
PC_FILE=scotas-pc-bin-2.0.0.zip
curl -o $ORACLE_BASE/scripts/setup/$PC_FILE http://www.scotas.com/download/pc/$PC_FILE
unzip $ORACLE_BASE/scripts/setup/$PC_FILE -d $ORACLE_BASE/scripts/setup
rm -f $ORACLE_BASE/scripts/setup/$PC_FILE
