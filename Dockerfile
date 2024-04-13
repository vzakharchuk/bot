
FROM quay.io/projectquay/golang:1.20 as builder
WORKDIR /go/src/app
COPY . .
RUN ls
RUN make build

FROM golang:latest
WORKDIR /
COPY --from=builder /go/src/app/bot .
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
ENTRYPOINT ["./bot", "version"]
