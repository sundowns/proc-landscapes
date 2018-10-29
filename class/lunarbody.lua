LunarBody = Class {
    init = function(self, x, y, radius, colour)
        assert(x)
        assert(y)
        assert(radius)
        assert(colour)
        self.x = x
        self.y = y
        self.radius = radius
        self.colour = colour
        self.canvas = love.graphics.newCanvas(love.graphics.getWidth(), love.graphics.getHeight())
        self:renderToCanvas()
    end;
    renderToCanvas = function(self)
        love.graphics.setCanvas(self.canvas)
            love.graphics.setColor(self.colour:toRGB())
            love.graphics.circle('fill', self.x, self.y, self.radius)
        love.graphics.setCanvas()
    end;
    draw = function(self)
        love.graphics.draw(self.canvas, x, y)
    end;

}