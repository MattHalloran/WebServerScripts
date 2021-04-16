#!/bin/bash

# Last update: 2021-04-15
# This script is used to start all processes required for the website
# 1) Activate Python environment
# 2) Start task queue
# 3) Start database
# 4) Start development backend server
# 5) Start development frontend server

HERE=`dirname $0`
# Load functions to help with echo formatting
source "$HERE/formatting.sh"

MSG="Activating Python"
checker env_activate

# Start Task Queue
GROUP="Task Queue"
header
MSG="Starting redis server"
checker redis-start-stable
MSG="Starting Python task process"
checker task-worker-start

# **NOTE: To start postgres on Mac, use "brew services start postgresql"
GROUP="PostgreSQL"
header
MSG="Starting postgresql service"
checker service postgresql start

# Start WGSI server
GROUP="Gunicorn"
header
MSG="Starting backend server using gunicorn"
checker flask-start-dev

# Start React frontend
GROUP="Start frontend"
header
MSG="Serving production build"
checker react-start-dev