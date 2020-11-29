Player = Object:extend()

function Player:new()
  self.image = love.graphics.newImage("assets/player.png")
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()  
  
  self.x = SCREEN_WIDTH / 2
  self.y = earth.y - earth.height / 2 - self.height / 2 + 30
  self.angle = 5
  
  self.direction = 0
  self.speed = self.width
  
  self.bb_off = 10
  self.bb = {}
  self:updateBB()
end

function Player:update(dt)
  if player_move_down then
    self.y = self.y + (earth_speed/2) * dt
    
    if self.y > SCREEN_HEIGHT - 100 then player_move_down = false end
  end
    
  if not player_move_vertical then
    self.x = self.x + self.speed * self.direction * dt
  else
    self.y = self.y - moon_speed * dt
  end
  
  if self.x + self.width / 2 > SCREEN_WIDTH then
    self.x = SCREEN_WIDTH - self.width / 2
    self.direction = 0
  elseif self.x < self.width / 2 then
    self.x = self.width / 2
    self.direction = 0
  end
  
  self:updateBB()
end

function Player:draw()
  local angle = 15
  love.graphics.draw(self.image, self.x, self.y, self.direction * self.angle * math.pi / 180, 1, 1, math.floor(self.width / 2), math.floor(self.height / 2))
end

function Player:dodge()
  if self.direction == 0 then 
    if self.x == SCREEN_WIDTH - self.width / 2 then
      self.direction = -1
    else
      self.direction = 1
    end
  else
    self.direction = -self.direction
  end
end

function Player:updateBB()
  self.bb.x1 = self.x - self.width / 2 + self.bb_off
  self.bb.y1 = self.y - self.height / 2 + self.bb_off
  self.bb.x2 = self.x + self.width / 2 - self.bb_off
  self.bb.y2 = self.y + self.height / 2 - self.bb_off
end  