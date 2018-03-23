local socket = require('socket')

-- Generates a random string of size 1024
local function generateDownloadContent(byteSize)
    local content = ''
    for i = 1, byteSize do
        content = content .. string.char(math.random(48, 122))
    end
    return content
end

local Server = {}
Server.MasterSocket = {}

function Server.MasterSocket:spawn()
    self.socket = assert(socket.bind('*', 0))
    local ip, port = self.socket:getsockname()
    self.ip = ip
    self.port = port
end

return {generateDownloadContent = generateDownloadContent, Server = Server}
