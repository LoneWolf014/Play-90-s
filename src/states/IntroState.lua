IntroState = Class{__includes = BaseState}

local highlighted = 1

function IntroState:init()
    love.window.setTitle("PLAY 90'S")
end

function IntroState:update(dt)
    if love.keyboard.wasPressed("down") then
        highlighted = highlighted == 1 and 2 or 1
        gSounds["select"]:play()
    elseif love.keyboard.wasPressed("up") then
        highlighted = highlighted == 2 and 1 or 2
        gSounds["select"]:play()
    end
    if love.keyboard.wasPressed("enter") or love.keyboard.wasPressed("return") then
        if highlighted == 1 then
            gStateMachine:change("start")
        elseif highlighted == 2 then
            love.event.quit()
        end
    end

    if love.keyboard.wasPressed("escape") then
        love.event.quit()
    end
end

function IntroState:render()
    love.graphics.setFont(gFonts["large"])
    love.graphics.setColor(2/255, 215/255, 242/255, 1)
    love.graphics.printf("PLAY 90S", 0, V_HEIGHT/2-30, V_WIDTH, "center")
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.setFont(gFonts["medium"])
    -- if highlighted is 1 then color the first item in the list
    if highlighted == 1 then
        love.graphics.draw(gTextures["index"],V_WIDTH/2 - 40, V_HEIGHT/2 + 50, 0, 0.7, 0.7)
        --love.graphics.rectangle("fill",V_WIDTH/2 - 50, V_HEIGHT/2 - 5, 2, 5 )
        love.graphics.setColor(255, 17/255, 17/255, 1)
    end

    love.graphics.printf("START", 0, V_HEIGHT / 2 + 50, V_WIDTH, "center")
    -- resets back to the color
    love.graphics.setColor(1, 1, 1, 1)

    if highlighted == 2 then
        love.graphics.draw(gTextures["index"],V_WIDTH/2 - 40, V_HEIGHT/2 + 70, 0, 0.7, 0.7)
        love.graphics.setColor(255, 17/255, 17/255, 1)
    end

    love.graphics.printf("EXIT", 0, V_HEIGHT / 2 + 70, V_WIDTH, "center")
    love.graphics.setColor(1, 1, 1, 1)
end