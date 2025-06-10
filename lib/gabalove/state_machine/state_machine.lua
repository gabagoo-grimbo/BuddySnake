local Object = gl:require("classic")

local StateMachine = Object:extend()

function StateMachine:new()
    self.states = {}
end

function StateMachine:addState(state)
    table.insert(self.states,state)
    return state
end