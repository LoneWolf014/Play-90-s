
RBrick = Class{}

function RBrick:init(x, y)
    self.tier = 0
    self.color = 1
    
    self.x = x
    self.y = y
    self.width = 32
    self.height = 16

    --Used to determine whether the brick should be rendered or not
    self.inPlay = true
end
    --it triggers a hit on the brick and taking it out of the play based on it's health
    -- not a best practice in making of large games
function RBrick:hit()
    gSounds["brick-hit-2"]:play()
    self.inPlay = false
end

function RBrick:render()
    if self.inPlay then
        love.graphics.draw(gTextures["main2"], gFrames["Rbricks"][1+((self.color-1)*3)+self.tier],
            self.x, self.y)
    end
end