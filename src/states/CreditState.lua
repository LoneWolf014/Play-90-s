CreditState = Class{__includes = BaseState}
function CreditState:init()
    love.graphics.setDefaultFilter("nearest", "nearest")
    self.img = gTextures["credit"]
    self.x = V_WIDTH/2-227
end

function CreditState:update(dt)

    if love.keyboard.wasPressed("escape") then
        gStateMachine:change("start")
    end
end

function CreditState:render()
    push:apply("start")
    love.graphics.draw(gTextures["credicard"], 0, 0, 0, 1, 0.8)
    love.graphics.draw(self.img,self.x,0)--,r,sx,sy,ox,oy)
    push:apply("end")
end