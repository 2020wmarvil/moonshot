game = {}

function game.init()  
  player_move_down = true
  collideable = false
  show_instructions = true
  
  explosion = Animation()
  explosion.frame = 1
  explosion.time = 0
  
  invulnerability_duration = 3.5
  invulnerability_time = 0
  
  timeToImpact = 10
  winTime = 1
end

function game.update(dt)
  timeToImpact = timeToImpact - dt
  if timeToImpact < winTime then
    startGameWon()
  end
  
  invulnerability_time = invulnerability_time + dt
  if invulnerability_time > invulnerability_duration then
    collideable = true
  end
  
  player:update(dt)
  earth:update(dt)
  
  for i,p in ipairs(planets) do
    p:update(dt)
    if p.destroyable then table.remove(planets, i) end
  end
  
  for i,a in ipairs(asteroids) do
    a:update(dt)
    if a.destroyable then table.remove(asteroids, i) end
    
    if collideable then 
      if (collision(player, a)) then
        collided_asteroid_index = i
        startGameOver()
      end
    end
  end
  
  asteroidSpawnTimer = asteroidSpawnTimer + dt
  if asteroidSpawnTimer > asteroidSpawnInterval and timeToImpact > (SCREEN_HEIGHT / asteroid_speed) + winTime then
    table.insert(asteroids, spawnAsteroid())
    asteroidSpawnTimer = 0
  end
  
  planetSpawnTimer = planetSpawnTimer + dt
  if planetSpawnTimer > planetSpawnInterval then
    table.insert(planets, spawnPlanet())
    planetSpawnTimer = 0
  end  
end

function game.draw()
  earth:draw()
  
  for i,p in ipairs(planets) do
    p:draw()
  end  
  
  player:draw()
  
  for i,a in ipairs(asteroids) do
    a:draw()
  end
  
  if show_instructions then
    love.graphics.setNewFont(20)
    local font = love.graphics.newFont(20)
    local text = "hit space to dodge!"
    love.graphics.print(text, math.floor((SCREEN_WIDTH-font:getWidth(text)) / 2), math.floor(20))
  end
  
  love.graphics.setNewFont(20)
  local font = love.graphics.newFont(20)
  local text = string.format("T-%02d", timeToImpact) .. "." .. math.floor(timeToImpact*10) % 10
  
  love.graphics.setColor(0.5, 0.5, 0)
  love.graphics.rectangle("fill", math.floor(SCREEN_WIDTH-font:getWidth(text)-15), math.floor(font:getHeight()-15), font:getWidth(text), font:getHeight(text))
  love.graphics.setColor(1, 1, 1)
  love.graphics.print(text, math.floor(SCREEN_WIDTH-font:getWidth(text)-15), math.floor(font:getHeight()-15))
end

function game.keypressed(key)
  if key == "space" then
    player:dodge()
    show_instructions = false
  elseif key == "escape" then
    love.event.quit(0)
  end
end