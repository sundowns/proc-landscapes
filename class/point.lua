Point = Class {
    init = function(self, x, y)
        assert(x and y)
        self.x = x
        self.y = y
    end;
    jitterBy = function(self, spread)
        self.x = Util.maths.jitterBy(self.x, spread)
        self.y = Util.maths.jitterBy(self.y, spread)
    end;
    __tostring  = function(self)
        return '(' .. self.x .. ',' .. self.y .. ')'
    end;
    unpack = function(self)
        return self.x, self.y
    end;
}