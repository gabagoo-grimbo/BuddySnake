local Apple = gl.GameObject:extend()

function Apple:new()
    Apple.super.new(self,"Apple",7,7)
end

function Apple:drawWorld()
    love.graphics.setColor(1,0,0)
    gl.assetManager:draw("buddy",self.x*TileSize,self.y*TileSize)
end

function Apple:move()
    self.x = love.math.random(0,self.scene.gridWidth-1)
    self.y = love.math.random(0,self.scene.gridHeight-1)
end

return Apple