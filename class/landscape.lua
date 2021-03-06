Landscape = Class {
    init = function(self, y_offset, pixel_count, colour, octaves, persistence)
        assert(y_offset)
        assert(pixel_count)
        assert(colour)
        assert(octaves)
        assert(persistence)
        self.complete = false -- use this to generate as a part of the update cycle
        self.y_offset = y_offset
        self.noise_scale = constants.LANDSCAPES.NOISE_SCALE
        self.pixel_count = pixel_count
        self.octaves = octaves
        self.persistence = persistence
        self.colour = colour
        self.pixel_map = {}
        self.seed = nil
    end;
    generate = function(self)
        self.seed = love.math.random(1000) 
        self.canvas = love.graphics.newCanvas(love.graphics.getWidth(), love.graphics.getHeight(), {mipmaps="manual"})
        for x = 0, self.pixel_count, 1 do
            self.pixel_map[x] = self:octaveSimplex(x, self.octaves, self.persistence)
        end

        self:renderToCanvas()
        self.complete = true
    end;
    renderToCanvas = function(self)
        local reset =  self.colour.v
        local colour = self.colour:clone()
        love.graphics.setCanvas(self.canvas)
            for x = 0, self.pixel_count, 1 do
                for y = love.graphics.getHeight()+self.y_offset, self.pixel_map[x], -1 do
                    colour.v = colour.v - constants.LANDSCAPES.GRADIENT_VALUE_CHANGE/love.graphics.getHeight()
                    love.graphics.setColor(colour:toRGB())
                    love.graphics.points(x, y)
                end
                colour.v = reset
            end;
        love.graphics.setCanvas()
    end;
    draw = function (self)
        if not self.complete then
            return
        end
        
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