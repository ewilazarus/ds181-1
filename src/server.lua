local socket = require('socket')

-- Generates a random string of size 'contentLength'
local function generateDownloadContent(contentLength)
    local content = ''
    for i = 1, contentLength do
        content = content .. 'a'
    end
    return content
end

-- Binds the socket used by the server
local function spawn(server)
    server.socket = assert(socket.bind('*', 8000))
    server.ip, server.port = server.socket:getsockname()
end

-- Processes the request
local function process(server, request)
    return server.downloadContent
end

function listen(server)
    while server.isListening do
        local channel, err = server.socket:accept()
        if err ~= nil then
            print('Error accepting connections')
            os.exit(1)
        end

        local request, err = channel:receive()
        if err ~= nil then
            print('Error receiving message')
            os.exit(1)
        end

        local response = process(server, request)
        channel:send(response .. '\n')

        channel:close()
    end
end


local server = {}
-- Initiates server with a downloadable content of size 'contentLength'
function server:init(contentLength)
    self.downloadContent = generateDownloadContent(contentLength)
    spawn(self)
end

-- Starts listening for connections
function server:listen(keepAlive, timeout)
    self.timeout = timeout or 2
    self.isListening = true

    listen(self)
end

-- Disposes the server
function server:dispose()
    self.isListening = false
end


server:init(1024)
server:listen(false, 10)
