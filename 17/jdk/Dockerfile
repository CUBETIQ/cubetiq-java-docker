FROM ubuntu:20.04
LABEL maintainer="sombochea@cubetiqs.com"

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'
ENV TIMEZ=Asia/Phnom_Penh

RUN mkdir -p /src/cubetiq/build
COPY lic.txt version.txt /src/cubetiq/build/

ARG GRAAL_VERSION=22.1.0
ARG JAVA_VERSION=17
ARG GRAAL_URL=https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-${GRAAL_VERSION}/graalvm-ce-java${JAVA_VERSION}-linux-amd64-${GRAAL_VERSION}.tar.gz

RUN apt-get update \
    && apt-get install -y --no-install-recommends tzdata curl ca-certificates fontconfig locales binutils procps bash libudev1 fonts-dejavu-core\
    && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/*

RUN ln -sf /usr/share/zoneinfo/Asia/Phnom_Penh /etc/localtime
RUN echo "Asia/Phnom_Penh" > /etc/timezone

COPY slim-java* /usr/local/bin/

RUN set -eux; \
    export DEBIAN_FRONTEND=noninteractive; \
    curl --retry 3 -Lfso /tmp/graalvm.tar.gz ${GRAAL_URL}; \
    mkdir -p /opt/java/graalvm; \
    cd /opt/java/graalvm; \
    tar -xf /tmp/graalvm.tar.gz --strip-components=1; \
    export PATH="/opt/java/graalvm/bin:$PATH"; \
    /usr/local/bin/slim-java.sh /opt/java/graalvm; \
    rm -rf /var/lib/apt/lists/*; \
    rm -rf /tmp/graalvm.tar.gz;

ENV JAVA_HOME=/opt/java/graalvm \
    PATH="/opt/java/graalvm/bin:$PATH"

CMD java -version