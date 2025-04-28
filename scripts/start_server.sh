#!/bin/bash
cd /home/ec2-user/backend
npm install
node server.js > server.log 2>&1 &
