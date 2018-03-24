local socket = require('socket')
local client = require('src.client')

local function timeit(fn, n)
    io.write('iterations: ' .. n .. ' / elapsed ms: ')
    local start = socket.gettime() * 1000
    fn(n)
    local finish = socket.gettime() * 1000
    io.write(finish - start .. '\n')
end

local function benchmark(fn)
    for i = 1, 10 do
        timeit(fn, 10^i)
    end
    print()
end

local target = arg[1]
benchmark(client[target])
