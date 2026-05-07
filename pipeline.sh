#!/bin/bash

echo "Starting ML Pipeline..."

# Pull latest data from GitHub
echo "Fetching latest data..."
git pull origin main

# Train the model
echo "Training model..."
python3 train.py

# Rebuild Docker container
echo "Rebuilding Docker..."
docker build -t ml-api .

echo "Restarting container..."
docker stop ml-api 2>/dev/null || true
docker rm ml-api 2>/dev/null || true
docker run -d -p 8000:8000 --name ml-api ml-api

echo "Pipeline completed!"
