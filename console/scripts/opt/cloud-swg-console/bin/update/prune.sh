#!/bin/bash

echo "removing all dangling images..."
docker system prune --force
