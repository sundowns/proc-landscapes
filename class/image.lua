Image = Class {
    init = function(self)
        self.colours = {
            {1,42/255,0},
            {1,128/255,0},
            {1,1,0},
            {170/255, 1, 0},
            {43/255, 1, 0},
            {0, 1, 1},
            {0, 128/255, 1},
            {0, 42/255, 1},
            {128/255, 0, 1},
            {1, 0, 1},
            {1, 0, 43/255}
        }
        self.colour_index = 1
        self.landscapes = {}
    end;
    update = function(self, dt)
    end;
    draw = function(self)
        -- for i, landscape in pairs(self.landscapes) do
        for i = #self.landscapes, 1, -1 do
            self.landscapes[i]:draw()
            -- landscape:draw()
        end;
        Util.d.log("-----------------------")
    end;
    getNextColour = function(self)
        local colour = self.colours[self.colour_index]
        self.colour_index = self.colour_index + 1
        if self.colour_index > #self.colours then
            self.colour_index = 1
        end
        return colour
    end;
    addBulkLandscapes = function(self, count)
        local offset = love.graphics.getHeight()*0.5
        local opacity = 1
        for i = 1, count do
            self:addLandscape(offset, opacity)
            offset = offset - love.math.random(love.graphics.getHeight()*0.05, love.graphics.getHeight()/2/count)
            opacity = opacity - (1/count)
        end
    end;
    addLandscape = function(self, y_offset, opacity)
        table.insert(self.landscapes,  Landscape(y_offset, love.graphics.getWidth(), self:getNextColour(), opacity, 24, 0.4, 300))
    end;    
}
