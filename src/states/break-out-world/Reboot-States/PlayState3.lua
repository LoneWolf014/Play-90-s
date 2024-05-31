
PlayState3 = Class{__includes = BaseState}

function PlayState3:init()
    self.paddle = RPaddle()
    self.ball = RBall(math.random(7))

    self.ball.dx = math.random(-200, 200)
    self.ball.dy = math.random(-50, -60)

    self.ball.x = V_WIDTH/2-4
    self.ball.y = V_HEIGHT - 42

    self.paused = false

    self.bricks = RLevelMaker.createMap()
end

function PlayState3:update(dt)
    if self.paused then
        if love.keyboard.wasPressed("space") then
            self.paused = false
        else
            return
        end
    elseif love.keyboard.wasPressed("space") then
        self.paused = true
        return
    end

    self.paddle:update(dt)
    self.ball:update(dt)

    if self.ball:collides(self.paddle) then
        self.ball.dy = -self.ball.dy
        gSounds["Paddle_Hit"]:play()
    end
    
    for k, brick in pairs(self.bricks) do
        if brick.inPlay and self.ball:collides(brick) then
            brick:hit()
        end
    end

    if love.keyboard.wasPressed("escape") then
        love.event.quit()
    end
end

function PlayState3:render()

    for k, brick in pairs(self.bricks) do
        brick:render()
    end

    self.paddle:render()
    self.ball:render()

    if self.paused then
        love.graphics.setFont(gFonts["large"])
        love.graphics.printf("PAUSED", 0, V_HEIGHT/2 - 16, V_WIDTH, "center")
    end
end