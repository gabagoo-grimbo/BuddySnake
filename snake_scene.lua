local Player = require "player"
local Apple = require "apple"

local SnakeScene = gl.Scene:extend()

function SnakeScene:new(difficulty,walls)
    SnakeScene.super.new(self,"Snake")

    self.difficulty = difficulty
    self.walls = walls

    self.lose = false
    self.score = 0
    self.gridWidth = 15
    self.gridHeight = 15
    self.startAgain = true

    local moveSpeed = 0 -- Easy: 15, Normal: 10, Hard: 5
    if self.difficulty == "Easy" then moveSpeed = 15 end
    if self.difficulty == "Normal" then moveSpeed = 10 end
    if self.difficulty == "Hard" then moveSpeed = 5 end
    self:addObject(Player(moveSpeed))
    self:addObject(Apple())

    gl.viewport:setPos(-160,0)
end

function SnakeScene:update()
    if self.lose then
        gl.assetManager:stop("Paper Steak")

        if gl.inputManager:justPressed("moveUp") then
            gl.assetManager:play("Move Cursor")
            self.startAgain = true
        end
        if gl.inputManager:justPressed("moveDown") then
            gl.assetManager:play("Move Cursor")
            self.startAgain = false
        end

        if gl.inputManager:justPressed("start") then
            gl.assetManager:play("Select")
            if self.startAgain then
                gl.sceneManager:changeScene("Snake",self.difficulty,self.walls)
            else
                gl.sceneManager:changeScene("Title")
            end
        end
    else
        if not gl.assetManager:isPlaying("Paper Steak") then
            gl.assetManager:play("Paper Steak")
        end
    end
end

function SnakeScene:drawWorld()
    for x=0,self.gridWidth-1 do
        for y=0, self.gridHeight-1 do
            love.graphics.setColor(0,1,0)
            gl.assetManager:draw("buddy",x*TileSize,y*TileSize)
        end
    end
end

function SnakeScene:drawUI()
    for x=0,4 do
        for y=0,6 do
            love.graphics.setColor(0.25,0.25,0.25)
            gl.assetManager:draw("buddy",x*TileSize,y*TileSize)
        end
    end

    love.graphics.setColor(1,1,1)
    gl.assetManager:print("ibm32","Score\n "..self.score.."\nHi\n "..HighScore,0,0)

    gl.assetManager:draw("buddy board",0,194)

    if self.lose then
        love.graphics.setColor(1,0,0)
        gl.assetManager:printCenter("ibm32","YOU LOSE",416,196)
        love.graphics.setColor(1,1,1)
        gl.assetManager:printCenter("ibm16","Start Again?",408,224+32)
        gl.assetManager:printCenter("ibm16","Yes",400,224+64)
        gl.assetManager:printCenter("ibm16","No",400,224+96)

        local cursorY = 0
        if self.startAgain then
           cursorY = 224+64
        else
            cursorY = 224+96
        end

        gl.assetManager:print("ibm16",">",384-24,cursorY)
    end
end

function SnakeScene:setLose(bool)
    if bool then
       self.lose = true
       gl.assetManager:play("Womp")
    else
        self.lose = false
    end
end

function SnakeScene:setScore(n)
    self.score = n
    if self.score > HighScore then
        SetHighscore(self.score)
    end
end

return SnakeScene