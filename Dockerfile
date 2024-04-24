FROM golang:alpine as build

ENV CGO_ENABLED=1
ENV CGO_CFLAGS="-D_LARGEFILE64_SOURCE"

COPY . /project

WORKDIR /project

RUN apk add make git gcc musl-dev && make build

#================================

FROM alpine:latest

WORKDIR /

COPY ./migrations /migrations
COPY --from=build /project/bin/app /bin/

CMD ["app"]