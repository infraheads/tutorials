FROM golang:1.19.3-alpine

COPY . /app

WORKDIR /app

RUN go build hello-world.go

CMD ["./hello-world"]
