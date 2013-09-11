#!/bin/bash
mvn install:install-file -Dfile=$APPFACTORY_HOME/repository/resources/maven/af-archetype-1.0.0.jar -DgroupId=org.wso2.carbon.appfactory.maven.archetype -DartifactId=af-archetype -Dversion=1.0.0 -Dpackaging=jar
mvn archetype:generate -DartifactId=afdefault -DgroupId=org.wso2.af -DarchetypeArtifactId=maven-archetype-webapp -Dversion=SNAPSHOT -DinteractiveMode=false

mvn install:install-file -Dfile=$APPFACTORY_HOME/repository/resources/maven/jaxrs-archetype-1.0.0.jar -DgroupId=org.wso2.carbon.appfactory.maven.jaxrsarchetype -DartifactId=jaxrs-archetype -Dversion=1.0.0 -Dpackaging=jar
mvn archetype:generate -DartifactId=jaxrsdefault -DarchetypeGroupId=org.wso2.carbon.appfactory.maven.jaxrsarchetype -DarchetypeArtifactId=jaxrs-archetype -DarchetypeVersion=1.0.0 -DgroupId=org.wso2.af -Dversion=SNAPSHOT -DinteractiveMode=false -DarchetypeCatalog=local

mvn install:install-file -Dfile=$APPFACTORY_HOME/repository/resources/maven/jaxws-archetype-1.0.0.jar -DgroupId=org.wso2.carbon.appfactory.maven.jaxwsarchetype -DartifactId=jaxws-archetype -Dversion=1.0.0 -Dpackaging=jar
mvn archetype:generate -DartifactId=jaxwsdefault -DarchetypeGroupId=org.wso2.carbon.appfactory.maven.jaxwsarchetype -DarchetypeArtifactId=jaxws-archetype -DarchetypeVersion=1.0.0 -DgroupId=org.wso2.af -Dversion=SNAPSHOT -DinteractiveMode=false -DarchetypeCatalog=local

mvn install:install-file -Dfile=$APPFACTORY_HOME/repository/resources/maven/jaggery-archetype-1.0.0.jar -DgroupId=org.wso2.carbon.appfactory.maven.jaggeryarchetype -DartifactId=jaggery-archetype -Dversion=1.0.0 -Dpackaging=jar

mvn archetype:generate -DartifactId=jaggerydefault -DarchetypeGroupId=org.wso2.carbon.appfactory.maven.jaggeryarchetype -DarchetypeArtifactId=jaggery-archetype -DarchetypeVersion=1.0.0 -DgroupId=org.wso2.af -Dversion=SNAPSHOT -DinteractiveMode=false -DarchetypeCatalog=local
 
mvn install:install-file -Dfile=$APPFACTORY_HOME/repository/resources/maven/bpel-archetype-1.0.0.jar -DgroupId=org.wso2.carbon.appfactory.maven.bpelarchetype -DartifactId=bpel-archetype -Dversion=1.0.0 -Dpackaging=jar

mvn archetype:generate -DartifactId=bpeldefault -DarchetypeGroupId=org.wso2.carbon.appfactory.maven.bpelarchetype -DarchetypeArtifactId=bpel-archetype -DarchetypeVersion=1.0.0 -DgroupId=org.wso2.af -Dversion=SNAPSHOT -DinteractiveMode=false -DarchetypeCatalog=local

mvn install:install-file -Dfile=$APPFACTORY_HOME/repository/resources/maven/esb-archetype-1.0.0.jar -DgroupId=org.wso2.carbon.appfactory.maven.esbarchetype -DartifactId=esb-archetype -Dversion=1.0.0 -Dpackaging=jar

mvn archetype:generate -DartifactId=esbdefault -DarchetypeGroupId=org.wso2.carbon.appfactory.maven.esbarchetype -DarchetypeArtifactId=esb-archetype -DarchetypeVersion=1.0.0 -DgroupId=org.wso2.af -Dversion=SNAPSHOT -DinteractiveMode=false -DarchetypeCatalog=local

mvn install:install-file -Dfile=$APPFACTORY_HOME/repository/resources/maven/dbs-archetype-1.0.0.jar -DgroupId=org.wso2.carbon.appfactory.maven.dbsarchetype -DartifactId=dbs-archetype -Dversion=1.0.0 -Dpackaging=jar
 
mvn archetype:generate -DartifactId=dbsdefault -DarchetypeGroupId=org.wso2.carbon.appfactory.maven.dbsarchetype -DarchetypeArtifactId=dbs-archetype -DarchetypeVersion=1.0.0 -DgroupId=org.wso2.af -Dversion=SNAPSHOT -DinteractiveMode=false -DarchetypeCatalog=local

mvn install:install-file -Dfile=$APPFACTORY_HOME/repository/resources/maven/php-archetype-1.0.0.jar -DgroupId=org.wso2.carbon.appfactory.maven.phparchetype -DartifactId=php-archetype -Dversion=1.0.0 -Dpackaging=jar

mvn archetype:generate -DartifactId=phpdefault -DarchetypeGroupId=org.wso2.carbon.appfactory.maven.phparchetype -DarchetypeArtifactId=php-archetype -DarchetypeVersion=1.0.0 -DgroupId=org.wso2.af -Dversion=SNAPSHOT -DinteractiveMode=false -DarchetypeCatalog=local

