io.stdout:setvbuf("no")
  
SCREEN_WIDTH = love.graphics.getWidth()
SCREEN_HEIGHT = love.graphics.getHeight()

-- you're shooting yourself out of a cannon at the moon!
-- you're going straight up
-- asteroids and other space ships are in your way/floating around/hurtling towards you
-- button makes you dodge 

function love.load()
  love.math.setRandomSeed(love.timer.getTime())

  Object = require("libs/classic")
  require("src/menu")
  require("src/game")
  require("src/game_over")
  require("src/player")
  require("src/asteroid")
  
  love.graphics.setBackgroundColor(0, 0, 0)
  
  channels = 11
  channel_width = SCREEN_WIDTH / channels
  
  startMenu()
end

function startMenu()
  menu.init()
  
  love.update = menu.update
  love.draw = menu.draw
  love.keypressed = menu.keypressed
end
  
function startGame()
  game.init()
  
  love.update = game.update
  love.draw = game.draw
  love.keypressed = game.keypressed
end

function startGameOver()
  game_over.init()
  
  love.update = game_over.update
  love.draw = game_over.draw
  love.keypressed = game_over.keypressed
end

function collision(r1, r2)
  return r1.x < r2.x + r2.width 
    and r1.x + r1.width > r2.x 
    and r1.y < r2.y + r2.height 
    and r1.y + r1.height > r2.y
end
