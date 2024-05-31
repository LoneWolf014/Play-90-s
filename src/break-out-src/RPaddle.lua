
RPaddle = Class{}

function RPaddle:init()
    self.x = V_WIDTH/2 - 32
    self.y = V_HEIGHT - 32

    self.dx = 0

    self.width = 64
    self.height = 16

    self.skin = 1 -- helps to change the color of our paddle by using another table

    self.size = 2 --helps to set the size of paddle and the paddle is too small to start with so we're going with next size

end

function RPaddle:update(dt)
    if love.keyboard.isDown("left") then
        self.dx = -PADDLE_SPEED
    elseif love.keyboard.isDown("right") then
        self.dx = PADDLE_SPEED
    else
        self.dx = 0
    end

    if self.dx < 0 then
        self.x = math.max(0, self.x + self.dx * dt)
    else
        self.x = math.min(V_WIDTH-self.width, self.x + self.dx * dt)
    end
end

function RPaddle:render()
    love.graphics.draw(gTextures["main2"], gFrames["Rpaddles"][self.size + 4 * (self.skin - 1)], 
    self.x, self.y)
end