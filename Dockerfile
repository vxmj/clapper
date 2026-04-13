FROM alpine:latest

RUN apk add --no-cache ca-certificates curl sed coreutils

RUN mkdir -p /etc/app-config

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN sed -i 's/\r$//' /usr/local/bin/entrypoint.sh && \
    chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
