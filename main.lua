require "src/Dependencies"

function love.load()

    love.graphics.setDefaultFilter("nearest", "nearest")
    
    love.window.setTitle("PLAY 90'S")
    
    gFonts = {
        ["small"] = love.graphics.newFont("fonts/font.ttf", 8),
        ["medium"] = love.graphics.newFont("fonts/font.ttf", 16),
        ["large"] = love.graphics.newFont("fonts/font2.ttf", 32),
        ------------------------------------------------------------------------------------------
        ["smallFont"] = love.graphics.newFont("fonts/font3.ttf", 8),
        ["mediumFont"] = love.graphics.newFont("fonts/flappy.ttf", 14),
        ["flappyFont"] = love.graphics.newFont("fonts/flappy.ttf", 28),
        ["hugeFont"] = love.graphics.newFont("fonts/flappy.ttf", 56),
        --classic fly-ufo--------------------------------------------------------------------------
        ['flapsmall'] = love.graphics.newFont('fonts/classyflappy/font.ttf', 8),
        ['flapmedium'] = love.graphics.newFont('fonts/classyflappy/flappy.ttf', 14),
        ['flapflappy'] = love.graphics.newFont('fonts/classyflappy/flappy.ttf', 28),
        ['flaphuge'] = love.graphics.newFont('fonts/classyflappy/flappy.ttf', 56),
        -------------------------------------------------------------------------------------------
        --pong fonts-------------------------------------------------------------------------------
        ["Font"] = love.graphics.newFont("fonts/pongFonts/font_0.ttf", 12),
        ["scoreFont"] = love.graphics.newFont("fonts/pongFonts/font_1.ttf", 32),
        -------------------------------------------------------------------------------------------
        ["credi"] = love.graphics.newFont("fonts/creditFont/LFAXDI.TTF", 32)
    }

    gSounds = {
        ["select"] = love.audio.newSource("sounds/select.wav", "static"),
        --PONG WORLD ------------------------------------------------------------------------------
        ["Paddle_Hit"] = love.audio.newSource("sounds/pong/Paddle_Hit.wav", "static"),
		["Wall_Hit"] = love.audio.newSource("sounds/pong/Wall_Hit.wav", "static"),
        ["Score"] = love.audio.newSource("sounds/pong/Score.wav", "static"),
        ["girls-cheers"] = love.audio.newSource("sounds/pong/girls-applause.wav", "static"),
        -------------------------------------------------------------------------------------------

        --fly-ufo World ---------------------------------------------------------------------------
        --classic----------------------------------------------------------------------------------
        ["flappy-bgm"] = love.audio.newSource("sounds/fly-ufo/ClassicTrack/marios_way.mp3", "stream"),
        ["flappy-jump"] = love.audio.newSource("sounds/fly-ufo/ClassicTrack/flappy.wav", "static"),
        ["flappy-explosion"] = love.audio.newSource("sounds/fly-ufo/ClassicTrack/flappyblast.wav", "static"),
        ["flappy-hurt"] = love.audio.newSource("sounds/fly-ufo/ClassicTrack/flappyhurt.wav", "static"),
        ["flappy-score"] = love.audio.newSource("sounds/fly-ufo/ClassicTrack/flappyscore.wav", "static"),
        -------------------------------------------------------------------------------------------
        --reboot-----------------------------------------------------------------------------------
        ["music-1"] = love.audio.newSource("sounds/fly-ufo/RebootTrack/let-the-game-begin.mp3", "stream"),
        ["music-2"] = love.audio.newSource("sounds/fly-ufo/RebootTrack/bang-baby.mp3", "stream"),
        ["countdown"] = love.audio.newSource("sounds/fly-ufo/RebootTrack/countdown.wav", "static"),
        ["hurt"] = love.audio.newSource("sounds/fly-ufo/RebootTrack/Hit_Hurt.wav", "static"),
        ["explosion"] = love.audio.newSource("sounds/fly-ufo/RebootTrack/Explosion.wav", "static"),
        ["jump"] = love.audio.newSource("sounds/fly-ufo/RebootTrack/jump.wav", "static"),
        ["score"] = love.audio.newSource("sounds/fly-ufo/RebootTrack/score.wav", "static"),
        -------------------------------------------------------------------------------------------

        ["brick-hit-2"] = love.audio.newSource("sounds/break-out/brick-hit-2.wav", "static")
    }

    love.graphics.setFont(gFonts["small"])

    gTextures = {
        ["background"] = love.graphics.newImage("graphics/background.jpg"),
        ["index"] = love.graphics.newImage("graphics/indic.png"),
        --fly-ufo world----------------------------------------------------------------------------
        --classic----------------------------------------------------------------------------------
        ["flap-world"] = love.graphics.newImage("graphics/fluffy-bird/classicbackground.png"),
        ["flap-ground"] = love.graphics.newImage("graphics/fluffy-bird/flappyground.png"),
        ["flap-bird"] = love.graphics.newImage("graphics/fluffy-bird/bird.png"),
        ["flap-pipe"] = love.graphics.newImage("graphics/fluffy-bird/flappypipe.png"),
        -------------------------------------------------------------------------------------------
        --reboot-----------------------------------------------------------------------------------
        ["hop-world"] = love.graphics.newImage("graphics/fly-ufo/Night_city.jpg"),
        ["pipes"] = love.graphics.newImage("graphics/fly-ufo/pipe.png"),
        ["bird"] = love.graphics.newImage("graphics/fly-ufo/Sprite_0.png"),
        ["hop-ground-1"] = love.graphics.newImage("graphics/fly-ufo/ground.png"),
        ["hop-ground-2"] = love.graphics.newImage("graphics/fly-ufo/ground2.png"),
        -------------------------------------------------------------------------------------------
        -------------------------------------------------------------------------------------------
        ["credit"] = love.graphics.newImage("graphics/extras/credit.png"),
        ["credicard"] = love.graphics.newImage("graphics/extras/credicard.png"),

        --break-out--------------------------------------------------------------------------------
        ["main2"] = love.graphics.newImage("graphics/SpriteSheet-1.png")
    }

    gFrames = {
        ["Rpaddles"] = GenerateQuadsPaddles(gTextures["main2"]),
        ["Rballs"] = GenerateQuadsBalls(gTextures["main2"]),
        ["Rbricks"] = GenerateQuadsBricks(gTextures["main2"])
    }


    push:setupScreen(V_WIDTH, V_HEIGHT, W_WIDTH, W_HEIGHT, {
                        vsync = true,
                        fullscreen = false,
                        resizable = true
                    })

    gStateMachine = StateMachine{
        ["intro"] = function() return IntroState() end,
        ["start"] = function() return StartState() end,
        ["options"] = function() return OptionState() end,
        ["credits"] = function() return CreditState() end,
        
        --PONG-game-states-------------------------------------------------------------------------
        ["pong-version"] = function() return PongVersionState() end,

        ["pong-upgrade-player-mode"] = function() return PlaytypeState() end,
        ["pong-player-mode"] = function() return ClassicPlaytypeState() end,
        
        ["pong-classic-two-player-start"] = function() return ClassicTwoPlayerState() end,
        ["pong-classic-one-player-start"] = function() return ClassicOnePlayerState() end,
        
        ["pong-two-player-start"] = function() return TwoPlayerState() end,
        ["pong-one-player-start"] = function() return OnePlayerState() end,
        -------------------------------------------------------------------------------------------
        -------------------------------------------------------------------------------------------

        --fly-ufo-game-states----------------------------------------------------------------------
        --Classic----------------------------------------------------------------------------------
        ["flappy-start"] = function() return FlappyTitleState() end,
        ["flappy-count"] = function() return FlappyCountdownState() end,
        ["flappy-play"] = function() return PlayState1() end,
        ["flappy-score"] = function() return FlappyScoreState() end,
        -------------------------------------------------------------------------------------------
        --Reboot-----------------------------------------------------------------------------------
        ["fly-start"] = function() return TitleScreenState() end,
        ["fly-version"] = function() return FlyVersionState() end,
        ["fly-count"] = function() return CountdownState() end,
        ["fly-play"] = function() return PlayState2() end,
        ["fly-score"] = function() return ScoreState() end,
        -------------------------------------------------------------------------------------------
        -------------------------------------------------------------------------------------------

        --Break-Out-game-states--------------------------------------------------------------------
        ["break-version"] = function() return BreakVersionState() end,
        ["break-start"] = function() return BreakTitleState() end,
        ["break-play"] = function() return PlayState3() end
        -------------------------------------------------------------------------------------------
    }
    gStateMachine:change("intro")

    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)
    gStateMachine:update(dt)

    love.keyboard.keysPressed = {}
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

function love.draw()
    push:apply("start")

    local backgroundWidth = gTextures["background"]:getWidth()
    local backgroundHeight = gTextures["background"]:getHeight()

    love.graphics.draw(gTextures["background"], 0, 0, 0, V_WIDTH/(backgroundWidth-1), V_HEIGHT/(backgroundHeight-1))

    displayFPS()

    gStateMachine:render()

    push:apply("end")
end

function displayFPS()
    love.graphics.setFont(gFonts["small"])
    love.graphics.setColor(255, 0, 0, 255)
    love.graphics.print("FPS:" .. tostring(love.timer.getFPS()), 5, 5)
    love.graphics.setColor(1, 1, 1, 1)
end