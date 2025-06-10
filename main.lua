gl = require "lib.gabalove"

local TitleScene = require "title_scene"
local SnakeScene = require "snake_scene"

local CamWidth = 640
local CamHeight = 480
local WinScale = 1

HighScore = 0
TileSize = 32

-- Game loop
function love.load()
    gl:load(CamWidth,CamHeight,WinScale)
    love.math.setRandomSeed(love.timer.getTime())
    love.graphics.setDefaultFilter("nearest")
    gl.sceneManager:addScene(TitleScene,"Title")
    gl.sceneManager:addScene(SnakeScene,"Snake")
    gl.sceneManager:changeScene("Title")
end

function love.update()
    gl:update()
    print(love.timer.getFPS())
end

function love.draw()
    gl:draw()
end

function gl.initAssets()
    gl.assetManager:importImage("buddy","assets/png/buddy.png")
    gl.assetManager:importImage("buddy board","assets/png/buddy_board.png")

    gl.assetManager:importFont("ibm32","assets/font/MxPlus_IBM_EGA_8x8.ttf",32)
    gl.assetManager:importFont("ibm16","assets/font/MxPlus_IBM_EGA_8x8.ttf",16)
end

function gl.initInputs()
    gl.inputManager:addInput("moveUp",{"w","up"},{})
    gl.inputManager:addInput("moveLeft",{"a","left"},{})
    gl.inputManager:addInput("moveDown",{"s","down"},{})
    gl.inputManager:addInput("moveRight",{"d","right"},{})
    gl.inputManager:addInput("move",{"w","up","a","left","s","down","d","right"},{})
    gl.inputManager:addInput("start",{"z","return","space"},{})
end
