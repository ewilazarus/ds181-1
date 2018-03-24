local socket = require('socket')

local server = {}

-- Generates a random string of size 'contentLength'
local function generateDownloadContent(contentLength)
    local content = ''
    for i = 1, contentLength do
        content = content .. 'a'
    end
    return content
end

-- Binds the socket used by the server
function server:spawn()
    self.socket = assert(socket.bind('*', 8005))
    self.ip, server.port = server.socket:getsockname()
end

-- Processes the request
function server:process(request)
    return self.downloadContent
end

-- Initiates server with a downloadable content of size 'contentLength'
function server:init(contentLength)
    self.downloadContent = generateDownloadContent(contentLength)
    self:spawn()
end

-- Starts listening for connections
function server:listen(strategy)
    if strategy == 'keepalive' then
        server:listenKeepAlive()
    else
        server:listenNaive()
    end
end

function server:listenKeepAlive()
    local channel, err = self.socket:accept()
    if err ~= nil then
        print('Error accepting connections')
        os.exit(1)
    end

    local isClosed = false
    while true do
        local request, err = channel:receive()
        if err ~= nil then
            if err == 'closed' then
                channel:close()
                isClosed = true
                break
            else
                print('Error receiving message: ' .. err)
                os.exit(1)
            end
        end

        local response = self:process(request)
        local lastb, err, lasti = channel:send(response .. '\n')
    end

    if isClosed then
        self:listenKeepAlive()
    end
end

function server:listenNaive()
    while true do
        local channel, err = self.socket:accept()
        if err ~= nil then
            print('Error accepting connections')
            os.exit(1)
        end
        local request, err = channel:receive()
        if err ~= nil then
            print('Error receiving message')
            os.exit(1)
        end

        local response = self:process(request)
        local lastb, err, lasti = channel:send(response .. '\n')
        channel:close()
    end
end

local strategy = arg[1]

server:init(1024)
server:listen(strategy)
