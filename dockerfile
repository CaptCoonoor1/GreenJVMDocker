FROM alpine:3.7

MAINTAINER Pterodactyl Software, <support@pterodactyl.io>


ENV GLIBC_VERSION=2.27-r0 \
    GRAALVM_VERSION=1.0.0-rc5 \
    JAVA_HOME=/usr/lib/jvm/graalvm-ce-1.0.0-rc5 \
    PATH=/usr/lib/jvm/graalvm-ce-1.0.0-rc5/bin:$PATH

RUN mkdir /usr/lib/jvm; \
    wget "https://github.com/oracle/graal/releases/download/vm-${GRAALVM_VERSION}/graalvm-ce-${GRAALVM_VERSION}-linux-amd64.tar.gz"; \
    tar -zxC /usr/lib/jvm -f graalvm-ce-${GRAALVM_VERSION}-linux-amd64.tar.gz; \
    rm -f graalvm-ce-${GRAALVM_VERSION}-linux-amd64.tar.gz
	
	
RUN apk add --no-cache --update curl ca-certificates openssl git tar bash sqlite fontconfig \
    && adduser -D -h /home/container container

USER container
ENV  USER=container HOME=/home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"
