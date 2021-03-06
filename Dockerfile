FROM nicolaka/netshoot

# Install OpenJDK-8
RUN apk update && apk add openjdk8

# Kafka
ENV KAFKA_VERSION 2.7.0
ENV SCALA_VERSION 2.13
LABEL name="kafka" version=${KAFKA_VERSION}
RUN apk add --no-cache openjdk8-jre bash coreutils su-exec
RUN apk add --no-cache -t .build-deps curl ca-certificates jq \
  && mkdir -p /opt \
  && mirror=$(curl --stderr /dev/null https://www.apache.org/dyn/closer.cgi\?as_json\=1 | jq -r '.preferred') \
  && curl -sSL "${mirror}kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz" \
  | tar -xzf - -C /opt \
  && mv /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION} /opt/kafka \
  && adduser -DH -s /sbin/nologin kafka \
  && chown -R kafka: /opt/kafka \
  && rm -rf /tmp/* \
  && apk del --purge .build-deps

ENV PATH /sbin:/opt/kafka/bin/:$PATH
WORKDIR /opt/kafka
VOLUME ["/tmp/kafka-logs"]

# Kafka Cat
RUN apk add kafkacat

# Postgres
RUN apk add postgresql

# MS Sql Server
RUN curl -O https://download.microsoft.com/download/e/4/e/e4e67866-dffd-428c-aac7-8d28ddafb39b/msodbcsql17_17.6.1.1-1_amd64.apk
RUN curl -O https://download.microsoft.com/download/e/4/e/e4e67866-dffd-428c-aac7-8d28ddafb39b/mssql-tools_17.6.1.1-1_amd64.apk
RUN apk add --allow-untrusted msodbcsql17_17.6.1.1-1_amd64.apk
RUN apk add --allow-untrusted mssql-tools_17.6.1.1-1_amd64.apk
ENV PATH /opt/mssql-tools/bin:$PATH


# Redis
RUN apk --update add redis


# custom binaries
COPY binaries/ /app/
ENV PATH "$PATH:/app"