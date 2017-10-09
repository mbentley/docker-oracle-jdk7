FROM debian:jessie
MAINTAINER Matt Bentley <mbentley@mbentley.net>

RUN apt-get update &&\
  apt-get -y install wget &&\
  rm -rf /var/lib/apt/lists/*

# Oracle sucks, download it from my office; original is from http://download.oracle.com/otn/java/jdk/7u80-b15/jdk-7u80-linux-x64.tar.gz
RUN wget --progress=dot -O /tmp/jdk-7u80-linux-x64.tar.gz "https://office.dckrindy.io/temp/jdk-7u80-linux-x64.tar.gz" &&\
  echo "6152f8a7561acf795ca4701daa10a965  /tmp/jdk-7u80-linux-x64.tar.gz" | md5sum -c > /dev/null 2>&1 || (echo "ERROR: MD5SUM MISMATCH"; exit 1) &&\
  tar xzf /tmp/jdk-7u80-linux-x64.tar.gz &&\
  mkdir -p /usr/lib/jvm &&\
  mv jdk1.7.0_80 /usr/lib/jvm/ &&\
  mv /usr/lib/jvm/jdk1.7.0_80 /usr/lib/jvm/java-7-oracle &&\
  rm -rf jdk1.7.0_80 && rm /tmp/jdk-7u80-linux-x64.tar.gz &&\
  chown root:root -R /usr/lib/jvm/java-7-oracle

RUN update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-7-oracle/bin/java 1 &&\
  update-alternatives --set java /usr/lib/jvm/java-7-oracle/bin/java &&\
  update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/java-7-oracle/bin/javac 1 &&\
  update-alternatives --set javac /usr/lib/jvm/java-7-oracle/bin/javac &&\
  update-alternatives --install /usr/bin/javaws javaws /usr/lib/jvm/java-7-oracle/bin/javaws 1 &&\
  update-alternatives --set javaws /usr/lib/jvm/java-7-oracle/bin/javaws
