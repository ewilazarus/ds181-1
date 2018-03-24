local socket = require('socket')

IP = '127.0.0.1'
PORT = '8005'
MESSAGE = 'download\n'


local function naive(n)
    -- errc = 0
    local i = 1
    while i <= n do
        i = i + 1
        local s = assert(socket.tcp())
        s:connect(IP, PORT)
        s:send(MESSAGE)
        while true do
            local data, err, partial = s:receive()
            if err ~= nil then
                -- errc = errc + 1
                i = i - 1
                break
            elseif data ~= nil and data:len() == 1024 then
                -- RECEIVED THE BYTES
                break
            end
        end
        socket.sleep(0)
        s:close()
    end
    -- print('ERROS: ' .. errc)
end

local function keepalive(n)
    -- errc = 0
    local s = assert(socket.tcp())
    s:connect(IP, PORT)
    local i = 1
    while i <= n do
        i = i + 1
        s:send(MESSAGE)
        while true do
            local data, err, partial = s:receive()
            if err ~= nil then
                -- errc = errc + 1
                -- i = i - 1
                break
            elseif data ~= nil and data:len() == 1024 then
                -- RECEIVED THE BYTES
                break
            end
        end
        socket.sleep(0)
    end
    s:close()
    -- print('ERROS: ' .. errc)
end

return {naive = naive, keepalive = keepalive}
