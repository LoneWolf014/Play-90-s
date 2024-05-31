BreakVersionState = Class{__includes = BaseState}

local highlighted = 1

function BreakVersionState:update(dt)
    if love.keyboard.wasPressed("down") then
        highlighted = highlighted == 1 and 2 or 1
        gSounds["select"]:play()
    elseif love.keyboard.wasPressed("up") then
        highlighted = highlighted == 2 and 1 or 2
        gSounds["select"]:play()
    end

    if love.keyboard.wasPressed("enter") or love.keyboard.wasPressed("return") then
        if highlighted == 2 then
            gStateMachine:change("break-start")
        elseif highlighted == 1 then
            gStateMachine:change("classic-break-start")
        end
    end

    if love.keyboard.wasPressed("escape") then
        gStateMachine:change("start")
    end
end

function BreakVersionState:render()
    love.graphics.setFont(gFonts["large"])
    love.graphics.setColor(2/255, 215/255, 242/255, 1)
    love.graphics.printf("BREAK OUT", 0, V_HEIGHT/3, V_WIDTH, "center")
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.setFont(gFonts["medium"])
    -- if highlighted is 1 then color the first item in the list
    if highlighted == 1 then
        love.graphics.setColor(255, 17/255, 17/255, 1)
    end

    love.graphics.printf("CLASSIC", 0, V_HEIGHT / 2 + 30, V_WIDTH, "center")
    -- resets back to the color
    love.graphics.setColor(1, 1, 1, 1)

    if highlighted == 2 then
        love.graphics.setColor(255, 17/255, 17/255, 1)
    end

    love.graphics.printf("REBOOT", 0, V_HEIGHT / 2 + 50, V_WIDTH, "center")
    love.graphics.setColor(1, 1, 1, 1)
end