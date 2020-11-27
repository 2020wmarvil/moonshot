io.stdout:setvbuf("no")

function love.load()
  Object = require("libs/classic")
  require("src/player")
  
  love.graphics.setBackgroundColor(0, 0, 0)
  
  sheep = Player(100, 100, "assets/sheep.png")
end

function love.update(dt)
  sheep:update(dt)
end

function love.draw()
  sheep:draw()
  
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