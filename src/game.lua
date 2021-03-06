game = {}

function game.init()
  player_move_down = true
  collideable = false
  show_instructions = true
  
  local explosion_frames = {}
  table.insert(explosion_frames, love.graphics.newImage("assets/explosion1/frame1.png"))
  table.insert(explosion_frames, love.graphics.newImage("assets/explosion1/frame2.png"))
  table.insert(explosion_frames, love.graphics.newImage("assets/explosion1/frame3.png"))
  table.insert(explosion_frames, love.graphics.newImage("assets/explosion1/frame4.png"))
  table.insert(explosion_frames, love.graphics.newImage("assets/explosion1/frame5.png"))
  
  local flames_frames = {}
  table.insert(flames_frames, love.graphics.newImage("assets/flames/frame1.png"))
  table.insert(flames_frames, love.graphics.newImage("assets/flames/frame2.png"))
  table.insert(flames_frames, love.graphics.newImage("assets/flames/frame3.png"))
  table.insert(flames_frames, love.graphics.newImage("assets/flames/frame4.png"))
  
  explosion = Animation(explosion_frames)
  explosion.frame = 1
  explosion.time = 0
  
  flames = Animation(flames_frames)
  flames.frame = 1
  flames.time = 0
  
  invulnerability_duration = 3.5
  invulnerability_time = 0
  
  timeToImpact = 45
  winTime = 1
end

function game.update(dt)
  flames.time = flames.time + dt
  if flames.time > flames.time_per_frame then
    if not flames:advance_frame() then flames.frame = 1 end
    flames.time = 0
  end
  
  invulnerability_time = invulnerability_time + dt
  if invulnerability_time > invulnerability_duration then
    collideable = true
  end
  
  player:update(dt)
  earth:update(dt)
  
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
    
  timeToImpact = timeToImpact - dt
  if timeToImpact < winTime then
    startGameWon()
  end
end

function game.draw()  
  if show_instructions then
    love.graphics.setNewFont(20)
    local font = love.graphics.newFont(20)
    local text = "hit space to dodge!"
    love.graphics.print(text, math.floor((SCREEN_WIDTH-font:getWidth(text)) / 2), math.floor(20))
  else
    love.graphics.setNewFont(40)
    local font = love.graphics.newFont(40)
    local text = string.format("T-%02d", math.floor(timeToImpact)) .. "." .. math.floor(timeToImpact*10) % 10  
    love.graphics.print(text, math.floor((SCREEN_WIDTH-font:getWidth(text))/2), math.floor((SCREEN_HEIGHT-font:getHeight())/2))
  end
  
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
  
  local flamesX = player.x - player.direction * 4
  local flamesY = player.y + player.height / 2 - 10
  local flamesAngle = player.angle * math.pi / 180 * player.direction
  
  flames:play(flamesX, flamesY, flamesAngle)
  player:draw()  
end

function game.keypressed(key)
  if key == "space" then
    player:dodge()
    show_instructions = false
  elseif key == "escape" then
    love.event.quit(0)
  end
end