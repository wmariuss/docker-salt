#!/bin/bash

set -xe

# Build docker images
docker-compose build --force-rm --parallel

