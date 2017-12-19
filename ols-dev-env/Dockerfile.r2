# Before building this image oracle/database:12.1.0.2-ee must be available at your private registry
# See https://github.com/oracle/docker-images/blob/master/OracleDatabase/README.md for more details
# Finally build using ./buildDockerImage.sh script

FROM	oracle/database:12.2.0.1-ee
MAINTAINER mochoa@scotas.com

USER	root
RUN	yum -y --enablerepo ol7_optional_latest install ant ant-contrib ant-junit apache-ivy && \
	yum clean all

ADD	http://www.scotas.com/download/ols/12cR2/runtime12.jar /home/oracle/
ADD	http://www.scotas.com/download/ols/12cR2/sqljutl.sql /home/oracle/
ADD     http://www.scotas.com/download/ols/12cR2/ODCI.jar /home/oracle/
ADD     http://www.scotas.com/download/ols/12cR2/converter.jar /home/oracle/
ADD     http://www.scotas.com/download/ols/12cR2/initsoxx.sql /home/oracle/
ADD     http://www.scotas.com/download/ols/12cR2/translator.jar /home/oracle/
RUN	mv $ORACLE_HOME/rdbms/jlib/ODCI.jar $ORACLE_HOME/rdbms/jlib/ODCI.jar.bak && \
        mv $ORACLE_HOME/rdbms/admin/initsoxx.sql $ORACLE_HOME/rdbms/admin/initsoxx.sql.bak && \
	mv /home/oracle/ODCI.jar $ORACLE_HOME/rdbms/jlib/ODCI.jar && \
	mv /home/oracle/converter.jar $ORACLE_HOME/rdbms/jlib/converter.jar && \
	mv /home/oracle/initsoxx.sql $ORACLE_HOME/rdbms/admin/initsoxx.sql && \
	chown oracle:oinstall $ORACLE_HOME/rdbms/jlib/ODCI.jar && \
	chown oracle:oinstall $ORACLE_HOME/rdbms/admin/initsoxx.sql && \
	mkdir -p $ORACLE_HOME/oc4j/sqlj/lib && \
	mkdir -p $ORACLE_HOME/jdbc/lib && \
	cp $ORACLE_HOME/inventory/Scripts/ext/jlib/ojdbc8.jar $ORACLE_HOME/jdbc/lib/ojdbc8.jar && \
	chmod a+r $ORACLE_HOME/jdbc/lib/ojdbc8.jar && \
	rm -f $ORACLE_HOME/jdbc/lib/ojdbc6.jar && \
	ln -s $ORACLE_HOME/jdbc/lib/ojdbc8.jar $ORACLE_HOME/jdbc/lib/ojdbc6.jar && \
	mv  /home/oracle/translator.jar /home/oracle/runtime12.jar /home/oracle/sqljutl.sql $ORACLE_HOME/oc4j/sqlj/lib && \
	chown -R oracle:oinstall $ORACLE_HOME/oc4j

ENV	JAVA_HOME=$ORACLE_HOME/jdk

WORKDIR	/home
USER	oracle

# Define default command to start Oracle Database. 
CMD	exec /bin/bash
