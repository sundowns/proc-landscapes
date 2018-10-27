Colour = Class{
    init = function(self, hue, sat, val)
        self.h = hue
        self.s = sat
        self.v = val
    end;
    toRGB = function(self)
        return Util.m.HSVtoRGB(self.h, self.s, self.v)
    end;
    clone = function(self)
        return Colour(self.h, self.s, self.v)
    end;
    adjustHue = function(self, delta)
        self.h = self.h + delta
        if self.h > 255 then
            self.h = self.h - 255
        end
    end;
    adjustSaturation = function(self, delta)
        self.s = self.s + delta
        if self.s > 255 then
            self.s = self.s - 255
        end
    end;
    adjustValue = function(self, delta)
        self.v = self.v + delta
        if self.v > 255 then
            self.v = self.v - 255
        end
    end;
}