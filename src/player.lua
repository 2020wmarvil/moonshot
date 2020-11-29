Player = Object:extend()

function Player:new()  
  self.x = SCREEN_WIDTH / 2
  self.y = SCREEN_HEIGHT-100  
  self.image = love.graphics.newImage("assets/player.png")
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()
  
  self.direction = 0
  self.speed = self.width
  
  self.bb_off = 10
  self.bb = {}
  self:updateBB()
end

function Player:update(dt)
  if not player_move_vertical then
    self.x = self.x + self.speed * self.direction * dt
  else
    self.y = self.y - moon_speed * dt
  end
  
  self:updateBB()
end

function Player:draw()  
  love.graphics.draw(self.image, self.x, self.y, 0, 1, 1, math.floor(self.width / 2), math.floor(self.height / 2))
  --love.graphics.rectangle("line", self.bb.x1, self.bb.y1, self.bb.x2 - self.bb.x1, self.bb.y2 - self.bb.y1)
end

function Player:dodge()
  if self.direction == 0 then 
    if self.x < SCREEN_WIDTH / 2 then
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