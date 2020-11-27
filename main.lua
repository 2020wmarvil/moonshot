io.stdout:setvbuf("no")
  
SCREEN_WIDTH = love.graphics.getWidth()
SCREEN_HEIGHT = love.graphics.getHeight()

function love.load()
  love.math.setRandomSeed(love.timer.getTime())

  Object = require("libs/classic")
  require("src/player")
  require("src/asteroid")
  
  running = true
  love.graphics.setBackgroundColor(0, 0, 0)
  
  player = Player(SCREEN_WIDTH/2, SCREEN_HEIGHT-100, "assets/sheep.png")
  
  asteroids = {}
  
  asteroidSpawnTimer = 0
  asteroidSpawnInterval = 1
end

function love.update(dt)
  player:update(dt)
  
  for i,a in ipairs(asteroids) do
    a:update(dt)
    if a.destroyable then table.remove(asteroids, i) end
    
    if (collision(player, a)) then 
      love.timer.sleep(0.5)
      running = false
    end
  end
  
  asteroidSpawnTimer = asteroidSpawnTimer + dt
  if asteroidSpawnTimer > asteroidSpawnInterval then
    table.insert(asteroids, spawnAsteroid())
    asteroidSpawnTimer = 0
  end  
end

function love.draw()
  if running then
    player:draw()
    
    for i,a in ipairs(asteroids) do
      a:draw()
    end
  else
    draw_splash()
  end
end

function love.keypressed(key)
  if key == "space" then
  elseif key == "escape" then
    love.event.quit(0)
  end
end

function draw_splash()    
  love.graphics.print("Moonshot", SCREEN_WIDTH/2, SCREEN_HEIGHT/2)
end

function collision(r1, r2)
  return r1.x < r2.x + r2.width 
    and r1.x + r1.width > r2.x 
    and r1.y < r2.y + r2.height 
    and r1.y + r1.height > r2.y
end

-- you're shooting yourself out of a cannon at the moon!
-- you're going straight up
-- asteroids and other space ships are in your way/floating around/hurtling towards you
-- button makes you dodge 