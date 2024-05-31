flapPipePair = Class{}

local GAP_HEIGHT = 90 -- JUST SOME ARBITARY VALUE

function flapPipePair:init (y)
    self.x = V_WIDTH+32
    self.y = y
    -- the below one is actually where we are updating and rendering
    -- the pipe into pairs on to the screen
    self.pipes = {
                    ["upper"] = flappipe("top", self.y),
                    ["lower"] = flappipe("bottom", self.y + PIPE_HEIGHT + GAP_HEIGHT)
    }
    -- IN THIS TABLE THERE HAS TWO KEYS ONE FOR EACH ORIENTATION OF PIPE WHICH PARAMETERS.
    -- IT TOOK ONE STRING ARGUMENT TO DEFINE WHETHER THAT IS A TOP PIPE OR BOTTOM PIPE
    -- IF IT'S TOP THEN WE NEED TO RENDER IT UPSIDE DOWN LIKE WE NEED TO FLIP IT ALONG THE Y-AXIS
    -- AND THEN WE'RE GOING TO SET IT TO SELF.Y
    -- NOW COMING TO LOWER PIPE THE LOWER PIPE NEED TO SPAWN BELOW THE TOP PIPE BY THE GAP AMOUNT
    -- THE PIPE_HEIGHT IS ACTUALLY A RESULT OF FLIPPING THE Y-AXIS DOWN TO IT'S ACTUAL POSITION
    self.remove = false

    self.scored = false
end

function flapPipePair:update(dt)
    -- Now we got a pipe pair consists of 2 pipes with their each own render components and their own positions
    -- now we need the pair to go in the same order maintain it till it goes end of the frame and got destroyed
    if self.x > -PIPE_WIDTH then
        self.x = self.x - PIPE_SPEED *dt
        self.pipes["upper"].x = self.x
        self.pipes["lower"].x = self.x
    else
        self.remove = true
    end
end

function flapPipePair:render()
    for k, pipe in pairs(self.pipes) do 
        pipe:render()
    end
end