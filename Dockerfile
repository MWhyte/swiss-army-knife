FROM nicolaka/netshoot

# Install OpenJDK-8
RUN apk update && apk add openjdk8

# Kafka
ARG kafka_version=3.3.1
ENV kafka_bin_version=2.12-$kafka_version

RUN apk add --no-cache --update-cache --virtual build-dependencies curl ca-certificates \
  && mkdir -p /opt/kafka \
  && curl -SLs "https://www-eu.apache.org/dist/kafka/$kafka_version/kafka_$kafka_bin_version.tgz" | tar -xzf - --strip-components=1 -C /opt/kafka \
  && apk del build-dependencies \
  && rm -rf /var/cache/apk/*

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


# Install grpcurl
RUN curl -sSL "https://github.com/fullstorydev/grpcurl/releases/download/v1.8.7/grpcurl_1.8.7_linux_x86_64.tar.gz" | tar -xz -C /usr/local/bin

# https://github.com/vadimi/grpc-client-cli
RUN curl -L https://github.com/vadimi/grpc-client-cli/releases/download/v1.15.0/grpc-client-cli_linux_x86_64.tar.gz | tar -C /usr/local/bin -xz


# custom binaries
COPY binaries/ /app/
ENV PATH "$PATH:/app"