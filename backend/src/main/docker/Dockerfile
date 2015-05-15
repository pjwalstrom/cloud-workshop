FROM jeanblanchard/busybox-java:8
MAINTAINER 'Stig Kleppe-Jørgensen "from.github@nisgits.net"'
VOLUME /tmp
ADD backend.war /tmp/app.war

EXPOSE 33333
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/tmp/app.war"]
