game = {}

function game.init()  
  explosion = Animation()
  explosion.frame = 1
  explosion.time = 0
  
  timeToImpact = 10
  winTime = 1
end

function game.update(dt)
  timeToImpact = timeToImpact - dt
  if timeToImpact < winTime then
    startGameWon()
  end
  
  player:update(dt)
  
  for i,p in ipairs(planets) do
    p:update(dt)
    if p.destroyable then table.remove(planets, i) end
  end
  
  for i,a in ipairs(asteroids) do
    a:update(dt)
    if a.destroyable then table.remove(asteroids, i) end
    
    if (collision(player, a)) then
      collided_asteroid_index = i
      startGameOver()
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
  for i,p in ipairs(planets) do
    p:draw()
  end  
  
  player:draw()
  
  for i,a in ipairs(asteroids) do
    a:draw()
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
  elseif key == "escape" then
    love.event.quit(0)
  end
end