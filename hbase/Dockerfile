FROM alpine:latest

RUN set -eux && \
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN set -eux && \
    apk add --no-cache bash perl openjdk8-jre-base

ARG HBASE_VERSION=2.3.2

ENV PATH $PATH:/hbase/bin
ENV JAVA_HOME=/usr

WORKDIR /

RUN apk add --no-cache bash

ARG TAR="hbase-$HBASE_VERSION-bin.tar.gz"
ARG DIR="hbase-$HBASE_VERSION"
RUN set -eux && \
    apk add --no-cache wget tar && \
    wget -t 2 --retry-connrefused -O "$TAR" "https://mirror.bit.edu.cn/apache/hbase/$HBASE_VERSION/$TAR" && \
    mkdir "$DIR" && \
    tar zxf "$TAR" -C "$DIR" --strip 1&& \
    test -d "$DIR" && \
    ln -sv "$DIR" hbase && \
    rm -fv "TAR" && \
    mkdir /hbase-data

RUN apk add jruby asciidoctor

VOLUME /hbase-data

COPY entrypoint.sh /

EXPOSE 2181 8080 8085 9090 9095 16000 16010 16030 16201 16301

CMD ["/entrypoint.sh"]

