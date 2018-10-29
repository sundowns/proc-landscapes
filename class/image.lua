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
        self.background = {}
        self:generateBackground()
        self.lunarBodies = {}
        if love.math.random() < constants.LUNAR_BODY.CHANCE_OF_ANY then
            self:generateLunarBodies()
        end
    end;
    update = function(self, dt)
        if not self.backgroundDrawn then
            self.backgroundDrawn = true
            return
        end

        if self.renderIndex > #self.landscapes then
            self.complete = true
            return --All landscapes ready
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

        for i, body in pairs(self.lunarBodies) do
            love.graphics.setColor(1,1,1,1)
            body:draw()
        end

        Util.l.resetColour()
        for i = #self.landscapes, 1, -1 do
            self.landscapes[i]:draw()
        end;
    end;
    generateLunarBodies = function(self)
        local w = love.graphics.getWidth()
        local h = love.graphics.getHeight()

        for i = 1, constants.LUNAR_BODY.MAX_SPAWNS do
            if love.math.random() < constants.LUNAR_BODY.SPAWN_RATE then
                local x = love.math.random(constants.LUNAR_BODY.MIN_X*w, constants.LUNAR_BODY.MAX_X*w)
                local y = love.math.random(constants.LUNAR_BODY.MIN_Y*h, constants.LUNAR_BODY.MAX_Y*h)
                local radius = love.math.random(constants.LUNAR_BODY.MIN_RADIUS, constants.LUNAR_BODY.MAX_RADIUS)
                local hue = Util.m.jitterBy((self.colour_HSV.h + self.backgroundColour.h)/2, constants.LUNAR_BODY.HUE_VARIANCE)
                local colour = Colour(hue, love.math.random(1, 50), love.math.random(220,255))

                table.insert(self.lunarBodies, LunarBody(x, y, radius, colour))
            end
        end
    end;
    generateBackground = function(self)
        self:calculateBackgroundColour()
        self.background = love.graphics.newCanvas()
        local colour = self.backgroundColour:clone()
        local reset = colour.v
        love.graphics.setCanvas(self.background)
            for x = 0, love.graphics.getWidth() do
                for y = love.graphics.getHeight(), 1, -1 do
                    colour.v = colour .v + constants.BACKGROUND.GRADIENT_VALUE_CHANGE/love.graphics.getHeight()
                    love.graphics.setColor(colour:toRGB())
                    love.graphics.points(x, y)
                end 
                colour.v = reset
            end
        love.graphics.setCanvas() 
    end;
    calculateBackgroundColour = function(self)
        self.backgroundColour = self.colour_HSV:clone()
        self.backgroundColour:adjustHue(love.math.random(64,128))
        self.backgroundColour.v = Util.m.clamp(constants.BACKGROUND.VALUE_MULTIPLIER * self.backgroundColour.v, 150, 240)
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
