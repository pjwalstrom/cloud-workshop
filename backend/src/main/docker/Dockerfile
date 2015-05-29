FROM jeanblanchard/busybox-java:8
MAINTAINER 'Stig Kleppe-Jørgensen "from.github@nisgits.net"'
VOLUME /tmp

EXPOSE 33333
ENTRYPOINT [
    "envconsul",
    "-consul",
    "192.168.12.34:8500",
    "-prefix",
    "registrator/unique_port",
    "java",
    "-Djava.security.egd=file:/dev/./urandom",
    "-jar",
    "/tmp/app.war"
]

RUN wget -q --no-check-certificate -O /tmp/consul.tar.gz https://github.com/hashicorp/envconsul/releases/download/v0.5.0/envconsul_0.5.0_linux_amd64.tar.gz && \
  tar -xzvf /tmp/consul.tar.gz -C /usr/bin/ --strip-components=1

ADD backend.war /tmp/app.war
