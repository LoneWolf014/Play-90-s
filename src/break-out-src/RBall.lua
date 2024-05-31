RBall = Class{}

function RBall:init(skin)
    self.width = 8
    self.height = 8
    --these variables help us to keep track of 
    --the velocity of our ball since ball can move 2 dimensional
    self.dx = 0
    self.dy = 0
    -----
    self.skin = skin
end

function RBall:collides(target)

    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end
    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end

    return true
end

function RBall:reset()
    self.x = V_WIDTH/2-2
    self.y = V_HEIGHT/2-2

    self.dx = 0
    self.dy = 0
end

function RBall:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt

    --following code allows the ball to bounce
    if self.x <= 0 then
        self.x = 0
        self.dx = -self.dx
        gSounds["Wall_Hit"]:play()
    end

    if self.x >= V_WIDTH-8 then
        self.x = V_WIDTH-8
        self.dx = -self.dx
        gSounds["Wall_Hit"]:play()
    end

    if self.y <=0 then
        self.y = 0
        self.dy = -self.dy
        gSounds["Wall_Hit"]:play()
    end
end

function RBall:render()
    love.graphics.draw(gTextures["main2"], gFrames["Rballs"][self.skin],
        self.x, self.y)
end