local viewport = gl:require "viewport"

local mouse = {
    windowX = 0,
    windowY = 0,
    worldX = 0,
    worldY = 0
}

function mouse:update()
    self.windowX,self.windowY = love.mouse.getPosition()
    self.windowX = math.floor(self.windowX/viewport.scale)
    self.windowY = math.floor(self.windowY/viewport.scale)

    self.worldX = self.windowX+viewport.x
    self.worldY = self.windowY+viewport.y
end

return mouse