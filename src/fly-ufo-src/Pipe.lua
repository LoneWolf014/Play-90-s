pipe = Class{}
local PIPE = love.graphics.newImage("graphics/fly-ufo/pipe.png")

PIPE_SPEED = 60

PIPE_WIDTH = 70
PIPE_HEIGHT = 288


function pipe : init(orientation, y)    -- check the pipes table in PipePairs.lua
    self.x = v_width
    self.y = y
    
    self.width = PIPE:getWidth()
    self.height = PIPE_HEIGHT

    self.orientation = orientation      
    -- this basically ask our code whether it is a top pipe or bottom pipe
    -- if our pipe is top pipe then we need to flip it along it's y-axis draw it and shift it
 end

function pipe:update(dt)

end

function pipe:render()
    love.graphics.draw(PIPE, self.x,
        (self.orientation == "top" and self.y + PIPE_HEIGHT or self.y),
            0,                                      -- rotation
            1,                                      -- scale on the x-axis
            self.orientation == "top" and -1 or 1)  -- scale on the y-axis
    -- when we set a sprite it's scale factor to negative 1, it flips it along it's that axis effectively
end