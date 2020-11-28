menu = {}

function menu.init()
  asteroid_images = {}
  table.insert(asteroid_images, love.graphics.newImage("assets/asteroid1.png"))
  table.insert(asteroid_images, love.graphics.newImage("assets/asteroid2.png"))
end

function menu.update(dt)
end

function menu.draw()  
  love.graphics.setNewFont(20)
  local font = love.graphics.newFont(20)
  local text = "Moonshot"
  love.graphics.print(text, math.floor((SCREEN_WIDTH-font:getWidth(text))/2), math.floor((SCREEN_HEIGHT-font:getHeight())/2) - 10)
  
  love.graphics.setNewFont(16)
  local subfont = love.graphics.newFont(16)
  local subtext = "hit space to go to space!"
  love.graphics.print(subtext, math.floor((SCREEN_WIDTH-subfont:getWidth(subtext))/2), math.floor((SCREEN_HEIGHT-subfont:getHeight())/2) + 10)
end

function menu.keypressed(key)
  if key == "space" then
    startGame()
  elseif key == "escape" then
    love.event.quit(0)
  end
end
