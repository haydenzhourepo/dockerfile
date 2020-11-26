FROM centos:7

ARG HADOOP_VERSION=2.9.2

ENV PATH $PATH:/hadoop/bin:/hadoop/sbin
ENV TAR="hadoop-${HADOOP_VERSION}.tar.gz"

WORKDIR /

RUN set -eux && \
    yum install -y java-1.8.0-openjdk

ENV JAVA_HOME=/usr

RUN set -eux && \
    yum install -y openssh-server openssh-clients tar which wget

RUN set -eux && \
    wget -t 2 --retry-connrefused -O  "$TAR" "https://mirror.bit.edu.cn/apache/hadoop/common/hadoop-${HADOOP_VERSION}/${TAR}" && \
    tar zxf "${TAR}" && \
    rm -fv "${TAR}" && \
    ln -sv "hadoop-${HADOOP_VERSION}" hadoop

RUN set -eux && \
    yum install -y java-1.8.0-openjdk-devel.x86_64

COPY entrypoint.sh /
COPY ssh/config /root/.ssh/

COPY conf/core-site.xml /hadoop/etc/hadoop/
COPY conf/hdfs-site.xml /hadoop/etc/hadoop/
COPY conf/yarn-site.xml /hadoop/etc/hadoop/
COPY conf/mapred-site.xml /hadoop/etc/hadoop/

ENV HDFS_NAMENODE_USER=root
ENV HDFS_SECONDARYNAMENODE_USER=root
ENV HDFS_DATANODE_USER=root
ENV YARN_RESOURCEMANAGER_USER=root
ENV YARN_NODEMANAGER_USER=root

EXPOSE 8020 8042 8088 9000 9868 9870 10020 19888 50010 50020 50090 22

#CMD ["/entrypoint.sh"]

