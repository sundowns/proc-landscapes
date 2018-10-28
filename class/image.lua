Image = Class {
    init = function(self, colour_HSV)
        self.colour_HSV = colour_HSV 
        self.colours = {}
        self.colour_index = 1
        self.landscapes = {}
        self.renderIndex = 1
        self.renderDelay = constants.RENDER_DELAY
        self.renderTimer = 0
        self.screenshotted = false
        self.complete = false
        self.screenshotted = false
        self.background = {}
        self:createBackground()
    end;
    update = function(self, dt)
        if not self.backgroundDrawn then
            self.backgroundDrawn = true
            return
        end

        if self.renderIndex > #self.landscapes then
            self.complete = true
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
        Util.l.resetColour()
        love.graphics.draw(self.background, 0, 0)

        for i = #self.landscapes, 1, -1 do
            self.landscapes[i]:draw()
        end;
    end;
    createBackground = function(self)
        self:calculateBackgroundColour()
        self.background = love.graphics.newCanvas()
        local reset = self.backgroundColour.s
        local colour = self.backgroundColour:clone()
        love.graphics.setCanvas(self.background)
            for x = 0, love.graphics.getWidth() do
                for y = love.graphics.getHeight(), 1, -1 do
                    colour:adjustSaturation(constants.BACKGROUND.GRADIENT_SATURATION_CHANGE/love.graphics.getHeight())
                    love.graphics.setColor(colour:toRGB())
                    love.graphics.points(x, y)
                end 
                colour.s = reset
            end
        love.graphics.setCanvas()
    end;
    calculateBackgroundColour = function(self)
        self.backgroundColour = self.colour_HSV:clone()
        self.backgroundColour:adjustHue(love.math.random(64,128))
        self.backgroundColour:adjustSaturation(-0.6*self.backgroundColour.s)
        self.backgroundColour.v = constants.BACKGROUND.VALUE_MULTIPLIER * self.backgroundColour.v
    end;
    generateColourTable = function(self, count)
        self.colours = {}
        local value_increment = self.colour_HSV.v/(count*constants.LANDSCAPES.LAYER_COLOUR_CHANGE)
        for i = 0, count-1 do 
            table.insert(self.colours, Colour(self.colour_HSV.h, self.colour_HSV.s, self.colour_HSV.v + value_increment*i)) 
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
        local persistence = constants.LANDSCAPES.PERSISTENCE
        for i = 1, count do
            self:addLandscape(offset, persistence)
            offset = offset - love.math.random(love.graphics.getHeight()*0.15/count, love.graphics.getHeight()*0.3/count)
            persistence = persistence * constants.LANDSCAPES.LACUNARITY
        end
    end;
    addLandscape = function(self, y_offset, persistence)
        table.insert(self.landscapes,  Landscape(y_offset, love.graphics.getWidth(), self:getNextColour(), constants.LANDSCAPES.OCTAVES, persistence))
    end;    
    screenshot = function(self)
        local name = 'screen-' .. os.time() .. '.png'
        love.graphics.captureScreenshot(name)
        print("Screenshot `"..name.."` to "..love.filesystem.getSaveDirectory())
        self.screenshotted = true
    end;
}
