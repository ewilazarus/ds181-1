local socket = require('socket')
local client = require('client')

BATCH_COUNT = 10


local function timeit(fn, n)
    io.write('messages: ' .. n .. ' / elapsed ms: ')
    local start = socket.gettime() * 1000
    fn(5)  -- TODO: fazer voltar a ser N
    local finish = socket.gettime() * 1000
    local elapsed = finish - start
    io.write(elapsed .. ' / ratio: ' .. n / elapsed .. ' (messages/ms)\n')
    return elapsed
end

local function benchmark(fn)
    local iterations = 0
    local elapsed = 0
    for i = 1, BATCH_COUNT do
        local it = 10^i
        local e = timeit(fn, it)
        iterations = iterations + it
        elapsed = elapsed + e
    end
    io.write('TOTAL messages: ' .. iterations .. ' / TOTAL elapsed ms: ' .. elapsed .. ' / TOTAL ratio: ' .. iterations / elapsed .. ' (messasges/ms)')
    print()
end

local target = arg[1]
benchmark(client[target])
