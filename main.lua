io.stdout:setvbuf("no")
  
SCREEN_WIDTH = love.graphics.getWidth()
SCREEN_HEIGHT = love.graphics.getHeight()

function love.load()
  love.math.setRandomSeed(love.timer.getTime())

  Object = require("libs/classic")
  require("src/player")
  require("src/asteroid")
  
  love.graphics.setBackgroundColor(0, 0, 0)
  
  sheep = Player(100, 100, "assets/sheep.png")
  
  asteroids = {}
  
  asteroidSpawnTimer = 0
  asteroidSpawnInterval = 1
end

function love.update(dt)
  sheep:update(dt)
  
  for i,a in ipairs(asteroids) do
    a:update(dt)
  end
  
  asteroidSpawnTimer = asteroidSpawnTimer + dt
  if asteroidSpawnTimer > asteroidSpawnInterval then
    table.insert(asteroids, spawnAsteroid())
    asteroidSpawnTimer = 0
  end
end

function love.draw()
  sheep:draw()
  
  for i,a in ipairs(asteroids) do
    a:draw()
  end
  
  draw_splash()
end

function love.keypressed(key)
  if key == "space" then
  elseif key == "escape" then
    love.event.quit(0)
  end
end

function draw_splash()    
  love.graphics.print("Moonshot", 0, 0)
end

-- you're shooting yourself out of a cannon at the moon!
-- you're going straight up
-- asteroids and other space ships are in your way/floating around/hurtling towards you
-- button makes you dodge 