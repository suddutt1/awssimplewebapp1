FROM golang:1.21.1 AS build-stage
WORKDIR /opt/app/src
COPY go.mod go.sum ./
RUN go mod download
COPY *.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -o ./simplecloudapp

FROM alpine:3.18.4 AS release-stage
RUN adduser -D nonroot 
WORKDIR /opt/app/
COPY --from=build-stage /opt/app/src/simplecloudapp /opt/app/simplecloudapp
RUN mkdir -p /opt/app/www
COPY www/* /opt/app/www
EXPOSE 8080

USER nonroot:nonroot

ENTRYPOINT ["/opt/app/simplecloudapp"]
