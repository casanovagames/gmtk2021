-- Libs.
local anim8 = require("libs.anim8")

-- Scripts.
local Object = require("libs.classic")
--------------------------------------

function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
    return x1 < x2+w2 and
           x2 < x1+w1 and
           y1 < y2+h2 and
           y2 < y1+h1
end

local Coin = Object:extend()

function Coin:new(scr, x, y)
    -- Position.
    self.x, self.y = x, y
    self.w, self.h = 34, 34

    self.sprite = scr.assets.sprites["tileset"]
    local g = anim8.newGrid(self.w, self.h, self.sprite:getWidth(), self.sprite:getHeight())
    self.frame = g:getFrames(1, 5)
    print(self.frame[1])

    self.scr = scr
end

function Coin:update(dt)
    local player = self.scr.objects.player

    if CheckCollision(self.x, self.y, self.w, self.h, player.x, player.y, player.w, player.h) then
        for i, v in pairs(self.scr.objects) do
            if (v == self) then
                self.scr.assets.sfx["coin"]:play()
                table.remove(self.scr.objects, i)
            end
        end
    end
end

function Coin:draw()
    love.graphics.draw(self.sprite, self.frame[1], self.x, self.y)
end

return Coin
  