# Practice Docker - Go Web Application

A production-ready Go web application containerized with Docker, featuring graceful shutdown, health checks, and best practices.

## Overview

This project demonstrates a well-structured Go HTTP server application running in a Docker container. The application provides REST endpoints for greetings and health checks, with proper error handling, graceful shutdown, and security best practices.

## Features

- ✅ **Structured HTTP server** with proper routing
- ✅ **Graceful shutdown** handling (SIGINT, SIGTERM)
- ✅ **Health check endpoint** (`/health`)
- ✅ **Configurable port** via environment variable
- ✅ **Multi-stage Docker build** for optimized image size
- ✅ **Security best practices** (non-root user, minimal base image)
- ✅ **Proper error handling** and logging
- ✅ **Request timeouts** configured

## Prerequisites

- [Go](https://golang.org/dl/) 1.24.3 or later
- [Docker](https://www.docker.com/get-started) installed and running
- Basic knowledge of Go and Docker

## Project Structure

```
practice-docker/
├── .dockerignore   # Files to exclude from Docker build
├── Dockerfile      # Multi-stage Docker configuration
├── go.mod          # Go module definition
├── main.go         # Main application code
└── README.md       # This file
```

## Local Development

### Running Locally (without Docker)

1. Ensure Go is installed:
   ```bash
   go version
   ```

2. Run the application:
   ```bash
   go run main.go
   ```

   Or with a custom port:
   ```bash
   PORT=8080 go run main.go
   ```

3. The server will start on port `3333` (or the port specified in `PORT` environment variable). Visit:
   ```
   http://localhost:3333
   ```

4. You should see a response like:
   ```
   Hello World! 2024-01-15T10:30:45.123456789Z
   ```

### Building Locally

To build the application binary:

```bash
go build -o practice-docker
```

Then run the binary:

```bash
./practice-docker
```

Or with a custom port:

```bash
PORT=8080 ./practice-docker
```

## Docker Usage

### Building the Docker Image

```bash
docker build -t practice-docker .
```

### Running the Container

```bash
docker run -p 3333:3333 practice-docker
```

The application listens on port 3333 inside the container. Map it to any host port:

```bash
docker run -p 8080:3333 practice-docker
```

### Running with Custom Port

You can override the port using the `PORT` environment variable:

```bash
docker run -p 8080:8080 -e PORT=8080 practice-docker
```

### Running in Detached Mode

To run the container in the background:

```bash
docker run -d -p 3333:3333 --name practice-app practice-docker
```

### Viewing Logs

```bash
docker logs practice-app
```

Or follow logs in real-time:

```bash
docker logs -f practice-app
```

### Stopping the Container

The application supports graceful shutdown. Stop it with:

```bash
docker stop practice-app
```

### Removing the Container

```bash
docker rm practice-app
```

Or remove it automatically when stopped:

```bash
docker run --rm -p 3333:3333 practice-docker
```

## API Endpoints

### GET /

Returns a greeting message with the current timestamp in RFC3339Nano format.

**Response:**
```
Hello World! 2024-01-15T10:30:45.123456789Z
```

**Status Code:** `200 OK`

### GET /health

Health check endpoint for monitoring and load balancers.

**Response:**
```json
{"status":"healthy"}
```

**Status Code:** `200 OK`

## Configuration

- **Default Port:** `3333` (configurable via `PORT` environment variable)
- **Go Version:** `1.24.3`
- **Base Image:** `alpine:latest` (final stage)
- **Read Timeout:** `15 seconds`
- **Write Timeout:** `15 seconds`
- **Idle Timeout:** `60 seconds`

## Docker Image Details

- **Multi-stage build** for smaller final image size
- **Non-root user** for enhanced security
- **Alpine Linux** base image for minimal footprint
- **Optimized layers** for better caching

## Troubleshooting

### Port Already in Use

If you encounter a "port already in use" error:

```bash
# Find the process using the port
lsof -i :3333

# Kill the process or use a different port
kill -9 <PID>
```

Or use a different port:

```bash
PORT=8080 go run main.go
```

### Docker Build Issues

If the Docker build fails:

1. Ensure Docker is running:
   ```bash
   docker ps
   ```

2. Check the Dockerfile syntax and paths

3. Verify Go module is properly initialized:
   ```bash
   go mod tidy
   ```

4. Clean Docker build cache if needed:
   ```bash
   docker build --no-cache -t practice-docker .
   ```

### Container Won't Start

1. Check container logs:
   ```bash
   docker logs <container-name>
   ```

2. Verify port mapping:
   ```bash
   docker ps
   ```

3. Test the application locally first:
   ```bash
   go run main.go
   ```

## Development Tips

- Use `Ctrl+C` to gracefully shutdown the server when running locally
- The application handles SIGINT and SIGTERM signals for clean shutdown
- Health check endpoint can be used with orchestration tools (Kubernetes, Docker Swarm, etc.)
- All endpoints return proper HTTP status codes and headers

## License

This is a practice project for learning Docker and Go.

## Author

Created as a practice project for Docker containerization with Go.

