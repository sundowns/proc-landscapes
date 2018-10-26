Landscape = Class {
    init = function(self, colour, step_duration, spread, max_steps)
        self.step_duration = step_duration
        self.step_timer = step_duration
        self.step = 1
        self.max_steps = max_steps
        self.spread = spread
        self.spread_decay = 0.5 -- constant or per landscape?
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

        --https://www.reddit.com/r/proceduralgeneration/comments/6cmrji/landscape_in_a_frame_i_tried_to_recreate_the_one/
        --https://github.com/rap2hpoutre/landscape

        local newLines = {}
        
        for i, line in pairs(self.lines) do
            local midpoint = line:midpoint()

            --TODO: replace this garbage
            if self.step == 1 then
                --Only allow going UP on the first recurse
                midpoint.x = midpoint.x + love.math.random(-1*self.spread, self.spread)
                midpoint.y = midpoint.y - love.math.random(self.spread/2, self.spread)
            else
                local jitteredX = Util.maths.jitterBy(midpoint.x, self.spread)
                midpoint.x = Util.maths.clamp(jitteredX, (line.A.x+midpoint.x)/2, (line.B.x+midpoint.x)/2)
                midpoint.y = Util.maths.jitterBy(midpoint.y, self.spread)
            end
            

            table.insert(newLines, Line(line.A, midpoint))
            table.insert(newLines, Line(midpoint, line.B))
        end
        self.lines = newLines
        self.spread = self.spread * self.spread_decay
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
    --https://jonoshields.com/2017/03/29/creating-procedurally-generated-scenes/
    octaveSimplex = function(x, y, z, octaves, persistence)
        local total = 0;
        local frequency = 1;
        local amplitude = 1;
        local maxValue = 0;  -- Used for normalizing result to 0.0 - 1.0
        for i=0,octaves,1 do 
            total = total + love.math.noise(x * frequency, y * frequency, z * frequency) * amplitude
            
            maxValue = maxValue + amplitude
            
            amplitude = amplitude * persistence
            frequency = frequency * 2
        end
        
        return total/maxValue
    end;        
}
