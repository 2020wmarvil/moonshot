io.stdout:setvbuf("no")
  
SCREEN_WIDTH = love.graphics.getWidth()
SCREEN_HEIGHT = love.graphics.getHeight()

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
  require("src/planet")
  require("src/star")
  require("src/moon")
  require("src/earth")
  
  love.window.setTitle("Moonshot")
  love.window.setIcon(love.image.newImageData("assets/icon.png"))

  love.graphics.setBackgroundColor(0, 0, 0)
  
  load_images()
  load_audio()
  
  music:play()
  music:setVolume(0.25)
  music:setLooping(true)
  
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

function load_images()
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
  
  planet_images = {}
  table.insert(planet_images, love.graphics.newImage("assets/planet1.png"))
  table.insert(planet_images, love.graphics.newImage("assets/planet2.png"))
  table.insert(planet_images, love.graphics.newImage("assets/planet3.png"))
  table.insert(planet_images, love.graphics.newImage("assets/planet4.png"))
end

function load_audio() 
  explosion_sound = love.audio.newSource("assets/explosion_sound.wav", "static")
  
  -- Frag Out by DJ ASSASS1N, royalty free from NoCopyrightSounds
  music = love.audio.newSource("assets/background_music.mp3", "stream")
end

function collision(r1, r2)
  return r1.bb.x1 < r2.bb.x2 and r1.bb.x2 > r2.bb.x1 and r1.bb.y1 < r2.bb.y2 and r1.bb.y2 > r2.bb.y1
end
