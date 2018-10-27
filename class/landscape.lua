Landscape = Class {
    init = function(self, y_offset, pixel_count, colour, layer_index, octaves, persistence, noise_scale)
        assert(y_offset)
        assert(pixel_count)
        assert(layer_index)
        assert(colour)
        assert(octaves)
        assert(persistence)
        assert(noise_scale)
        self.layer_index = layer_index
        self.y_offset = y_offset
        self.noise_scale = noise_scale
        self.pixel_count = pixel_count
        self.octaves = octaves
        self.persistence = persistence
        self.colour = colour
        self.pixel_map = {}
        self.seed = love.math.random() --could make this per landscape to get shadow lines
        self:generate()
    end;
    generate = function(self)
        self.canvas = love.graphics.newCanvas() --does this clean up old one? TODO: test with util.stats
        for x = 0, self.pixel_count, 1 do
            self.pixel_map[x] = self:octaveSimplex(x, self.octaves, self.persistence)
        end

        self:renderToCanvas()
    end;
    renderToCanvas = function(self)
        love.graphics.setCanvas(self.canvas)
        love.graphics.setColor(self.colour)
        for x = 0, self.pixel_count, 1 do
            for y = love.graphics.getHeight(), self.pixel_map[x], -1 do
                love.graphics.points(x, y)
            end
        end;
        love.graphics.setCanvas()
    end;
    draw = function (self)
        love.graphics.setColor(1,1,1, 1/self.layer_index) --TODO: Pull transparency from layer ##
        love.graphics.draw(self.canvas, 0, self.y_offset)
    end;
    --https://jonoshields.com/2017/03/29/creating-procedurally-generated-scenes/
    octaveSimplex = function(self, x, octaves, persistence)
        local total = 0;
        local frequency = 1;
        local amplitude = 1;
        local maxValue = 0;  -- Used for normalizing result to 0.0 - 1.0
        for i=0,octaves,1 do 
            total = total + love.math.noise(x/self.pixel_count * frequency, self.seed) * amplitude
            
            maxValue = maxValue + amplitude
            
            amplitude = amplitude * persistence
            frequency = frequency * 2
        end

        return total/maxValue * self.noise_scale
    end;   
}