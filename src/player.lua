Player = Object:extend()

function Player:new(channel)
  self.channel = channel
  self.x = channel * channel_width
  self.y = SCREEN_HEIGHT-100
  self.image = love.graphics.newImage("assets/player.png")
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()
  self.speed = self.width
  
  self.bb = {}
  self.bb.x1 = self.x - self.width / 2
  self.bb.y1 = self.y - self.height / 2
  self.bb.x2 = self.x + self.height / 2
  self.bb.y2 = self.y + self.height / 2
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
  if self.channel == channels then self.channel = channels - 2 end
  
  self.x = self.channel * channel_width
  
  self.bb.x1 = self.x - self.width / 2
  self.bb.x2 = self.x + self.height / 2
end