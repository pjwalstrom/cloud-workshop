FROM jeanblanchard/busybox-java:8
MAINTAINER 'Stig Kleppe-Jørgensen "from.github@nisgits.net"'

EXPOSE 33333
ENTRYPOINT [ "/bin/sh", "/tmp/launch.sh" ]

RUN curl -sL http://cldup.com/XPw5-FrHJz.gz | \
  gunzip -c | tar -x -C /tmp/ && \
  mv /tmp/envconsul_0.5.0_linux_amd64/envconsul /usr/bin/

COPY launch.sh /tmp/launch.sh
COPY frontend.war /tmp/app.war
