game_won = {}

function game_won.init() 
  started_explosion = false
  exploding = false
  finished = false
  
  player.direction = 0
  
  moon = Moon()
end

function game_won.update(dt)
  timeToImpact = timeToImpact - dt
  if timeToImpact < 0 then
    timeToImpact = 0
  end
  
  if not exploding and not finished then
    for i,p in ipairs(planets) do
      p:update(dt)
      if p.destroyable then table.remove(planets, i) end
    end
  
    flames.time = flames.time + dt
    if flames.time > flames.time_per_frame then
      if not flames:advance_frame() then flames.frame = 1 end
      flames.time = 0
    end
  end
  
  for i,a in ipairs(asteroids) do
    a:update(dt)
    if a.destroyable then table.remove(asteroids, i) end
  end  
  
  if exploding then
    if not started_explosion then
      explosion_sound:play()
      started_explosion = true
    end
    
    explosion.time = explosion.time + dt
    if explosion.time > explosion.time_per_frame then
      exploding = explosion:advance_frame()
      explosion.time = 0
      
      if exploding == false then finished = true end
    end
  else  
    moon:update(dt)
    player:update(dt)
  end
  
  if not exploding and not finished and collision(player, moon) then
    exploding = true
    explosion.time = 0
  end
end

function game_won.draw()  
  for i,p in ipairs(planets) do
    p:draw()
  end  
  
  if explosion.frame < 3 then    
    flames:play(player.x, player.y + player.height / 2 - 10)
    player:draw()
  end
    
  for i,a in ipairs(asteroids) do
    a:draw()
  end
  
  moon:draw()
  
  if exploding then 
    explosion:play(player.x, player.y) 
  end
  
  if finished then
    love.graphics.setNewFont(20)
    local font = love.graphics.newFont(20)
    local text = "Congrats!"
    love.graphics.print(text, math.floor((SCREEN_WIDTH-font:getWidth(text))/2), math.floor((SCREEN_HEIGHT-font:getHeight())/2) - 10)
    
    love.graphics.setNewFont(16)
    local subfont = love.graphics.newFont(16)
    local subtext = "hit space to play again!"
    love.graphics.print(subtext, math.floor((SCREEN_WIDTH-subfont:getWidth(subtext))/2), math.floor((SCREEN_HEIGHT-subfont:getHeight())/2) + 10)
  end
  
  if not finished then 
    love.graphics.setNewFont(20)
    local font = love.graphics.newFont(20)
    local text = string.format("T-%02d", timeToImpact) .. "." .. math.floor(timeToImpact*10) % 10
    
    love.graphics.setColor(0.5, 0.5, 0)
    love.graphics.rectangle("fill", math.floor(SCREEN_WIDTH-font:getWidth(text)-15), math.floor(font:getHeight()-15), font:getWidth(text), font:getHeight(text))
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(text, math.floor(SCREEN_WIDTH-font:getWidth(text)-15), math.floor(font:getHeight()-15))
  end
end

function game_won.keypressed(key)
  if key == "space" and finished then
    startMenu()
  elseif key == "escape" then
    love.event.quit(0)
  end
end
