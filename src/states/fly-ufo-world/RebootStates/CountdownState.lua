CountdownState = Class{__includes = BaseState}

cntd = love.graphics.newFont("fonts/font.ttf", 50)

COUNTDOWN_TIME = 0.75
function CountdownState:init()
    self.count = 3
    self.timer = 0
end

function CountdownState:update(dt)
    BackgroundScroll = (BackgroundScroll + BACKGROUNDSCROLLSPEED * dt)
    % BACKGROUND_LOOPING_POINT
    
    GroundScroll = (GroundScroll + GROUNDSCROLLSPEED * dt)
    % GROUND_LOOPING_POINT
    gSounds["music-1"]:stop()
    gSounds["music-2"]:stop()
    self.timer = self.timer + dt
    if self.timer > COUNTDOWN_TIME then
        gSounds["countdown"]:play()
        self.timer = self.timer % COUNTDOWN_TIME
        self.count = self.count - 1
        if self.count == 0 then
            gSounds["music-1"]:play()
            gSounds["music-2"]:play()
            gStateMachine:change("fly-play")
        end
    end
end

function CountdownState:render()
    love.graphics.draw(BACKGROUNDIMAGE, -BackgroundScroll, 0)
        love.graphics.setColor(1, 0, 0)
        love.graphics.setFont(cntd)
        love.graphics.printf(tostring(self.count), 0, 120, V_WIDTH, "center")
        love.graphics.setColor(1, 1, 1)
    love.graphics.draw(GROUNDIMAGE, -GroundScroll, V_HEIGHT-32)
end