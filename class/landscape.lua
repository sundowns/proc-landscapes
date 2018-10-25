Landscape = Class {
    init = function(self, colour, step_duration, spread, max_steps)
        self.step_duration = step_duration
        self.step_timer = step_duration
        self.step = 1
        self.max_steps = max_steps
        self.spread = spread
        self.colour = colour -- consider using palettes/ranges/gradients
        self.lines = {}
        self.filled = false
    end;
    update = function(self, dt)
        self.step_timer = self.step_timer - dt
        if self.step_timer <= 0 then
            if self.step <= self.max_steps then
                self:recurse()
            elseif not self.filled then
                self:fill()
            end

            self.step = self.step + 1
            self.step_timer = self.step_timer + self.step_duration
        end
    end;
    recurse = function(self)
        --[[
        - for each of our lines
            - Calculate the midpoint (see util.m.midpoint())
            - Randomly jitter the midpoint
            - Create two new lines (A -> mid, mid -> B)
            - Replace line with two new child lines (without looping over it in the same recurse)
        ]]

        --TODO: Need some sort of consideration to stop new lines overlapping old??

        local newLines = {}
        
        for i, line in pairs(self.lines) do
            local midpoint = line:midpoint()
            midpoint:jitterBy(self.spread)

            table.insert(newLines, Line(line.A, midpoint))
            table.insert(newLines, Line(midpoint, line.B))
        end
        self.lines = newLines
    end;
    fill = function(self)
        print("filling")
        self.filled = true
        --Finalise the image after completing midpoint displacement
    end;
    draw = function(self)
        love.graphics.setColor(self.colour)
        for i, line in pairs(self.lines) do
            line:draw()
        end;
        --TODO: consider calculating 
    end;
    addLine = function(self, line)
        table.insert(self.lines, line)
    end;
}
