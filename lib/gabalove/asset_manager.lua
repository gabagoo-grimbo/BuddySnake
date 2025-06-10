local assetManager = {
    images = {},
    sheets = {},
    sounds = {},
    fonts = {}
}

-- Images
function assetManager:importImage(imageName,filePath)
    local image = {}
    image.name = imageName
    image.filePath = filePath
    image.data = love.graphics.newImage(filePath)

    table.insert(self.images,image)
end

function assetManager:getImage(imageName)
    local image = nil

    for i,v in ipairs(self.images) do
        if v.name == imageName then
            image = v
        end
    end

    return image
end

function assetManager:draw(imageName, x, y, r, sx, sy, ox, oy, kx, ky)
    love.graphics.draw(assetManager:getImage(imageName).data, x, y, r, sx, sy, ox, oy, kx, ky)
end

-- Sheets
function assetManager:importSheet(sheetName, filePath, cellWidth, cellHeight)
    local sheet = {}
    sheet.name = sheetName
    sheet.filePath = filePath
    sheet.data = love.graphics.newImage(filePath)
    sheet.cellWidth = cellWidth
    sheet.cellHeight = cellHeight

    sheet.quads = {}
    for y = 0, sheet.data:getHeight() - cellHeight, cellHeight do
        for x = 0, sheet.data:getWidth() - cellWidth, cellWidth do
            table.insert(sheet.quads, love.graphics.newQuad(x, y, cellWidth, cellHeight, sheet.data:getDimensions()))
        end
    end

    table.insert(self.sheets,sheet)
end

function assetManager:getSheet(sheetName)
    local sheet = nil

    for i,v in ipairs(self.sheets) do
        if v.name == sheetName then
            sheet = v
        end
    end

    return sheet
end

function assetManager:drawqf(sheetName,tileNum,x,y,flipx,flipy)
    local sx = 1
    local sy = 1
    local ox = 0
    local oy = 0
    if flipx == true then
        sx = -1
        ox = self:getSheet(sheetName).cellWidth
    end
    if flipy == true then
        sy = -1
        oy = self:getSheet(sheetName).cellHeight
    end

    self:drawq(sheetName,tileNum,x,y,0,sx,sy,ox,oy)
end

function assetManager:drawq(sheetName,tileNum,x,y,r,sx,sy,ox,oy,kx,ky)
    local r = r or 0
    local sx = sx or 1
    local sy = sy or 1
    local ox = ox or 0
    local oy = oy or 0
    local kx = kx or 0
    local ky = ky or 0
    love.graphics.draw(self:getSheet(sheetName).data,self:getSheet(sheetName).quads[tileNum],x,y,r,sx,sy,ox,oy,kx,ky)
end

--Fonts
function assetManager:importFont(fontName, filePath, size)
    local font = {}
    font.name = fontName
    font.filePath = filePath
    font.size = size
    font.data = love.graphics.newFont(filePath, size)

    table.insert(self.fonts,font)
end

function assetManager:getFont(fontName)
    local font = nil

    for i,v in ipairs(self.fonts) do
        if v.name == fontName then
            font = v
        end
    end

    return font
end

function assetManager:print(fontName,text,x,y,r,sx,sy,ox,oy,kx,ky)
    local x = x or 0
    local y = y or 0
    love.graphics.setFont(assetManager:getFont(fontName).data)
    love.graphics.print(text,x,y,r,sx,sy,ox,oy,kx,ky)
end

function assetManager:printCenter(fontName,text,_x,y)
    local x = _x-self:getFont(fontName).data:getWidth(text)/2

    self:print(fontName,text,x,y)
end

return assetManager