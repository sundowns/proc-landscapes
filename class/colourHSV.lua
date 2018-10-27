Colour = Class{
    init = function(self, hue, sat, val)
        self.h = hue
        self.s = sat
        self.v = val
    end;
    toRGB = function(self)
        return Util.m.HSVtoRGB(self.h, self.s, self.v)
    end;
}