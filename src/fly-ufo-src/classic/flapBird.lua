flapBird = Class{}

local GRAVITY = 20

function flapBird : init()
    self.image = gTextures["flap-bird"]
    
    self.width = self.image : getWidth()
    self.height = self.image : getHeight()

    self.x = V_WIDTH/2 - self.width/2
    self.y = V_HEIGHT/2 - self.height/2

    self.dy = 0
end

function flapBird : update(dt)
    self.dy = self.dy + GRAVITY*dt
    
    if love.keyboard.wasPressed("space") then
        self.dy = -3.5
        gSounds["flappy-jump"]:play()
        gSounds["flappy-jump"]:setVolume(0.25)
    end

    self.y = self.y + self.dy

    if self.y < 0 then
        self.y = 0
    end
end

function flapBird : collides(pipe)
    if (self.x + 2) + (self.width - 10) >= pipe.x and self.x + 2 <= pipe.x + PIPE_WIDTH then
        if (self.y + 10) + (self.height - 10) >= pipe.y and self.y + 2 <= pipe.y + PIPE_HEIGHT then
            return true
        end
    end
end

function flapBird : render()
    love.graphics.draw(self.image, self.x, self.y)
end