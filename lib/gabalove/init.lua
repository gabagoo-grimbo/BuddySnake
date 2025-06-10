gl = {
    version = "Gabalove 0.0.1",
    license = "This library is free software; you can redistribute it and/or modify it under the terms of the MIT license. See LICENSE for details.",
    copyright = "Copyright (c) 2014, Gabagoo",
    path = ...,
}
function gl:require(moduleName)
    return require(self.path .. "." .. moduleName)
end

gl.Object = gl:require "classic" -- I didnt make this but its really good and its what I would have done so fuck you
gl.GameObject = gl:require "game_object"
gl.Scene = gl:require "scene.scene"

gl.sceneManager = gl:require "scene.scene_manager"
gl.timerManager = gl:require "timer.timer_manager"
gl.assetManager = gl:require "asset_manager"
gl.inputManager = gl:require "input_manager"
gl.window = gl:require "window"
gl.mouse = gl:require "mouse"
gl.viewport = gl:require "viewport"
gl.math = gl:require "math"

local gl = gl
_G.gl = nil

function gl:load(viewportWidth,viewportHeight,viewportScale)
    self.window.openConsole()
    self.viewport.width = viewportWidth
    self.viewport.height = viewportHeight
    self.viewport.scale = viewportScale
    
    local winWidth = self.viewport:getScaledWidth()
    local winHeight = self.viewport:getScaledHeight()

    self.window:setSize(winWidth,winHeight)
    
    self.sceneManager:addScene(gl.Scene,"Default")
    self.sceneManager:changeScene("Default")

    self.initAssets()
    self.initInputs()
end

function gl:update()
    self.inputManager:update()
    self.mouse:update()
    self.timerManager:update()
    self.sceneManager.currentScene:_update()
end

function gl:draw()
    love.graphics.clear(self.math.rgb8(255,183,206))

    love.graphics.origin()
    love.graphics.scale(self.viewport.scale)
    love.graphics.translate(-self.viewport.x,-self.viewport.y)
    self.sceneManager.currentScene:_drawWorld()

    love.graphics.origin()
    love.graphics.scale(self.viewport.scale)
    self.sceneManager.currentScene:_drawUI()
end

function gl.initInputs()

end

function gl.initAssets()

end

return gl