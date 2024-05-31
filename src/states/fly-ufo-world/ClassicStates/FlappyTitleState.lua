FlappyTitleState = Class{__includes = BaseState}
 WORLDIMAGE = love.graphics.newImage("graphics/fluffy-bird/classicbackground.png")
 WorldScroll = 0

 FLAPPYGROUNDIMAGE = love.graphics.newImage("graphics/fluffy-bird/flappyground.png")
--local GROUNDIMAGE = love.graphics.newImage("ground2.png")
 FlappyGroundScroll = 0

 WORLDSCROLLSPEED = 30
 WORLD_LOOPING_POINT = 413
 FLAPPYGROUND_LOOPING_POINT = 512

 FLAPPYGROUNDSCROLLSPEED = 60

function FlappyTitleState:init()
    love.window.setTitle("Fluffy Ufo")
end

function FlappyTitleState:update(dt)
    
    WorldScroll = (WorldScroll + WORLDSCROLLSPEED * dt)
    % WORLD_LOOPING_POINT
    
    FlappyGroundScroll = (FlappyGroundScroll + FLAPPYGROUNDSCROLLSPEED * dt)
    % FLAPPYGROUND_LOOPING_POINT
    --
    gSounds["flappy-bgm"]:setLooping(true)
    gSounds["flappy-bgm"]:play()
    --

    if love.keyboard.wasPressed("enter") or love.keyboard.wasPressed("return") then
        gStateMachine:change("flappy-count")
    end
    if love.keyboard.wasPressed("escape") then
        gStateMachine:change("start")
        gSounds["flappy-bgm"]:stop()
    end
end

function FlappyTitleState:render()
    love.graphics.draw(WORLDIMAGE, -WorldScroll, 0)

    love.graphics.draw(FLAPPYGROUNDIMAGE, -FlappyGroundScroll, V_HEIGHT-16)

    love.graphics.setFont(gFonts["smallFont"])
    love.graphics.setColor(1, 49/255, 49/255)
    love.graphics.printf("FPS : ".. tostring(love.timer.getFPS()), 10, 10, V_WIDTH-20, "right")
    
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(gFonts["flappyFont"])
    love.graphics.printf("FLUFFY BIRD", 0, 64, V_WIDTH, "center")

    love.graphics.setFont(gFonts["smallFont"])
    love.graphics.printf("Press Enter", 0, 100, V_WIDTH, "center")
end