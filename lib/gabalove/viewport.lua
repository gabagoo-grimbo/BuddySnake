local viewport = {
    x = 0,
    y = 0,
    width = 0,
    height = 0,
    scale = 1
}

function viewport:reset()
    self.x = 0
    self.y = 0
end

function viewport:setPos(x,y)
    self.x = x
    self.y = y
end

function viewport:setPosCenter(x,y)
    self.x = x-self.width/2
    self.y = y-self.height/2
end

function viewport:getScaledWidth()
    local width = self.width * self.scale
    return width
end

function viewport:getScaledHeight()
    local height = self.height * self.scale
    return height
end

return viewport