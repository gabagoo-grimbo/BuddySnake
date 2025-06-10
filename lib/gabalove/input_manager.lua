local inputManager = {
    inputs = {}
}

function inputManager:update()
    -- Inputs
    for i,input in ipairs(self.inputs) do
        local isDownLastFrame = input.isDown

        input.isDown = false
        input.justReleased = false
        input.justPressed = false
        for i2,key in ipairs(input.keys) do
            if love.keyboard.isDown(key) then
                input.isDown = true
                if isDownLastFrame == false then
                    input.justPressed = true
                end
            end
        end
        for i2,mouseButton in ipairs(input.mouseButtons) do
            if love.mouse.isDown(mouseButton) then
                input.isDown = true
                if isDownLastFrame == false then
                    input.justPressed = true
                end
            end
        end

        if isDownLastFrame == true and input.isDown == false then
            input.justReleased = true
        end
    end
end

function inputManager:addInput(name, keys, mouseButtons)
    local input = {}
    input.name = name
    input.keys = keys
    input.mouseButtons = mouseButtons
    input.isDown = false
    input.justReleased = false
    input.justPressed = false

    table.insert(self.inputs,input)
end

function inputManager:getInput (name)
    local input = nil
    
    for i,v in ipairs(self.inputs) do
        if v.name == name then
            input = v
        end
    end

    return input
end

function inputManager:isDown(inputName)
    local isDown = self:getInput(inputName).isDown
    return isDown
end

function inputManager:justReleased(inputName)
    local justReleased = self:getInput(inputName).justReleased
    return justReleased
end

function inputManager:justPressed(inputName)
    local justPressed = self:getInput(inputName).justPressed
    return justPressed
end

return inputManager