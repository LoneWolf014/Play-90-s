
ClassicTwoPlayerState = Class{__includes = BaseState}

paddle_Speed = 200

function ClassicTwoPlayerState:init()
	math.randomseed(os.time())

	love.graphics.setDefaultFilter("nearest", "nearest")

	text = "Welcome to Pong!"

	player1 = Paddle(10, 50, 5, 20)							-- player 1 position
	player2 = Paddle(V_WIDTH-15, V_HEIGHT-50, 5, 20)		-- player 2 position

	servingPlayer = 1

	player1Score = 0
	player2Score = 0

	ball = Ball(V_WIDTH/2-2, V_HEIGHT/2-2, 4, 4)

	gameState = "start"
	love.window.setTitle("Ping Pong ~ Classic")
end

function love.resize(w, h)
	push:resize(w, h)
end

function ClassicTwoPlayerState:update(dt)

	if gameState == "serve" then
		ball.dy = math.random(-50, 50)
		if servingPlayer == 1 then
			ball.dx = math.random(140,200)
		else
			ball.dx = -math.random(140,200)
		end

	elseif gameState == "play" then

		-- Detect the ball collision with paddles and reverse the dx if the collision is true and
		-- slightly increasing it and then altering the dy based on the position of collision

		if ball:collides (player1) then
			ball.dx = -ball.dx * 1.03 -- x3 times of the speed
			ball.x = player1.x + 5

			-- keep velocity going in the same direction, but randomize it
			if ball.dy <= 0 then
				ball.dy = -math.random(10, 150)
			else
				ball.dy = math.random(10, 150)
			end

			gSounds["Paddle_Hit"]:play()
		end
	
		if ball : collides (player2) then
			ball.dx = -ball.dx * 1.03
			ball.x = player2.x - 4

			if ball.dy <= 0 then
				ball.dy = -math.random(10, 150)
			else
				ball.dy = math.random(10, 150)
			end

			gSounds["Paddle_Hit"]:play()
		end

		-- detect upper and lower screen boundary collision and reverse the dy if the collision is true
		if ball.y <=0 then
			ball.y = 0
			ball.dy = -ball.dy
			
			gSounds["Wall_Hit"]:play()
		end
		if ball.y >= V_HEIGHT - 4 then
			ball.y = V_HEIGHT - 4
			ball.dy = -ball.dy
			
			gSounds["Wall_Hit"]:play()
		end
	end

	if ball.x < 0 then
		
		servingPlayer = 1
		player2Score = player2Score + 1
		
		gSounds["Score"]:play()

		if player2Score == 7 then
		
			WinningPlayer = 2
			gameState = "done"
			gSounds["girls-cheers"]:play()
		else
			gameState = "serve"
		end
		ball:reset()
	end

	if ball.x >V_WIDTH then

		servingPlayer = 2
		player1Score = player1Score + 1
		
		gSounds["Score"]:play()

		if player1Score == 7 then
			WinningPlayer = 1
			gameState = "done"
			gSounds["girls-cheers"]:play()
		else
			gameState = "serve"
		end
		ball:reset()
	end

	if love.keyboard.isDown("w") then
		player1.dy = -paddle_Speed
	elseif love.keyboard.isDown("s") then
		player1.dy = paddle_Speed
	else
		player1.dy = 0
	end

	if love.keyboard.isDown("up") then
		player2.dy = -paddle_Speed
	elseif love.keyboard.isDown("down") then
		player2.dy = paddle_Speed
	else
		player2.dy = 0
	end

	if gameState == "play" then
		ball:update(dt)
	end
	if love.keyboard.wasPressed("escape") then
		gStateMachine:change("pong-version")
	elseif love.keyboard.wasPressed("enter") or love.keyboard.wasPressed("return") then
		if gameState == "start" then
			gameState = "serve"
		elseif gameState == "serve" then
			gameState = "play"
		elseif gameState == "done" then
			gameState = "serve"

			ball:reset()
			player1Score = 0
			player2Score = 0

			if WinningPlayer == 1 then
				servingPlayer = 2
			else
				servingPlayer = 1
			end
		end
	end
	player1:update(dt)
	player2:update(dt)
end

--[[function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	elseif key == "enter" or key == "return" then
		if gameState == "start" then
			gameState = "serve"
		elseif gameState == "serve" then
			gameState = "play"
		elseif gameState == "done" then
			gameState = "serve"

			ball:reset()
			player1Score = 0
			player2Score = 0

			if WinningPlayer == 1 then
				servingPlayer = 2
			else
				servingPlayer = 1
			end
		end
	end
end]]

function ClassicTwoPlayerState:render()
	push:apply("start")

	love.graphics.clear(40/255, 45/255, 52/255, 0) -- sets background color, 0 mades the background black since its about opacity to check what it truly shows use 255/255
									-- 1 in place of 0 gives white background
	love.graphics.setFont(gFonts["Font"])
	love.graphics.setColor(1,1,1)	    		-- sets font color
	love.graphics.printf(text, 0, 10, V_WIDTH, "center")

	DisplayDash()

	showScore()

	love.graphics.setColor(1, 1, 1)	   
	player1:render()				-- left paddle  (mode, h_position, v_position, width, height)

	love.graphics.setColor(1, 1, 1)	 
	ball:render()				-- ball Position

	love.graphics.setColor(1, 1, 1)	 
	player2:render()	-- right paddle

	viewFPS()

	push:apply("end")
end

function viewFPS()
	love.graphics.setFont(gFonts["Font"])
	love.graphics.setColor(1,1,1)
	love.graphics.print("FPS : ".. tostring(love.timer.getFPS()), 10, 10)
end

function DisplayDash()
	DashFont = love.graphics.newFont("fonts/pongFonts/font_0.ttf", 12)
	love.graphics.setFont(DashFont)
	if gameState == "start" then
		love.graphics.printf("\nREADY!", 0, 20, V_WIDTH, "center")
	elseif gameState == "serve" then
		love.graphics.printf("\nPlayer " .. tostring(servingPlayer) .. "'s Serve", 0, 20, V_WIDTH, "center")
		love.graphics.printf("\nPress ENTER to Serve", 0, 30, V_WIDTH, "center")
	elseif gameState == "play" then
		love.graphics.printf("\nPLAY!", 0, 20, V_WIDTH, "center")
	elseif gameState == "done" then
		love.graphics.printf("\nPlayer " .. tostring(WinningPlayer) .. " Wins!", 0, 20, V_WIDTH, "center")
		love.graphics.printf("\nPress ENTER to Restart", 0, 30, V_WIDTH, "center")
	end
end

function showScore()
	love.graphics.setColor(1,1,1)
	love.graphics.setFont(gFonts["scoreFont"])
	love.graphics.print(tostring(player1Score), V_WIDTH/2-V_WIDTH/4, V_HEIGHT/3)
	love.graphics.print(tostring(player2Score), V_WIDTH/2+V_WIDTH/4, V_HEIGHT/3)
end