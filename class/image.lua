Image = Class {
    init = function(self, colour_HSV)
        self.colour_HSV = colour_HSV -- Keep the same Hue and Sat, but vary value to get same shade of colour
        self.colours = {}
        self.colour_index = 1
        self.landscapes = {}
        self.renderIndex = 1
        self.renderDelay = constants.RENDER_DELAY
        self.renderTimer = 0
    end;
    update = function(self, dt)
        if self.renderIndex > #self.landscapes then
            return --All landscapes already
        end

        self.renderTimer = self.renderTimer - dt
        if self.renderTimer <= 0 then
            if self.renderIndex <= #self.landscapes then
                self.landscapes[self.renderIndex]:generate()
                self.renderIndex = self.renderIndex + 1
            end

            self.renderTimer = self.renderTimer + self.renderDelay
        end
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
        self.rendered = false
        self:generateColourTable(count)
        local offset = love.graphics.getHeight()*constants.LANDSCAPES.BASE_OFFSET_HEIGHT_RATIO
        for i = 1, count do
            self:addLandscape(offset)
            offset = offset - love.math.random(love.graphics.getHeight()*0.15/count, love.graphics.getHeight()*0.6/count)
        end
    end;
    addLandscape = function(self, y_offset)
        table.insert(self.landscapes,  Landscape(y_offset, love.graphics.getWidth(), self:getNextColour(), constants.LANDSCAPES.OCTAVES, constants.LANDSCAPES.PERSISTENCE))
    end;    
}
