# Before building this image oracle/database:18.0.0.0-ee must be available at your private registry
# See https://github.com/marcelo-ochoa/docker-images/blob/master/OracleDatabase/README.md for more details
# Finally build using ./buildDockerImage.sh script

FROM	oracle/database:18.0.0.0-ee
MAINTAINER mochoa@scotas.com

USER	root
RUN	yum -y --enablerepo ol7_optional_latest install ant ant-contrib ant-junit apache-ivy && \
	yum clean all

ADD http://www.scotas.com/download/ols/18cR1/ODCI.jar /home/oracle/
ADD http://www.scotas.com/download/ols/18cR1/converter.jar /home/oracle/
ADD http://www.scotas.com/download/ols/18cR1/initsoxx.sql /home/oracle/
ADD http://www.scotas.com/download/ols/18cR1/translator.jar /home/oracle/
ADD http://www.scotas.com/download/ols/18cR1/sqljutl.sql /home/oracle/
RUN	mv $ORACLE_HOME/rdbms/jlib/ODCI.jar $ORACLE_HOME/rdbms/jlib/ODCI.jar.bak && \
	mv /home/oracle/ODCI.jar $ORACLE_HOME/rdbms/jlib/ODCI.jar && \
	mv /home/oracle/converter.jar $ORACLE_HOME/rdbms/jlib/converter.jar && \
	mv $ORACLE_HOME/rdbms/admin/initsoxx.sql $ORACLE_HOME/rdbms/admin/initsoxx.sql.bak && \
	mv /home/oracle/initsoxx.sql $ORACLE_HOME/rdbms/admin/initsoxx.sql && \
	chmod a+r $ORACLE_HOME/rdbms/jlib/ODCI.jar && \
	chown oracle:oinstall $ORACLE_HOME/rdbms/jlib/ODCI.jar && \
	chmod a+r $ORACLE_HOME/rdbms/jlib/converter.jar && \
	chown oracle:oinstall $ORACLE_HOME/rdbms/jlib/converter.jar && \
	chmod a+r $ORACLE_HOME/rdbms/admin/initsoxx.sql && \
	chown oracle:oinstall $ORACLE_HOME/rdbms/admin/initsoxx.sql && \
	mkdir -p $ORACLE_HOME/oc4j/sqlj/lib && \
	mkdir -p $ORACLE_HOME/jdbc/lib && \
	cp $ORACLE_HOME/inventory/Scripts/ext/jlib/ojdbc8.jar $ORACLE_HOME/jdbc/lib/ojdbc8.jar && \
	chmod a+r $ORACLE_HOME/jdbc/lib/ojdbc8.jar && \
	chown oracle:oinstall  $ORACLE_HOME/jdbc/lib/ojdbc8.jar && \
	rm -f $ORACLE_HOME/jdbc/lib/ojdbc6.jar && \
	ln -s $ORACLE_HOME/jdbc/lib/ojdbc8.jar $ORACLE_HOME/jdbc/lib/ojdbc6.jar && \
	mv  /home/oracle/translator.jar /home/oracle/sqljutl.sql $ORACLE_HOME/oc4j/sqlj/lib && \
	chmod a+r $ORACLE_HOME/oc4j/sqlj/lib/translator.jar && \
	chmod a+r $ORACLE_HOME/oc4j/sqlj/lib/sqljutl.sql && \
	chown -R oracle:oinstall $ORACLE_HOME/oc4j && \
	echo "pdb1= \
(DESCRIPTION = \
  (ADDRESS = (PROTOCOL = TCP)(HOST = ols)(PORT = 1521)) \
  (CONNECT_DATA = \
    (SERVER = DEDICATED) \
    (SERVICE_NAME = pdb1) \
  ) \
)" >> $ORACLE_HOME/network/admin/tnsnames.ora

ENV	JAVA_HOME=$ORACLE_HOME/jdk

WORKDIR	/home
USER	oracle

# Define default command to start Oracle Database. 
CMD	exec /bin/bash
