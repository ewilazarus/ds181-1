local socket = require('socket')

IP = '127.0.0.1'
PORT = '8003'
MESSAGE = 'download\n'


local function naive(n)
    local i = 1
    while i <= n do
        i = i + 1
        local s = assert(socket.tcp())
        s:connect(IP, PORT)
        s:send(MESSAGE)
        while true do
            local data, err, partial = s:receive()
            if err ~= nil then
                i = i - 1
                break
            elseif data ~= nil and data:len() == 1024 then
                break
            end
        end
        s:close()
    end
end

local function keepalive(n)
    local s = assert(socket.tcp())
    s:connect(IP, PORT)
    s:setoption('keepalive', true)
    local i = 1
    while i <= n do
        i = i + 1
        s:send(MESSAGE)
        while true do
            local data, err, partial = s:receive()
            if err ~= nil then
                print(err)
                -- i = i - 1
                break
            elseif data ~= nil and data:len() == 1024 then
                break
            end
        end
    end
    s:close()
end

return {naive = naive, keepalive = keepalive}
