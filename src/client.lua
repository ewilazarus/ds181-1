local socket = require('socket')

IP = '127.0.0.1'
PORT = '8000'
MESSAGE = 'download\n'


local function naive(n)
    local s = assert(socket.tcp())
    for i = 1, n do
        s:connect(IP, PORT)
        s:send(MESSAGE)
        while true do
            local data, err, partial = s:receive()
            if err == 'closed' or err == 'timeout' then
                break
            end
        end
        s:close()
    end
end

local function keepalive(n)
    local s = assert(socket.tcp())
    s:connect(IP, PORT)
    for i = 1, n do
        s:send(MESSAGE)
        while true do
            local data, err, partial = s:receive()
            if err == 'closed' or err == 'timeout' then
                s:connect(IP, PORT)
                i--
            end
        end
    end
    s:close()
end

return {naive = naive, keepalive = keepalive}
