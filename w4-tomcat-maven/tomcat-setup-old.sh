# ~
# Install Java
yum install java-17-amazon-corretto

# Install Maven
cd /opt
wget https://dlcdn.apache.org/maven/maven-3/3.9.11/binaries/apache-maven-3.9.11-bin.tar.gz
tar -xvzf apache-maven-3.9.11-bin.tar.gz
mv apache-maven-3.9.11 maven

# Set up environment variables
cd ~
echo M2_HOME=/opt/maven >> .bash_profile
echo M2=/opt/maven/bin >> .bash_profile
echo JAVA_HOME=/usr/lib/jvm/java-17-amazon-corretto.x86_64 >> .bash_profile
echo 'PATH=$PATH:$HOME/bin:$JAVA_HOME:$M2_HOME:$M2' >> .bash_profile
echo export PATH >> .bash_profile

# Reset bash_profile
source .bash_profile

# Install Tomcat
cd /opt
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.108/bin/apache-tomcat-9.0.108.tar.gz
tar -xvzf apache-tomcat-9.0.108.tar.gz
mv apache-tomcat-9.0.108 tomcat

# Set aliases
ln -s /opt/tomcat/bin/startup.sh /usr/local/bin/tomcatup
ln -s /opt/tomcat/bin/shutdown.sh /usr/local/bin/tomcatdown

# Create web template
cd ~
mvn archetype:generate -DgroupId=vn.edu.rmit -DartifactId=helloWorld -DarchetypeArtifactId=maven-archetype-webapp -DinteractiveMode=false
cd helloWorld
mvn clean package
cp target/helloWorld.war $INSTALL_DIR/tomcat/webapps/

# Start Tomcat
tomcatdown
tomcatup

#Test log out in GitHub