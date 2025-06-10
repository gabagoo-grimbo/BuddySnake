local Player = gl.GameObject:extend()

function Player:new(moveSpeed)
    Player.super.new(self,"Player",0,0)
    self.bodies = {}
    self.dir = "right"
    self.lastDir = "right"
    self.moveTimer = gl.timerManager:addTimer("move",moveSpeed,true,true,function() self:move() end)
end

function Player:update()
    if gl.inputManager:isDown("moveDown") and self.lastDir ~= "up" then self.dir = "down"
    elseif gl.inputManager:isDown("moveUp") and self.lastDir ~= "down" then self.dir = "up"
    elseif gl.inputManager:isDown("moveRight") and self.lastDir ~= "left" then self.dir = "right"
    elseif gl.inputManager:isDown("moveLeft") and self.lastDir ~= "right" then self.dir = "left" end
end

function Player:drawWorld()
    for _,body in ipairs(self.bodies) do
        love.graphics.setColor(0.5,0.5,0.5)
        gl.assetManager:draw("buddy",body.x*TileSize,body.y*TileSize)
    end

    love.graphics.setColor(1,1,1)
    gl.assetManager:draw("buddy",self.x*TileSize,self.y*TileSize)
end

function Player:destroy()
    self.moveTimer:destroy()
end

function Player:move()
    if self.scene.lose then return end
    
    local prevBodyX = 0
    local prevBodyY = 0
    for i,body in ipairs(self.bodies) do
        if i == 1 then
            prevBodyX = body.x
            prevBodyY = body.y
            body.x = self.x
            body.y = self.y
        else
            local curBodyX = body.x
            local curBodyY = body.y
            body.x = prevBodyX
            body.y = prevBodyY
            prevBodyX = curBodyX
            prevBodyY = curBodyY
        end
    end

    if self.dir == "up" then
        self.y = self.y-1
        self.lastDir = "up"
    elseif self.dir == "down" then
        self.y = self.y+1
        self.lastDir = "down"
    elseif self.dir == "left" then
        self.x = self.x-1
        self.lastDir = "left"
    elseif self.dir == "right" then
        self.x = self.x+1
        self.lastDir = "right"
    end

    if not self.scene.walls then
        if self.x >= self.scene.gridWidth then self.x = 0 end
        if self.x < 0 then self.x = self.scene.gridWidth-1 end

        if self.y >= self.scene.gridHeight then self.y = 0 end
        if self.y < 0 then self.y = self.scene.gridHeight-1 end
    else
        if self.x >= self.scene.gridWidth or self.x < 0 or self.y >= self.scene.gridHeight or self.y < 0 then
            self.scene:setLose(true)  
        end
    end

    for _,body in ipairs(self.bodies) do
        if self.x == body.x and self.y == body.y then
            self.scene:setLose(true)  
        end
    end

    local apple = self.scene:getObjectByName("Apple")
    if self.x == apple.x and self.y == apple.y then
        self:addBody()
        self.scene:setScore(self.scene.score + 1)
        apple:move()
        gl.assetManager:play("Mlem")
    end
end

function Player:addBody()
    local body = {
        x = self.x,
        y = self.y
    }

    table.insert(self.bodies,body)
    return body
end

return Player