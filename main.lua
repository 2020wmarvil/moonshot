io.stdout:setvbuf("no")
  
SCREEN_WIDTH = love.graphics.getWidth()
SCREEN_HEIGHT = love.graphics.getHeight()

print (SCREEN_WIDTH)

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
  require("src/game_won")
  require("src/animation")
  require("src/player")
  require("src/asteroid")
  require("src/moon")
  
  love.graphics.setBackgroundColor(0, 0, 0)
  
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

function startGameWon()
  game_won.init()
  
  love.update = game_won.update
  love.draw = game_won.draw
  love.keypressed = game_won.keypressed
end

function collision(r1, r2)
  return r1.bb.x1 < r2.bb.x2 and r1.bb.x2 > r2.bb.x1 and r1.bb.y1 < r2.bb.y2 and r1.bb.y2 > r2.bb.y1
end
