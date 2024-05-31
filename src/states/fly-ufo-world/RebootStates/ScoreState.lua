ScoreState = Class{__includes = BaseState}

function ScoreState:enter(Params)
    self.score = Params.score
end

function ScoreState:update(dt)
    BackgroundScroll = (BackgroundScroll + BACKGROUNDSCROLLSPEED * dt)
    % BACKGROUND_LOOPING_POINT
    
    GroundScroll = (GroundScroll + GROUNDSCROLLSPEED * dt)
    % GROUND_LOOPING_POINT

    if love.keyboard.wasPressed("enter") or love.keyboard.wasPressed("return") then
        gStateMachine:change("fly-count")
    elseif love.keyboard.wasPressed("escape") then
        gStateMachine:change("start")
        gSounds["music-1"]:stop()
        gSounds["music-2"]:stop()
    end
end

function ScoreState:render()
    love.graphics.draw(BACKGROUNDIMAGE, -BackgroundScroll, 0)
        love.graphics.setFont(gFonts["flappyFont"])
        love.graphics.setColor(250/255, 4/255, 28/255)
        love.graphics.printf("OOPS!.. You Lost!", 0, 64, V_WIDTH, "center")

        love.graphics.setFont(gFonts["mediumFont"])
        love.graphics.setColor(19/255, 255/255, 0)
        love.graphics.printf("SCORE : " .. tostring(self.score), 0 , 100, V_WIDTH, "center")

        love.graphics.setColor(135/255, 206/255, 235/255)
        love.graphics.printf("PRESS ENTER To Play Again", 0, 124, V_WIDTH, "center")
        love.graphics.setColor(1, 1, 1)
    love.graphics.draw(GROUNDIMAGE, -GroundScroll, V_HEIGHT-32)
end