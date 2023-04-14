# kubectl

`kubectl` cli tool in docker container

## Build multi-platform images

  * [Manuals / Docker Build / Building images / Multi-platform images](https://docs.docker.com/build/building/multi-platform/)

### Create build environment

```bash
$ docker buildx create --name ghilbut --driver docker-container --bootstrap --use
```

### Build images

* [kubernetes release versions](https://kubernetes.io/releases/)
  * latest: v1.27.0

```bash
$ docker buildx build --platform linux/amd64,linux/arm64 --build-arg=K8S_VERSION=v1.27.0 --target release --push -t ghilbut/kubectl:v1.27.0 .
$ docker buildx build --platform linux/amd64,linux/arm64 --build-arg=K8S_VERSION=v1.27.0 --target release --push -t ghilbut/kubectl:v1.27 .
$ docker buildx build --platform linux/amd64,linux/arm64 --build-arg=K8S_VERSION=v1.27.0 --target release --push -t ghilbut/kubectl:latest .
```

## How to use

```bash
$ docker run -it --rm ghilbut/kubectl:latest kubectl <command> <options>
```

### example

```bash
$ docker run -it --rm ghilbut/kubectl:latest kubectl version --client --output=yaml
```

## Remove build environment

```bash
$ docker buildx stop ghilbut
$ docker buildx rm ghilbut
```