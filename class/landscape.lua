Landscape = Class {
    init = function(self, colour, step_duration, spread)
        self.step_duration = step_duration
        self.step_timer = step_duration
        self.spread = spread
        self.colour = colour -- consider using palettes/ranges/gradients
        self.lines = {}
    end;
    update = function(self, dt)
        self.step_timer = self.step_timer - dt
        if self.step_timer <= 0 then
            self:recurse()
            self.step_timer = self.step_timer + self.step_duration
        end
    end;
    recurse = function(self)
        --[[
        - for each of our lines
            - Calculate the midpoint (see util.m.midpoint())
            - Randomly move it ALONG THE LINE by a random number from -spread -> +spread (https://math.stackexchange.com/questions/175896/finding-a-point-along-a-line-a-certain-distance-away-from-another-point#175906)
            - Create two new lines (A -> mid, mid -> B)
            - Replace line with two new child lines (without looping over it in the same recurse)
        ]]
        for i, line in pairs(self.lines) do
            local midpoint = line:midpoint()


            --https://math.stackexchange.com/questions/175896/finding-a-point-along-a-line-a-certain-distance-away-from-another-point#175906
            --DONT do the below, you need to find the function of the line and move along it!! Do above instead
            -- local newX = midpoint.x + love.math.random(self.spread*-1, self.spread)
            -- local newY = midpoint.y + love.math.random(self.spread*-1, self.spread)
            print(Point(newX, newY)) 
        end
    end;
    draw = function(self)
        love.graphics.setColor(self.colour)
        for i, line in pairs(self.lines) do
            line:draw()
        end;
    end;
    addLine = function(self, line)
        table.insert(self.lines, line)
    end;
}
