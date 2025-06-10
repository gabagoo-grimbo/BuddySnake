local window = {
    width = 0,
    height = 0
}

function window:setSize(width,height)
    self.width = width
    self.height = height
    love.window.setMode(self.width,self.height)
end

function window.openConsole()
    love._openConsole()
end

function window.closeConsole()
    love._closeConsole()
end

return window