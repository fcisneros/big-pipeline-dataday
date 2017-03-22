#!/bin/bash

# Clean up docker resources

# Remove stopped containers
docker rm $(docker ps -a -q)

# Remove dangling docker images
docker rmi $(docker images --quiet --filter "dangling=true")
