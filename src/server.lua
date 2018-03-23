-- Generates a random string of size 1024
local function generateDownloadContent()
    local content = ''
    for i = 1, 1024 do
        content = content .. string.char(math.random(48, 122))
    end
    return content
end

return {generateDownloadContent = generateDownloadContent}
