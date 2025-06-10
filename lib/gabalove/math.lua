local m = {} -- Math is already a standard library

function m.clamp(val, min, max)
    local val = val
    if val < min then val = min end
    if val > max then val = max end
    return val
end

function m.round(val)
    return math.floor(val+0.5)
end

-- Booleans
function m.flipBool(_bool)
    local bool = _bool

    if bool == true then val = false 
    elseif bool == false then val = true end

    return bool
end

function m.boolToBit(bool)
    local bool = bool

    if bool == true then val = 1 
    elseif bool == false then val = 0 end

    return val
end

function m.flipBit(_bit)
    local bit = _bit

    if bit == 0 then bit = 1 
    elseif bit == 1 then bit = 0 end

    return bit
end

function m.bitToBool(bit)
    local bit = bit

    if bit == 1 then bit = true 
    elseif bit == 0 then bit = false end

    return bit
end

function m.rgb8(r,g,b)
    local newR = m.clamp(r/255,0,1)
    local newG = m.clamp(g/255,0,1)
    local newB = m.clamp(b/255,0,1)
    return newR,newG,newB
end

return m