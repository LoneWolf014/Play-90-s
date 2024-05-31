PlayState1 = Class{__includes = BaseState}

PIPE_SPEED = 60
PIPE_WIDTH = 70
PIPE_HEIGHT = 288

BIRD_WIDTH = 32
BIRD_HEIGHT = 32

function PlayState1:init()
    self.bird = flapBird()
    self.PipePairs = {}
    self.timer = 0
    self.score = 0

    self.lastY = -PIPE_HEIGHT + math.random(80) + 20
end

function PlayState1:update(dt)
    WorldScroll = (WorldScroll + WORLDSCROLLSPEED * dt)
    % WORLD_LOOPING_POINT
    
    FlappyGroundScroll = (FlappyGroundScroll + FLAPPYGROUNDSCROLLSPEED * dt)
    % FLAPPYGROUND_LOOPING_POINT

    if love.keyboard.wasPressed("escape") then
        gStateMachine:change("fly-version")
        gSounds["flappy-bgm"]:stop()
    end

    self.timer = self.timer + dt

    if self.timer > 2 then
        local y = math.max(-PIPE_HEIGHT+20, 
                            math.min(self.lastY + math.random(-20, 20), V_HEIGHT-90-PIPE_HEIGHT))
        -- this method is known as CLAMPING. we added random value between -20 to 20 to our "lastY" value
        -- which made to shift the gap between the pipes between the range of negative 20 to 20
        -- We are going to clamp it between "-PIPE_HEIGHT+10" (10 pixels from the top of the screen) 
        -- "v_height-90-PIPE_HEIGHT" is the upperbound 
        -- this "-PIPE_HEIGHT" is only because we're doing a flip operation on our sprite across y-axis
        self.lastY = y
        -- HERE THE Y VALUS IS BASICALLY THE LAST LAST Y VALUE WHERE THE LAST GAP IS INSTANTIATED
        -- AND RANDOMIZED IT BETWEEN THE RANGE OF -20 TO 20
        table.insert(self.PipePairs, flapPipePair(y))
        self.timer = 0
    end

    for k, pair in pairs(self.PipePairs) do

        if not pair.scored then
            if pair.x + PIPE_WIDTH < self.bird.x then
                self.score = self.score + 1
                pair.scored = true
                gSounds["flappy-score"]:play()
            end
        end

        pair:update(dt)
    end

    for k, pair in pairs(self.PipePairs) do
        if pair.remove then
            table.remove(self.PipePairs, k)
        end
    end

    self.bird:update(dt)

    for k, pair in pairs(self.PipePairs) do
        pair:update(dt)
        for l, pipe in pairs(pair.pipes) do
            if self.bird:collides(pipe) then
                gSounds["flappy-hurt"]:play()
                gSounds["flappy-explosion"]:play()
                gStateMachine:change("flappy-score", {
                    score = self.score
                })
            end
        end
    end

    if self.bird.y > V_HEIGHT-20 then
        gSounds["flappy-hurt"]:play()
        gSounds["flappy-explosion"]:play()
        gStateMachine:change("flappy-score", {
            score = self.score
        })
    end
end

function PlayState1:render()
    love.graphics.draw(WORLDIMAGE, -WorldScroll, 0)
        for k,pair in pairs(self.PipePairs) do
            pair:render()
        end

        love.graphics.setFont(gFonts["flapmedium"])
        love.graphics.print("Score : " .. tostring(self.score), 8, 8)

        self.bird:render()
        flappyFPS()
    love.graphics.draw(FLAPPYGROUNDIMAGE, -FlappyGroundScroll, V_HEIGHT-16)
end

function flappyFPS()
    love.graphics.setFont(gFonts["flapsmall"])
    love.graphics.setColor(1, 49/255, 49/255)
    love.graphics.printf("FPS : ".. tostring(love.timer.getFPS()), 10, 10, V_WIDTH-20, "right")
    love.graphics.setColor(1, 1, 1)
end