Point = Class {
    init = function(self, x, y)
        assert(x and y)
        self.x = x
        self.y = y
    end;
    __tostring  = function(self)
        return '(' .. self.x .. ',' .. self.y .. ')'
    end;
    unpack = function(self)
        return self.x, self.y
    end;
}