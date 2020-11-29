menu = {}

function menu.init()  
  earth = Earth() 
  
  player = Player()  
  player_move_vertical = false
  player_move_down = false
  
  asteroids = {}    
  asteroid_images = {}
  table.insert(asteroid_images, love.graphics.newImage("assets/asteroid1.png"))
  table.insert(asteroid_images, love.graphics.newImage("assets/asteroid2.png"))
  table.insert(asteroid_images, love.graphics.newImage("assets/asteroid3.png"))
  table.insert(asteroid_images, love.graphics.newImage("assets/asteroid4.png"))
  table.insert(asteroid_images, love.graphics.newImage("assets/asteroid5.png"))
  table.insert(asteroid_images, love.graphics.newImage("assets/asteroid6.png"))
  table.insert(asteroid_images, love.graphics.newImage("assets/asteroid7.png"))
  table.insert(asteroid_images, love.graphics.newImage("assets/asteroid8.png"))
  table.insert(asteroid_images, love.graphics.newImage("assets/asteroid9.png"))
  table.insert(asteroid_images, love.graphics.newImage("assets/asteroid10.png"))
  
  planets = {}
  planet_images = {}
  table.insert(planet_images, love.graphics.newImage("assets/planet1.png"))
  table.insert(planet_images, love.graphics.newImage("assets/planet2.png"))
  table.insert(planet_images, love.graphics.newImage("assets/planet3.png"))
  table.insert(planet_images, love.graphics.newImage("assets/planet4.png"))
  
  asteroidSpawnTimer = 0.5
  asteroidSpawnInterval = 0.5
  
  planetSpawnTimer = 6
  planetSpawnInterval = 9
end

function menu.update(dt)
  player:update(dt)
    
  for i,p in ipairs(planets) do
    p:update(dt)
    if p.destroyable then table.remove(planets, i) end
  end
  
  for i,a in ipairs(asteroids) do
    a:update(dt)
    if a.destroyable then table.remove(asteroids, i) end
  end
  
  asteroidSpawnTimer = asteroidSpawnTimer + dt
  if asteroidSpawnTimer > asteroidSpawnInterval then
    table.insert(asteroids, spawnAsteroid())
    asteroidSpawnTimer = 0
  end  
  
  planetSpawnTimer = planetSpawnTimer + dt
  if planetSpawnTimer > planetSpawnInterval then
    table.insert(planets, spawnPlanet())
    planetSpawnTimer = 0
  end  
end

function menu.draw()
  for i,p in ipairs(planets) do
    p:draw()
  end  
  
  for i,a in ipairs(asteroids) do
    a:draw()
  end   
  
  earth:draw()
  player:draw()
  
  love.graphics.setNewFont(20)
  local font = love.graphics.newFont(20)
  local text = "Moonshot"
  love.graphics.print(text, math.floor((SCREEN_WIDTH-font:getWidth(text))/2), 80)
  
  love.graphics.setNewFont(16)
  local subfont = love.graphics.newFont(16)
  local subtext = "hit space to go to space!"
  love.graphics.print(subtext, math.floor((SCREEN_WIDTH-subfont:getWidth(subtext))/2), 110)
end

function menu.keypressed(key)
  if key == "space" then
    startGame()
  elseif key == "escape" then
    love.event.quit(0)
  end
end
