Image = Class {
    init = function(self)
        self.colours = {
            {1,42/255,0},
            {1,128/255,0},
            {1,1,0},
            {170/255, 255, 0},
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
        for i, landscape in pairs(self.landscapes) do
            landscape:draw()
        end;
    end;
    getNextColour = function(self)
        local colour = self.colours[self.colour_index]
        self.colour_index = self.colour_index + 1
        if self.colour_index > #self.colours then
            self.colour_index = 1
        end
        return colour
    end;
    addLandscape = function(self, y_offset, pixel_count, layer_index)
        -- make octaves, persistence, and noise scale controlled by input or something idk
        local landscape = Landscape(y_offset, pixel_count, self:getNextColour(), layer_index, 24, 0.4, 300)
        table.insert(self.landscapes, landscape)
    end;    
}
