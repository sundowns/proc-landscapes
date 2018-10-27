Image = Class {
    init = function(self, colour_HSV)
        self.colour_HSV = colour_HSV -- Keep the same Hue and Sat, but vary value to get same shade of colour
        self.colours = {}
        self.colour_index = 1
        self.landscapes = {}
    end;
    update = function(self, dt)
    end;
    draw = function(self)
        for i = #self.landscapes, 1, -1 do
            self.landscapes[i]:draw()
        end;
    end;
    generateColourTable = function(self, count)
        self.colours = {}
        local value_increment = self.colour_HSV.v/count
        for i = 0, count-1 do 
            table.insert(self.colours, Colour(self.colour_HSV.h, self.colour_HSV.s, self.colour_HSV.v - value_increment*i)) 
        end
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
        self:generateColourTable(count)
        local offset = love.graphics.getHeight()*0.6
        local opacity = 1
        for i = 1, count do
            self:addLandscape(offset, opacity)
            offset = offset - love.math.random(love.graphics.getHeight()*0.15/count, love.graphics.getHeight()*0.6/count)
            opacity = opacity - (1/count)
        end
    end;
    addLandscape = function(self, y_offset, opacity)
        table.insert(self.landscapes,  Landscape(y_offset, love.graphics.getWidth(), self:getNextColour(), opacity, 24, 0.4, love.graphics.getHeight()/2))
    end;    
}
