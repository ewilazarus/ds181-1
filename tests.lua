local lu = require('luaunit')
local server = require('src.server')

function testGenerateDownloadContent()
    local size = 1024
    local downloadContent = server.generateDownloadContent(size)
    lu.assertEquals(downloadContent:len(), size)
end

function testSpawnMasterSocket()
    local Server = server.Server
    Server.MasterSocket:spawn()
    lu.assertEquals(Server.MasterSocket.ip, '0.0.0.0')
    lu.assertTrue(tonumber(Server.MasterSocket.port) > 1024)
end

print(lu.LuaUnit.run('--name', './tests'))
