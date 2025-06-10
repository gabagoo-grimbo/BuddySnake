local sceneManager = {
    currentScene = nil,
    scenes = {}
}

function sceneManager:changeScene(name,...)
    if self.currentScene ~= nil then
        self.currentScene:_stop()
    end
    self.currentScene = nil
    self.currentScene = self:getScene(name)(...)
    for _,object in ipairs(self.currentScene.objects) do -- Scene isnt set to currentScene yet when created so we have to set the scene variable of the objects manually
        object.scene = self.currentScene
    end
end

function sceneManager:getScene(name)
    return self.scenes[name]
end

function sceneManager:addScene(scene,name)
    self.scenes[name] = scene
    return scene
end

return sceneManager