#!/bin/bash

echo "Starting"

echo "1. Setting up LUA paths"
export LUA_PATH="$LUA_PATH;./.rocks/share/lua/5.3/?.lua"
export LUA_CPATH="$LUA_CPATH;./.rocks/lib/lua/5.3/?.so"

echo "2. Running benchmarks"

echo "2.1. NAIVE communication"
echo "2.1.1. Starting NAIVE server"
lua src/server.lua naive &
SERVER_PID=$!

echo "2.1.2. Sending messages"
lua src/benchmark.lua naive

echo "2.1.3. Shutting down NAIVE server"
pkill $SERVER_PID

echo "2.2. KEEP ALIVE communication"
echo "2.2.1. Starting KEEP ALIVE server"
lua src/server.lua keepalive &
SERVER_PID=$!

echo "2.2.2. Sending messages"
lua src/benchmark.lua keepalive

echo "2.2.3. Shutting down KEEP ALIVE server"
pkill $SERVER_PID

echo "Done"
