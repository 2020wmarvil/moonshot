Moon = Object:extend()

moon_speed = 300

function Moon:new()  
  self.image = love.graphics.newImage("assets/moon.png")
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()
  
  self.x = self.width / 2
  self.y = -self.height
  
  self.bbs = {}
  self:generateBBs()
end

function Moon:update(dt)
  if self.y < self.height / 2 - 3 then
    self.y = self.y + moon_speed * dt
    self:updateBBs(dt)
  else player_move_vertical = true end
end

function Moon:draw()  
  love.graphics.draw(self.image, self.x, self.y, math.pi, 1, 1, self.width / 2, self.height / 2)
end

function Moon:updateBBs(dt)
  for i,bb in ipairs(self.bbs) do  
    bb.y1 = bb.y1 + moon_speed * dt
    bb.y2 = bb.y2 + moon_speed * dt
  end
end

function Moon:generateBBs()  
  -- first row
  local bb1 = {}
  bb1.x1 = self.x - self.width / 2 + 30
  bb1.y1 = self.y - self.height / 2
  bb1.x2 = self.x + self.width / 2 - 30
  bb1.y2 = self.y - self.height / 4
  table.insert(self.bbs, bb1)
  
  local bb2 = {}
  bb2.x1 = 0
  bb2.y1 = self.y - self.height / 2
  bb2.x2 = 30
  bb2.y2 = self.y - self.height * 3 / 8
  table.insert(self.bbs, bb2)
  
  local bb3 = {}
  bb3.x1 = SCREEN_WIDTH - 30
  bb3.y1 = self.y - self.height / 2
  bb3.x2 = SCREEN_WIDTH
  bb3.y2 = self.y - self.height * 3 / 8
  table.insert(self.bbs, bb3)
  
  -- second row
  local bb4 = {}
  bb4.x1 = 95
  bb4.y1 = self.y - self.height / 4
  bb4.x2 = SCREEN_WIDTH - 95
  bb4.y2 = self.y
  table.insert(self.bbs, bb4)
  
  -- third row
  local bb7 = {}
  bb7.x1 = 155
  bb7.y1 = self.y
  bb7.x2 = SCREEN_WIDTH - 155
  bb7.y2 = self.y + self.height / 4 - 15
  table.insert(self.bbs, bb7)
  
  -- fourth row
  local bb10 = {}
  bb10.x1 = 305
  bb10.y1 = self.y + self.height / 4 - 15
  bb10.x2 = SCREEN_WIDTH - 305
  bb10.y2 = self.y + self.height / 2 - 15
  table.insert(self.bbs, bb10)
  
  local bb11 = {}
  bb11.x1 = 215
  bb11.y1 = self.y + self.height / 4 - 15
  bb11.x2 = 305
  bb11.y2 = self.y + self.height * 3 / 8 - 15
  table.insert(self.bbs, bb11)
  
  local bb12 = {}
  bb12.x1 = SCREEN_WIDTH - 305
  bb12.y1 = self.y + self.height / 4 - 15
  bb12.x2 = SCREEN_WIDTH - 215
  bb12.y2 = self.y + self.height * 3 / 8 - 15
  table.insert(self.bbs, bb12)  
  
  local bb13 = {}
  bb13.x1 = 255
  bb13.y1 = self.y + self.height * 3 / 8 - 15
  bb13.x2 = 305
  bb13.y2 = self.y + self.height * 7 / 16 - 15
  table.insert(self.bbs, bb13)
  
  local bb14 = {}
  bb14.x1 = SCREEN_WIDTH - 305
  bb14.y1 = self.y + self.height * 3 / 8 - 15
  bb14.x2 = SCREEN_WIDTH - 255
  bb14.y2 = self.y + self.height * 7 / 16 - 15
  table.insert(self.bbs, bb14)  
end

function collide(player, bb)  
  return player.bb.x1 < bb.x2 and player.bb.x2 > bb.x1 and player.bb.y1 < bb.y2 and player.bb.y2 > bb.y1
end

function Moon:collision(player)
  for i,bb in ipairs(self.bbs) do
    if collide(player, bb) then return true end
  end
  
  return false
end

