FROM debian:buster-slim AS build

WORKDIR /tmp
ENV GCSPROXY_VERSION=0.3.1

RUN apt-get update \
    && apt-get install --no-install-suggests --no-install-recommends --yes ca-certificates wget \
    && wget https://github.com/daichirata/gcsproxy/releases/download/v${GCSPROXY_VERSION}/gcsproxy-${GCSPROXY_VERSION}-linux-amd64.tar.gz \
    && tar zxf gcsproxy-${GCSPROXY_VERSION}-linux-amd64.tar.gz \
    && cp ./gcsproxy-${GCSPROXY_VERSION}-linux-amd64/gcsproxy .

FROM ubuntu:latest
COPY --from=build /tmp/gcsproxy /gcsproxy

RUN apt-get update \
    && apt-get install --no-install-suggests --no-install-recommends --yes ca-certificates nginx gettext-base \
    && rm -rf /var/lib/apt/lists/*
COPY default /etc/nginx/sites-available/default
COPY nginx.conf.template /etc/nginx/nginx.conf.template

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT [ "/docker-entrypoint.sh"]
