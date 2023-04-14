ARG BUILDPLATFORM=amd64
ARG K8S_VERSION=v1.27.0

FROM --platform=$BUILDPLATFORM ubuntu:23.04 as build
LABEL com.ghilbut.image.authors="ghilbut@gmail.com"
LABEL version="$K8S_VERSION"

ARG BUILDPLATFORM
ARG K8S_VERSION

RUN apt-get update  \
 && apt-get upgrade -y  \
 && apt-get install -y curl  \
 && export ARCH=$(echo "$BUILDPLATFORM" | sed 's:.*/::')  \
 && curl -LO "https://dl.k8s.io/release/${K8S_VERSION}/bin/linux/${ARCH}/kubectl"  \
 && curl -LO "https://dl.k8s.io/${K8S_VERSION}/bin/linux/${ARCH}/kubectl.sha256"  \
 && echo "$(cat kubectl.sha256) kubectl" | sha256sum --check  \
 && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl  \
 && kubectl version --client


FROM --platform=$BUILDPLATFORM ubuntu:23.04 as release
LABEL com.ghilbut.image.authors="ghilbut@gmail.com"
LABEL version="$K8S_VERSION"

COPY --from=build /usr/local/bin/kubectl /usr/local/bin/kubectl