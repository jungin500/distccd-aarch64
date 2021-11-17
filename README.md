Ubuntu 20.04 `distccd` server capable of `aarch64` (`arm64`) GCC/G++ builds
___

# Usage
- On server (amd64): `docker run -it -p 3632:3632/tcp --restart=always --name distccd-server jungin500/distccd-aarch64:ubuntu2004`

- On client (aarch64): Change `HOST_IP_ADDRESS_HERE` part to your host IP where docker container is started
```bash
apt-get -y install distcc
DISTCC_VERBOSE=1 DISTCC_LOG=/tmp/distcc.log DISTCC_FALLBACK=0 DISTCC_BACKOFF_PERIOD=0 \
DISTCC_HOSTS='HOST_IP_ADDRESS_HERE' MAX_JOBS=8 CC=/usr/lib/distcc/aarch64-linux-gnu-gcc CXX=/usr/lib/distcc/aarch64-linux-gnu-g++ python3 setup.py bdist_wheel
```

You can change command `python3 setup.py bdist_wheel` whatever build operations you want. (e.g. `cmake`, `pip3 install ~`)

# `Dockerfile`
Full source of `Dockerfile` of this docker image below:

```Dockerfile
FROM ubuntu:20.04

RUN set -ex \
    \
    && apt-get -qq update \
    && apt-get install -y distcc \
    && apt-get install -y build-essential g++-aarch64-linux-gnu gcc-aarch64-linux-gnu \
    && rm -rf /var/lib/apt/lists /var/cache/apt

EXPOSE 3632/tcp

ENTRYPOINT ["distccd", "--verbose", "--log-stderr", "--daemon", "--no-detach", "--allow", "0.0.0.0/0"]
```
