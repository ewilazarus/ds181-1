#!/bin/bash

echo "Starting"

echo "1. Setting up LUA paths"
export LUA_PATH="$LUA_PATH;./.rocks/share/lua/5.3/?.lua;./src/?.lua"
export LUA_CPATH="$LUA_CPATH;./.rocks/lib/lua/5.3/?.so"

echo "2. Running benchmarks"

# echo "2.1. NAIVE communication"
# echo "2.1.1. Starting NAIVE server"
# lua src/server.lua naive &
# SERVER_PID=$!

# echo "2.1.2. Sending messages"
# echo "2.1.2.1. Batch #1"
# lua src/benchmark.lua naive
# echo "2.1.2.2. Batch #2"
# lua src/benchmark.lua naive
# echo "2.1.2.3. Batch #3"
# lua src/benchmark.lua naive
# echo "2.1.2.4. Batch #4"
# lua src/benchmark.lua naive
# echo "2.1.2.5. Batch #5"
# lua src/benchmark.lua naive

# echo "2.1.3. Shutting down NAIVE server"
# kill -9 $SERVER_PID > /dev/null

echo "2.2. KEEP ALIVE communication"
echo "2.2.1. Starting KEEP ALIVE server"
lua src/server.lua keepalive &
SERVER_PID=$!

echo "2.2.2. Sending messages"
lua src/benchmark.lua keepalive

echo "2.2.3. Shutting down KEEP ALIVE server"
kill -9 $SERVER_PID > /dev/null

echo "Done"
