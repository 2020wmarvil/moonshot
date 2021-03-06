menu = {}

function menu.init()  
  earth = Earth() 
  
  player = Player()  
  player_move_vertical = false
  player_move_down = false
  
  asteroids = {}
  asteroidSpawnTimer = 0.5
  asteroidSpawnInterval = 0.5
  
  planets = {}
  planetSpawnTimer = 6
  planetSpawnInterval = 9
  
  stars = {}
  starSpawnTimer = 1.5
  starSpawnInterval = 2
end

function menu.update(dt)
  player:update(dt)
  
  for i,s in ipairs(stars) do
    s:update(dt)
    if s.destroyable then table.remove(stars, i) end
  end
  
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
    asteroidSpawnTimer = love.math.random(-0.2, 0.2)
  end  
  
  planetSpawnTimer = planetSpawnTimer + dt
  if planetSpawnTimer > planetSpawnInterval then
    table.insert(planets, spawnPlanet())
    planetSpawnTimer = love.math.random(-3, 3)
  end
  
  starSpawnTimer = starSpawnTimer + dt
  if starSpawnTimer > starSpawnInterval then
    table.insert(stars, spawnStar())
    starSpawnTimer = love.math.random(-1, 1)
  end  
end

function menu.draw()
  for i,s in ipairs(stars) do
    s:draw()
  end
  
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
