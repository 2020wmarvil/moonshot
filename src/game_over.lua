game_over = {}

function game_over.init()
end

function game_over.update(dt)
end

function game_over.draw()
  love.graphics.setNewFont(20)
  local font = love.graphics.newFont(20)
  local text = "GAME OVER"
  love.graphics.print(text, math.floor((SCREEN_WIDTH-font:getWidth(text))/2), math.floor((SCREEN_HEIGHT-font:getHeight())/2) - 10)
  
  love.graphics.setNewFont(16)
  local subfont = love.graphics.newFont(16)
  local subtext = "hit space to reset!"
  love.graphics.print(subtext, math.floor((SCREEN_WIDTH-subfont:getWidth(subtext))/2), math.floor((SCREEN_HEIGHT-subfont:getHeight())/2) + 10)
end

function game_over.keypressed(key)
  if key == "space" then
    startMenu()
  elseif key == "escape" then
    love.event.quit(0)
  end
end
