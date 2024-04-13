# Detecting the operating system
ifeq ($(OS),Windows_NT)
    detected_os := Windows
else
    detected_os := $(shell uname -s)
endif

# Detecting the architecture
ifeq ($(detected_os),Windows)
    detected_arch := $(PROCESSOR_ARCHITECTURE)
else
    detected_arch := $(shell uname -m)
endif


APP=$(shell basename $(shell git remote get-url origin) | sed 's/\.git$$//')
REGISTRY=vzak
VERSION=v1-$(shell git rev-parse --short HEAD)
TARGETOS=${detected_os}
TARGETARCH=${detected_arch}

get:
	@echo ${TARGETOS}
	@echo ${TARGETARCH}
	go get

format:
	gofmt -s -w ./

lint:
	golint

test:
	go test -v

build: format get
	# go: unsupported GOOS/GOARCH pair Darwin/arm64 --> fails on Mac M2 locally
	# CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} 
	go build -v -o bot -ldflags "-X="github.com/vzakharchuk/bot/cmd.appVersion=${VERSION}

image:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

clean:
	rm -rf kbot
	docker rmi ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}