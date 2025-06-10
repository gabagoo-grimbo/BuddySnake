local Object = gl:require("classic")
local sceneManager = gl:require("scene.scene_manager")

local GameObject = Object:extend()

function GameObject:new(name,x,y)
    self.name = name or ""
    self.x = x or 0
    self.y = y or 0
    self.scene = sceneManager.currentScene
end

-- Callbacks
function GameObject:update() end
function GameObject:drawWorld() end
function GameObject:drawUI() end
function GameObject:destroy() end

return GameObject