FROM debian:stretch

# git tag from https://github.com/stellar/horizon
ARG STELLAR_HORIZON_VERSION="v0.11.0"
ARG STELLAR_HORIZON_BUILD_DEPS="git build-essential golang-go"

MAINTAINER André Gaul <andre@gaul.io>

# install stellar horizon
ADD install.sh /
RUN /install.sh

# HTTP port
EXPOSE 8000

ADD entry.sh /

CMD ["horizon"]
