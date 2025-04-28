#!/bin/bash

# Kill any existing Node.js process
pkill node || true

# Move into correct backend directory
cd /home/ec2-user/cap-1/backend

# Install backend dependencies
npm install

# Start Node.js server in background and save logs
nohup node server.js > server.log 2>&1 &
