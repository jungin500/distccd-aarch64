FROM ubuntu:20.04

RUN set -ex \
    \
    && apt-get -qq update \
    && apt-get install -y distcc \
    && apt-get install -y build-essential g++-aarch64-linux-gnu gcc-aarch64-linux-gnu \
    && rm -rf /var/lib/apt/lists /var/cache/apt

EXPOSE 3632/tcp

ENTRYPOINT ["distccd", "--verbose", "--log-stderr", "--daemon", "--no-detach", "--allow", "0.0.0.0/0"]
