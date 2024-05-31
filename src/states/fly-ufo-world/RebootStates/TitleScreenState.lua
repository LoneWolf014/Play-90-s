TitleScreenState = Class{__includes = BaseState}
 BACKGROUNDIMAGE = love.graphics.newImage("graphics/fly-ufo/Night_city.jpg")
 BackgroundScroll = 0

 GROUNDIMAGE = love.graphics.newImage("graphics/fly-ufo/ground.png")
--local GROUNDIMAGE = love.graphics.newImage("ground2.png")
 GroundScroll = 0

 BACKGROUNDSCROLLSPEED = 30
 BACKGROUND_LOOPING_POINT = 1155
 GROUND_LOOPING_POINT = 512

 GROUNDSCROLLSPEED = 60

function TitleScreenState:init()
    love.window.setTitle("Fly Ufo")
end

function TitleScreenState:update(dt)
    
    BackgroundScroll = (BackgroundScroll + BACKGROUNDSCROLLSPEED * dt)
    % BACKGROUND_LOOPING_POINT
    
    GroundScroll = (GroundScroll + GROUNDSCROLLSPEED * dt)
    % GROUND_LOOPING_POINT
    --
    gSounds["music-1"]:setLooping(true)
    gSounds["music-2"]:setLooping(true)
    gSounds["music-1"]:play()
    gSounds["music-2"]:play()
    --

    if love.keyboard.wasPressed("enter") or love.keyboard.wasPressed("return") then
        gStateMachine:change("fly-count")
    end
    if love.keyboard.wasPressed("escape") then
        gStateMachine:change("start")
        gSounds["music-1"]:stop()
        gSounds["music-2"]:stop()
    end
end

function TitleScreenState:render()
    love.graphics.draw(BACKGROUNDIMAGE, -BackgroundScroll, 0)

    love.graphics.draw(GROUNDIMAGE, -GroundScroll, V_HEIGHT-32)

    love.graphics.setFont(gFonts["smallFont"])
    love.graphics.setColor(1, 49/255, 49/255)
    love.graphics.printf("FPS : ".. tostring(love.timer.getFPS()), 10, 10, V_WIDTH-20, "right")
    
    love.graphics.setFont(gFonts["flappyFont"])
    love.graphics.printf("FLY UFO", 0, 64, V_WIDTH, "center")

    love.graphics.setFont(gFonts["smallFont"])
    love.graphics.printf("Press Enter", 0, 100, V_WIDTH, "center")
end