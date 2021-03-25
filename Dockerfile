FROM golang:1.15.8-alpine3.13 AS builder

RUN apk update && \ 
    apk add --no-cache git

RUN mkdir -p /go/src/app

WORKDIR /go/src/app
COPY . .

RUN go get -d -v \
  && go install -v \
  && go build -ldflags '-w -s' -a -installsuffix cgo -o hello .


FROM scratch

COPY --from=builder /go/src/app/hello .

EXPOSE 3000

CMD [ "./hello" ]
