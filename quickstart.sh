#!/bin/bash
SERVERS=${1:-1}
MIN_SERVERS=${2:-1}
PROBABILITY=${3:-0.001}
CURRENT_DIR=$(pwd)

# Build the Docker image
docker build --no-cache -t my-haproxy .

# Run the HAProxy container
docker run -d -p 8080:80 -p 8404:8404 --name my-running-haproxy --sysctl net.ipv4.ip_unprivileged_port_start=0 -v /$CURRENT_DIR/logs:/var/log my-haproxy

# Execute a command in a running container
docker exec -it my-running-haproxy sh -c "python /usr/local/src/main.py -s $SERVERS -m $MIN_SERVERS -p $PROBABILITY"


