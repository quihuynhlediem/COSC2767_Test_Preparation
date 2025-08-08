#!/bin/bash

# Tomcat Setup Script
set -e  # Exit on any error

# Variables
JAVA_VERSION="java-17-amazon-corretto"
MAVEN_VERSION="3.9.11"
TOMCAT_VERSION="9.0.108"
INSTALL_DIR="/opt"
HOME_DIR="$HOME"

echo "Starting Tomcat setup..."

# Install Java
echo "Installing Java..."
if ! java -version 2>/dev/null; then
    yum install -y $JAVA_VERSION
else
    echo "Java already installed"
fi

# Install Maven
echo "Installing Maven..."
if [ ! -d "$INSTALL_DIR/maven" ]; then
    cd $INSTALL_DIR
    wget https://dlcdn.apache.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz
    tar -xvzf apache-maven-$MAVEN_VERSION-bin.tar.gz
    mv apache-maven-$MAVEN_VERSION maven
    rm apache-maven-$MAVEN_VERSION-bin.tar.gz
else
    echo "Maven already installed"
fi

# Set up environment variables
echo "Configuring environment..."
{
    echo "M2_HOME=$INSTALL_DIR/maven"
    echo "M2=$INSTALL_DIR/maven/bin"
    echo "JAVA_HOME=/usr/lib/jvm/$JAVA_VERSION.x86_64"
    echo 'PATH=$PATH:$HOME/bin:$JAVA_HOME:$M2_HOME:$M2'
    echo "export PATH M2_HOME M2 JAVA_HOME"
} >> $HOME_DIR/.bash_profile

source $HOME_DIR/.bash_profile

# Install Tomcat
echo "Installing Tomcat..."
if [ ! -d "$INSTALL_DIR/tomcat" ]; then
    cd $INSTALL_DIR
    wget https://dlcdn.apache.org/tomcat/tomcat-9/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz
    tar -xvzf apache-tomcat-$TOMCAT_VERSION.tar.gz
    mv apache-tomcat-$TOMCAT_VERSION tomcat
    rm apache-tomcat-$TOMCAT_VERSION.tar.gz
else
    echo "Tomcat already installed"
fi

# Set up convenient aliases
echo "Setting up Tomcat aliases..."
ln -sf $INSTALL_DIR/tomcat/bin/startup.sh /usr/local/bin/tomcatup
ln -sf $INSTALL_DIR/tomcat/bin/shutdown.sh /usr/local/bin/tomcatdown

# Generate and deploy sample web application
echo "Creating sample web application..."
cd $HOME_DIR
if [ ! -d "helloWorld" ]; then
    mvn archetype:generate -DgroupId=vn.edu.rmit -DartifactId=helloWorld \
        -DarchetypeArtifactId=maven-archetype-webapp -DinteractiveMode=false
fi

cd helloWorld
mvn clean package
cp target/helloWorld.war $INSTALL_DIR/tomcat/webapps/

# Start Tomcat
echo "Starting Tomcat..."
tomcatdown 2>/dev/null || true  # Don't fail if already stopped
tomcatup

echo "Tomcat setup completed successfully!"
echo "Access your application at: http://localhost:8080/helloWorld"