Landscape = Class {
    init = function(self, y_offset, pixel_count, colour, opacity, octaves, persistence, noise_scale)
        assert(y_offset)
        assert(pixel_count)
        assert(opacity)
        assert(colour)
        assert(octaves)
        assert(persistence)
        assert(noise_scale)
        self.ready = false -- use this to generate as a part of the update cycle
        self.opacity = opacity
        self.y_offset = y_offset
        self.noise_scale = noise_scale
        self.pixel_count = pixel_count
        self.octaves = octaves
        self.persistence = persistence
        self.colour = colour
        self.pixel_map = {}
        self.seed = love.math.randomNormal() 
        self:generate()
    end;
    generate = function(self)
        self.canvas = love.graphics.newCanvas()
        for x = 0, self.pixel_count, 1 do
            self.pixel_map[x] = self:octaveSimplex(x, self.octaves, self.persistence)
        end

        self:renderToCanvas()
    end;
    renderToCanvas = function(self)
        love.graphics.setCanvas(self.canvas)
        love.graphics.setColor(self.colour:toRGB())
        for x = 0, self.pixel_count, 1 do
            for y = love.graphics.getHeight()+self.y_offset, self.pixel_map[x], -1 do
                love.graphics.points(x, y)
            end
        end;
        love.graphics.setCanvas()
    end;
    draw = function (self)
        love.graphics.setColor(1,1,1, self.opacity)
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