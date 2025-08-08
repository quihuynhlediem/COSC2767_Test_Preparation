#!/bin/bash
cd ~/helloWorld
mvn clean package
cp target/helloWorld.war /opt/tomcat/webapps/
tomcatdown
tomcatup