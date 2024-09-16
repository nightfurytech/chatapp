FROM golang:alpine
RUN apk update && apk --no-cache add ca-certificates tzdata

RUN mkdir /app
ADD . /app
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download

# Copy the source code
COPY . .

RUN cp /usr/share/zoneinfo/Asia/Calcutta /etc/localtime

# Build the Go app
RUN go build -o /app/main .

EXPOSE 8080
CMD ["/app/main"]
