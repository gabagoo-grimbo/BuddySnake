local Object = gl:require "classic"

local Scene = Object:extend()

function Scene:new(name)
    self.name = name
    self.objects = {}
end

function Scene:load() end -- Callbacks
function Scene:update() end
function Scene:drawWorld() end
function Scene:drawUI() end
function Scene:stop() end

function Scene:_update()
    self:update()
    for _,object in ipairs(self.objects) do
        object:update()
    end
end

function Scene:_drawWorld()
    self:drawWorld()
    for _,object in ipairs(self.objects) do
        object:drawWorld()
    end
end

function Scene:_drawUI()
    self:drawUI()
    for _,object in ipairs(self.objects) do
        object:drawUI()
    end
end

function Scene:_stop()
    self:stop()
    for i,object in ipairs(self.objects) do
        object:destroy()
        table.remove(self.objects,i)
        object = nil
    end
end

function Scene:addObject(obj)
    table.insert(self.objects,obj)
    return obj
end

function Scene:getObjectByName(name)
    for _,v in ipairs(self.objects) do
        if v.name == name then
            return v
        end
    end
end

return Scene