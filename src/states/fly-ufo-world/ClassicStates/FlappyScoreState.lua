FlappyScoreState = Class{__includes = BaseState}

function FlappyScoreState:enter(Params)
    self.score = Params.score
end

function FlappyScoreState:update(dt)
    WorldScroll = (WorldScroll + WORLDSCROLLSPEED * dt)
    % WORLD_LOOPING_POINT
    
    FlappyGroundScroll = (FlappyGroundScroll + FLAPPYGROUNDSCROLLSPEED * dt)
    % FLAPPYGROUND_LOOPING_POINT

    if love.keyboard.wasPressed("enter") or love.keyboard.wasPressed("return") then
        gStateMachine:change("flappy-count")
    elseif love.keyboard.wasPressed("escape") then
        gStateMachine:change("fly-version")
        gSounds["flappy-bgm"]:stop()
    end
end

function FlappyScoreState:render()
    love.graphics.draw(WORLDIMAGE, -WorldScroll, 0)
        love.graphics.setFont(gFonts["flapflappy"])
        love.graphics.setColor(1,0,0)
        love.graphics.printf("OOPS!.. You Lost!", 0, 64, V_WIDTH, "center")

        love.graphics.setFont(gFonts["flapmedium"])
        love.graphics.setColor(1,0,0)
        love.graphics.printf("SCORE : " .. tostring(self.score), 0 , 100, V_WIDTH, "center")

        love.graphics.setColor(1,0,0)
        love.graphics.printf("PRESS ENTER To Play Again", 0, 124, V_WIDTH, "center")
        love.graphics.setColor(1, 1, 1)
    love.graphics.draw(FLAPPYGROUNDIMAGE, -FlappyGroundScroll, V_HEIGHT-16)
end