OptionState = Class{__includes = BaseState}

function OptionState:init()
    filler = love.graphics.newFont("fonts/creditFont/LFAXDI.TTF", 11)
    text = "'UP and DOWN' TO NAVIGATE BETWEEN OPTIONS \n 'ESCAPE' TO GO BACK \n 'ENTER' TO ENTER OR START THE GAME\n\n"..
            "PONG:\n 'Enter' to start the game\n One Player Mode:\n 'UP' and 'Down' arrows use to move the paddle\n"..
            "Two Player Mode:\n'UP', 'DOWN', 'W', 'S' keys used to move left and right paddles\n\nFLY-UFO:\n"..
            "'Enter' to enter the game, 'Spacebar' to jump the ufo/bird"
end

function OptionState:update(dt)
    if love.keyboard.wasPressed("escape") then
        gStateMachine:change("start")
    end
end

function OptionState:render()

    love.graphics.setFont(filler)
    love.graphics.setColor(2/255, 215/255, 242/255, 1)

    love.graphics.printf(text,0,50,V_WIDTH,"center")
    love.graphics.setColor(1,1,1,1)
end