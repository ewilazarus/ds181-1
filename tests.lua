local lu = require('luaunit')

function testExample()
    lu.assertEquals(1, 1, '1 + 1 should be 2')
end

print(lu.LuaUnit.run('--name', './tests'))
