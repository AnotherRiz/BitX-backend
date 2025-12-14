FROM golang:1.24-alpine AS builder
WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o app ./cmd/server

FROM scratch
COPY --from=builder /app/app /app/app
EXPOSE 8844
ENTRYPOINT ["/app/app"]
