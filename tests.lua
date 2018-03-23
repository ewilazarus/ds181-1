local lu = require('luaunit')
local server = require('src.server')

function testGenerateDownloadContent()
    local downloadContent = server.generateDownloadContent()
    lu.assertEquals(downloadContent:len(), 1024)
end

print(lu.LuaUnit.run('--name', './tests'))
