game = {}

function game.init()  
  player = Player(SCREEN_WIDTH/2, SCREEN_HEIGHT-100, "assets/sheep.png")
  
  asteroids = {}
  
  asteroidSpawnTimer = 0.5
  asteroidSpawnInterval = 1
end

function game.update(dt)
  player:update(dt)
  
  for i,a in ipairs(asteroids) do
    a:update(dt)
    if a.destroyable then table.remove(asteroids, i) end
    
    if (collision(player, a)) then 
      love.timer.sleep(0.5)
      
      startGameOver()
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
end

function game.keypressed(key)
  if key == "space" then
    -- do a barrel roll!
  elseif key == "escape" then
    love.event.quit(0)
  end
end