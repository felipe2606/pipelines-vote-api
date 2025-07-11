FROM registry.access.redhat.com/ubi8/go-toolset AS builder

WORKDIR /build
ADD . /build/


RUN mkdir /tmp/cache
RUN CGO_ENABLED=0 GOCACHE=/tmp/cache go mod download && go build -v -buildvcs=false -o /tmp/api-server .

FROM scratch

WORKDIR /app
COPY --from=builder /tmp/api-server /app/api-server

CMD [ "/app/api-server" ]
