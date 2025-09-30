ARG ARCH="amd64"
ARG OS="linux"
FROM quay.io/aimonitoriq/busybox-${OS}-${ARCH}:latest
LABEL maintainer="The AI MonitorIQ Authors <aimonitoriq-developers@googlegroups.com>"
LABEL org.opencontainers.image.source="https://github.com/aimonitoriq/aimonitoriq"

ARG ARCH="amd64"
ARG OS="linux"
COPY .build/${OS}-${ARCH}/aimonitoriq        /bin/aimonitoriq
COPY .build/${OS}-${ARCH}/aimonitoriq-tool   /bin/aimonitoriq-tool
COPY documentation/examples/aimonitoriq.yml  /etc/aimonitoriq/aimonitoriq.yml
COPY LICENSE                                /LICENSE
COPY NOTICE                                 /NOTICE
COPY npm_licenses.tar.bz2                   /npm_licenses.tar.bz2

WORKDIR /aimonitoriq
RUN chown -R nobody:nobody /etc/aimonitoriq /aimonitoriq && chmod g+w /aimonitoriq

USER       nobody
EXPOSE     9090
VOLUME     [ "/aimonitoriq" ]
ENTRYPOINT [ "/bin/aimonitoriq" ]
CMD        [ "--config.file=/etc/aimonitoriq/aimonitoriq.yml", \
             "--storage.tsdb.path=/aimonitoriq" ]
