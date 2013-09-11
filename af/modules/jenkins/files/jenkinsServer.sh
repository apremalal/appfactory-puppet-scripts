export JAVA_HOME='/opt/java'
export JENKINS_HOME=`pwd`/repository
export MAVEN_HOME=/opt/apache-maven-3.0.5
export M2_HOME=/opt/apache-maven-3.0.5
export GIT_SSL_NO_VERIFY=1
mkdir -p $JENKINS_HOME/logs
nohup $JAVA_HOME/bin/java -d64 -server -Xms1024m -Xmx4096m -XX:MaxPermSize=1024m -Djavax.net.ssl.trustStore=/mnt/jenkins/client-truststore.jks -Djavax.net.ssl.trustStorePassword=wso2carbon -jar jenkins.war --httpPort=-1 --httpsPort=443 --httpsKeyStore=/mnt/jenkins/wso2carbon.jks --httpsKeyStorePassword=wso2carbon > $JENKINS_HOME/logs/jenkins.log 2>&1 &
