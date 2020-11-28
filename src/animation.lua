Animation = Object:extend()

function Animation:new()  
  self.frames = {}
  table.insert(self.frames, love.graphics.newImage("assets/explosion1/frame1.png"))
  table.insert(self.frames, love.graphics.newImage("assets/explosion1/frame2.png"))
  table.insert(self.frames, love.graphics.newImage("assets/explosion1/frame3.png"))
  table.insert(self.frames, love.graphics.newImage("assets/explosion1/frame4.png"))
  table.insert(self.frames, love.graphics.newImage("assets/explosion1/frame5.png"))
  
  self.width = self.frames[1]:getWidth()
  self.height = self.frames[1]:getHeight()
  
  self.frame = 1
  self.time_per_frame = 0.1
  self.time = 0
end

function Animation:play(x, y)
  love.graphics.draw(self.frames[self.frame], x, y, 0, 1, 1, math.floor(self.width / 2), math.floor(self.height / 2))
end

function Animation:advance_frame()
  self.frame = self.frame + 1
  
  if self.frame == #self.frames + 1 then return false else return true end
end

