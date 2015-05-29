FROM jeanblanchard/busybox-java:8
MAINTAINER 'Stig Kleppe-Jørgensen "from.github@nisgits.net"'
VOLUME /tmp

EXPOSE 33333
ENTRYPOINT [ "/tmp/launch.sh" ]

RUN wget -q --no-check-certificate -O /tmp/consul.tar.gz https://github.com/hashicorp/envconsul/releases/download/v0.5.0/envconsul_0.5.0_linux_amd64.tar.gz && \
  tar -xzvf /tmp/consul.tar.gz -C /usr/bin/ --strip-components=1

ADD launch.sh /tmp/launch.sh
ADD frontend.war /tmp/app.war
