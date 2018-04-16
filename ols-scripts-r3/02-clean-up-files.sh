#!/bin/bash
echo "Cleanup temporary files"
rm -f /home/oracle/*.jar /home/oracle/*.zip /home/oracle/*.log /home/oracle/*.lst /home/oracle/*.err
rm -rf /home/oracle/ols
echo "OLS Installation Done"
