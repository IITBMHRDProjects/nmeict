#!/bin/bash 
JAVA_HOME=/usr/lib/jvm/java-1.6.0-openjdk
LIB_Path=/PATH/'Project Name'/web/WEB-INF/lib
CLASS_Path=/PATH/'Project Name'/build/web/WEB-INF/classes
SOURCE_FILES=/PATH/'Project Name'/src/java

#Write all required jars
REQ1=$LIB_Path/mysql-connector-java-5.1.13-bin.jar
REQ2=$LIB_Path/commons-codec-1.4.jar
REQ3=$LIB_Path/mail.jar

$JAVA_HOME/bin/javac -cp ".:$REQ1:$REQ2:$REQ3:$CLASS_Path" $SOURCE_FILES/org/project/misc/UpdatesOnRegistrations.java

$JAVA_HOME/bin/java -cp ".:$REQ1:$REQ2:$REQ3:$CLASS_Path" org/project/misc/UpdatesOnRegistrations

echo "Completed"

exit 0 



