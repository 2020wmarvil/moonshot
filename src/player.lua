Player = Object:extend()

function Player:new(channel)
  self.channel = channel
  
  self.image = love.graphics.newImage("assets/player.png")
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()
  
  self.x = channel * channel_width - self.width / 2
  self.y = SCREEN_HEIGHT-100
  
  self.speed = self.width
  
  self.bb_off = 10
  self.bb = {}
  self:updateBB()
end

function Player:update(dt)
  
end

function Player:draw()  
  love.graphics.draw(self.image, self.x, self.y, 0, 1, 1, math.floor(self.width / 2), math.floor(self.height / 2))
  love.graphics.rectangle("line", self.bb.x1, self.bb.y1, self.bb.x2 - self.bb.x1, self.bb.y2 - self.bb.y1)
end

function Player:dodge(dir)
  self.channel = self.channel + dir
  if self.channel == 0 then self.channel = 2 end
  if self.channel > channels then self.channel = channels - 1 end
  
  self.x = self.channel * channel_width - self.width / 2
  
  self:updateBB()
end

function Player:updateBB()
  self.bb.x1 = self.x - self.width / 2 + self.bb_off
  self.bb.y1 = self.y - self.height / 2 + self.bb_off
  self.bb.x2 = self.x + self.width / 2 - self.bb_off
  self.bb.y2 = self.y + self.height / 2 - self.bb_off
end  