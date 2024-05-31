FlappyCountdownState = Class{__includes = BaseState}

cntd = love.graphics.newFont("fonts/classyflappy/font.ttf", 50)

COUNTDOWN_TIME = 0.75
function FlappyCountdownState:init()
    self.count = 3
    self.timer = 0
end

function FlappyCountdownState:update(dt)
    WorldScroll = (WorldScroll + WORLDSCROLLSPEED * dt)
    % WORLD_LOOPING_POINT
    
    FlappyGroundScroll = (FlappyGroundScroll + FLAPPYGROUNDSCROLLSPEED * dt)
    % FLAPPYGROUND_LOOPING_POINT
    gSounds["flappy-bgm"]:stop()
    self.timer = self.timer + dt
    if self.timer > COUNTDOWN_TIME then
        gSounds["countdown"]:play()
        self.timer = self.timer % COUNTDOWN_TIME
        self.count = self.count - 1
        if self.count == 0 then
            gSounds["flappy-bgm"]:play()
            gStateMachine:change("flappy-play")
        end
    end
end

function FlappyCountdownState:render()
    love.graphics.draw(WORLDIMAGE, -WorldScroll, 0)
        love.graphics.setColor(1, 0, 0)
        love.graphics.setFont(cntd)
        love.graphics.printf(tostring(self.count), 0, 120, V_WIDTH, "center")
        love.graphics.setColor(1, 1, 1)
    love.graphics.draw(FLAPPYGROUNDIMAGE, -FlappyGroundScroll, V_HEIGHT-16)
end