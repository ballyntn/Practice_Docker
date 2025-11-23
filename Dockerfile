FROM golang:1.24.3

WORKDIR /app

COPY . .

RUN go build -o api

EXPOSE 4444

CMD ["./practice"]

