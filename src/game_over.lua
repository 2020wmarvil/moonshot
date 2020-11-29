game_over = {}

function game_over.init() 
  explosion.time = 0
  exploding = true
  
  explosion_sound:play()
end

function game_over.update(dt)  
  if exploding then
    explosion.time = explosion.time + dt
    if explosion.time > explosion.time_per_frame then
      exploding = explosion:advance_frame()
      explosion.time = 0
    end
  end
end

function game_over.draw()
  for i,s in ipairs(stars) do
    s:draw()
  end
  
  for i,p in ipairs(planets) do
    p:draw()
  end
  
  if explosion.frame < 3 then
    player:draw()
    asteroids[collided_asteroid_index]:draw()
  end
    
  for i,a in ipairs(asteroids) do
    if i ~= collided_asteroid_index then a:draw() end
  end
  
  if exploding then 
    explosion:play(player.x, player.y)
  else  
    love.graphics.setNewFont(20)
    local font = love.graphics.newFont(20)
    local text = "GAME OVER"
    love.graphics.print(text, math.floor((SCREEN_WIDTH-font:getWidth(text))/2), math.floor((SCREEN_HEIGHT-font:getHeight())/2) - 10)
    
    love.graphics.setNewFont(16)
    local subfont = love.graphics.newFont(16)
    local subtext = "hit space to reset!"
    love.graphics.print(subtext, math.floor((SCREEN_WIDTH-subfont:getWidth(subtext))/2), math.floor((SCREEN_HEIGHT-subfont:getHeight())/2) + 10)
  end
end

function game_over.keypressed(key)
  if key == "space" and not exploding then
    startMenu()
  elseif key == "escape" then
    love.event.quit(0)
  end
end
