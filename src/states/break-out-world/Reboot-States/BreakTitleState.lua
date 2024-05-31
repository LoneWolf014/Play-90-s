BreakTitleState = Class{__includes = BaseState}

function BreakTitleState:init()

    love.window.setTitle("Brick Break")

    love.graphics.setFont(gFonts["small"])

    love.keyboard.keysPressed = {}
end

function BreakTitleState:update(dt)

    if love.keyboard.wasPressed("enter") or love.keyboard.wasPressed("return") then
        gStateMachine:change("break-play")
    elseif love.keyboard.wasPressed("escape") then
        gStateMachine:change("start")
        --gSounds["music-1"]:stop()
    end
end

function BreakTitleState:render()

    local backgroundWidth = gTextures["background"]:getWidth()
    local backgroundHeight = gTextures["background"]:getHeight()

    love.graphics.draw(gTextures["background"], 0, 0, 0, V_WIDTH/(backgroundWidth-1), V_HEIGHT/(backgroundHeight-1))

    --gStateMachine:render()

    breakFPS()
    love.graphics.setFont(gFonts["large"])
    love.graphics.setColor(2/255, 215/255, 242/255, 1)
    love.graphics.printf("BRICK BLAST", 0, 64, V_WIDTH, "center")
    love.graphics.setColor(1, 1, 1)

    love.graphics.setFont(gFonts["medium"])
    love.graphics.setColor(255, 17/255, 17/255, 1)
    love.graphics.printf("Press Enter", 0, 100, V_WIDTH, "center")
    love.graphics.setColor(1, 1, 1)

end

function breakFPS()
    love.graphics.setFont(gFonts["small"])
    love.graphics.setColor(255, 0, 0, 255)
    love.graphics.print("FPS:" .. tostring(love.timer.getFPS()), 5, 5)
    love.graphics.setColor(1, 1, 1)
end