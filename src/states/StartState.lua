StartState = Class{__includes = BaseState}

local highlighted = 1

function StartState:init()
    love.window.setTitle("PLAY 90'S")
end

function StartState:update(dt)
    if love.keyboard.wasPressed("down") then
        gSounds["select"]:play()
        highlighted = highlighted + 1
        if highlighted > 5 then
            highlighted = 1
        end
    elseif love.keyboard.wasPressed("up") then
        gSounds["select"]:play()
        highlighted = highlighted-1
        if highlighted < 1 then
            highlighted = 5
        end
    end
    if love.keyboard.wasPressed("enter") or love.keyboard.wasPressed("return") then
        if highlighted == 1 then
            gStateMachine:change("pong-version")
        elseif highlighted == 2 then
            gStateMachine:change("fly-version")
        elseif highlighted == 3 then
            gStateMachine:change("options")
        elseif highlighted == 4 then
            gStateMachine:change("credits")
        elseif highlighted == 5 then
            love.event.quit()
        end
    end

    if love.keyboard.wasPressed("escape") then
        gStateMachine:change("intro")
    end
end

function StartState:render()
    love.graphics.draw(gTextures["credicard"], 0, 0, 0, 1, 0.8)
    love.graphics.setFont(gFonts["credi"])
    love.graphics.setColor(228/255, 34/255, 23/255, 1)
    love.graphics.printf("PLAY 90S", 0, V_HEIGHT/2-30, V_WIDTH, "center")
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.setFont(gFonts["medium"])
    -- if highlighted is 1 then color the first item in the list
    if highlighted == 1 then
        love.graphics.draw(gTextures["index"],V_WIDTH/2 - 50, V_HEIGHT/2 + 10, 0, 0.7, 0.7)
        --love.graphics.rectangle("fill",V_WIDTH/2 - 50, V_HEIGHT/2 - 5, 2, 5 )
        love.graphics.setColor(255, 17/255, 17/255, 1)
    end

    love.graphics.printf("PONG", 0, V_HEIGHT / 2 + 10, V_WIDTH, "center")
    -- resets back to the color
    love.graphics.setColor(1, 1, 1, 1)

    if highlighted == 2 then
        love.graphics.draw(gTextures["index"],V_WIDTH/2 - 50, V_HEIGHT/2 + 30, 0, 0.7, 0.7)
        love.graphics.setColor(255, 17/255, 17/255, 1)
    end

    love.graphics.printf("FLY-UFO", 0, V_HEIGHT / 2 + 30, V_WIDTH, "center")
    love.graphics.setColor(1, 1, 1, 1)

    if highlighted == 3 then
        love.graphics.draw(gTextures["index"],V_WIDTH/2 - 50, V_HEIGHT/2 + 50, 0, 0.7, 0.7)
        love.graphics.setColor(255, 17/255, 17/255, 1)
    end

    love.graphics.printf("INSTRUCTIONS", 0, V_HEIGHT / 2 + 50, V_WIDTH, "center")
    love.graphics.setColor(1, 1, 1, 1)


    if highlighted == 4 then
        love.graphics.draw(gTextures["index"],V_WIDTH/2 - 50, V_HEIGHT/2 + 70, 0, 0.7, 0.7)
        love.graphics.setColor(255, 17/255, 17/255, 1)
    end

    love.graphics.printf("CREDITS", 0, V_HEIGHT / 2 + 70, V_WIDTH, "center")
    love.graphics.setColor(1, 1, 1, 1)


    if highlighted == 5 then
        love.graphics.draw(gTextures["index"],V_WIDTH/2 - 50, V_HEIGHT/2 + 90, 0, 0.7, 0.7)
        love.graphics.setColor(255, 17/255, 17/255, 1)
    end

    love.graphics.printf("EXIT", 0, V_HEIGHT / 2 + 90, V_WIDTH, "center")
    love.graphics.setColor(1, 1, 1, 1)
end