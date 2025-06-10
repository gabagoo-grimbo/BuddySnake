local timerManager = {
    timers = {}
}

function timerManager:update()
    for _,timer in ipairs(timerManager.timers) do
        if timer.running == true then
            timer.timeLeft = timer.timeLeft - 1

            if timer.timeLeft <= 0 then
                timer.onTimeOut()

                if timer.shouldRepeat == true then
                    timer:start()
                else timer:stop() end
            end
        end
    end
end

function timerManager:addTimer(name,startTime,shouldRepeat,autoStart,onTimeOut)
    local timer = {
        name = name,
        startTime = startTime,
        timeLeft = startTime,
        shouldRepeat = shouldRepeat, -- fuck you lua keywords
        autoStart = autoStart,
        onTimeOut = onTimeOut,
        running = autoStart
    }

    function timer:start()
        self.running = true
        self.timeLeft = self.startTime
    end

    function timer:stop()
        self.running = false
    end

    function timer:destroy()
        for i,v in ipairs(timerManager.timers) do
            if v.name == self.name then
                table.remove(timerManager.timers,i)
            end
        end

        self = nil
    end

    table.insert(timerManager.timers,timer)
    return timer
end

return timerManager