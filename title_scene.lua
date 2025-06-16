local TitleScene = gl.Scene:extend()

function TitleScene:new()
    TitleScene.super.new(self,"Title")
    self.cursorSelection = 0
end

function TitleScene:update()
    if gl.inputManager:justPressed("moveDown") then
        self.cursorSelection = self.cursorSelection + 1
        gl.assetManager:play("Move Cursor")
    end

    if gl.inputManager:justPressed("moveUp") then
        self.cursorSelection = self.cursorSelection - 1
        gl.assetManager:play("Move Cursor")
    end

    self.cursorSelection = gl.math.clamp(self.cursorSelection,0,6)

    local difficulty = "Normal"
    local walls = false

    if gl.inputManager:justPressed("start") then
        gl.assetManager:play("Select")
        if self.cursorSelection == 0 then
            difficulty = "Easy"
            walls = false
        end
        if self.cursorSelection == 1 then
            difficulty = "Normal"
            walls = false
        end
        if self.cursorSelection == 2 then
            difficulty = "Hard"
            walls = false
        end

        if self.cursorSelection == 3 then
            difficulty = "Easy"
            walls = true
        end

        if self.cursorSelection == 4 then
            difficulty = "Normal"
            walls = true
        end

        if self.cursorSelection == 5 then
            difficulty = "Hard"
            walls = true
        end

        if self.cursorSelection == 6 then
            love.event.quit()
        else
            gl.sceneManager:changeScene("Snake",difficulty,walls)
        end
    end
end

function TitleScene:drawUI()
    for x=0,19 do
        for y=0, 14 do
            love.graphics.setColor(0.25,0.25,0.25)
            gl.assetManager:draw("buddy",x*TileSize,y*TileSize)
        end
    end

    love.graphics.translate(0,32)

    love.graphics.setColor(1,0,0)
    gl.assetManager:printCenter("ibm32","BUDDY SNAKE",320,0)
    love.graphics.setColor(1,1,1)
    gl.assetManager:printCenter("ibm16","High Score: ".. HighScore,320,32)

    gl.assetManager:printCenter("ibm16","Easy",320,64)
    gl.assetManager:printCenter("ibm16","Normal",320,96)
    gl.assetManager:printCenter("ibm16","Hard",320,96+32)
    gl.assetManager:printCenter("ibm16","Walls Easy",320,96+64)
    gl.assetManager:printCenter("ibm16","Walls Normal",320,96+96)
    gl.assetManager:printCenter("ibm16","Walls Hard",320,96+128)
    gl.assetManager:printCenter("ibm16","Quit",320,96+128+32)

    -- Cursor position
    local cursorY = 0
    if self.cursorSelection == 0 then
        cursorY = 64
    elseif self.cursorSelection == 1 then
        cursorY = 96
    elseif self.cursorSelection == 2 then
        cursorY = 96+32
    elseif self.cursorSelection == 3 then
        cursorY = 96+64
    elseif self.cursorSelection == 4 then
        cursorY = 96+96
    elseif self.cursorSelection == 5 then
        cursorY = 96+128
    elseif self.cursorSelection == 6 then
        cursorY = 96+128+32
    end

    gl.assetManager:print("ibm16",">",320-6*16-16,cursorY)
end

return TitleScene