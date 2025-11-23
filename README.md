# Practice Docker - Go Web Application

A simple Go web application containerized with Docker that serves a "Hello World" greeting endpoint.

## Overview

This project demonstrates a basic Go HTTP server application running in a Docker container. The application provides a simple REST endpoint that returns a greeting message with the current timestamp.

## Features

- Simple HTTP server written in Go
- Docker containerization
- Health check endpoint at root path (`/`)
- Returns current timestamp with greeting

## Prerequisites

- [Go](https://golang.org/dl/) 1.24.3 or later
- [Docker](https://www.docker.com/get-started) installed and running
- Basic knowledge of Go and Docker

## Project Structure

```
practice-docker/
├── Dockerfile      # Docker configuration for containerizing the application
├── go.mod         # Go module definition
├── main.go        # Main application code
└── README.md      # This file
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

3. The server will start on port `3333`. Visit:
   ```
   http://localhost:3333
   ```

4. You should see a response like:
   ```
   Hello World! 2024-01-15 10:30:45.123456789 +0000 UTC
   ```

### Building Locally

To build the application binary:

```bash
go build -o api
```

Then run the binary:

```bash
./api
```

## Docker Usage

### Building the Docker Image

```bash
docker build -t practice-docker .
```

### Running the Container

```bash
docker run -p 4444:3333 practice-docker
```

**Note:** The Dockerfile exposes port 4444, but the application listens on port 3333. Use the port mapping `-p 4444:3333` to map the container's port 3333 to host port 4444.

### Accessing the Application

Once the container is running, visit:
```
http://localhost:4444
```

### Running in Detached Mode

To run the container in the background:

```bash
docker run -d -p 4444:3333 --name practice-app practice-docker
```

### Viewing Logs

```bash
docker logs practice-app
```

### Stopping the Container

```bash
docker stop practice-app
```

### Removing the Container

```bash
docker rm practice-app
```

## API Endpoints

### GET /

Returns a greeting message with the current timestamp.

**Response:**
```
Hello World! 2024-01-15 10:30:45.123456789 +0000 UTC
```

## Configuration

- **Application Port:** 3333 (configured in `main.go`)
- **Docker Exposed Port:** 4444 (configured in `Dockerfile`)
- **Go Version:** 1.24.3

## Notes

- The Dockerfile builds the binary as `api` but the CMD references `./practice`. You may need to update the Dockerfile CMD to match the build output.
- The application listens on port 3333 internally, but Docker exposes port 4444. Use port mapping when running the container.

## Troubleshooting

### Port Already in Use

If you encounter a "port already in use" error:

```bash
# Find the process using the port
lsof -i :3333  # For local development
lsof -i :4444  # For Docker

# Kill the process or use a different port
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

## License

This is a practice project for learning Docker and Go.

## Author

Created as a practice project for Docker containerization with Go.

