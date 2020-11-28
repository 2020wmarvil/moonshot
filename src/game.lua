game = {}

function game.init()  
  player = Player(6)
  
  asteroids = {}
  
  asteroidSpawnTimer = 0.5
  asteroidSpawnInterval = 1
  
  timeToImpact = 30
end

function game.update(dt)
  timeToImpact = timeToImpact - dt
  if timeToImpact < 0 then
    --startGameWon()
  end
  
  player:update(dt)
  
  for i,a in ipairs(asteroids) do
    a:update(dt)
    if a.destroyable then table.remove(asteroids, i) end
    
    if (collision(player, a)) then 
      love.timer.sleep(0.5)
      
      --startGameOver()
    end
  end
  
  asteroidSpawnTimer = asteroidSpawnTimer + dt
  if asteroidSpawnTimer > asteroidSpawnInterval then
    table.insert(asteroids, spawnAsteroid())
    asteroidSpawnTimer = 0
  end  
end

function game.draw()
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
    local dir = 1
    if love.math.random(0, 1) == 1 then dir = -1 end
    player:dodge(dir)
  elseif key == "escape" then
    love.event.quit(0)
  end
end