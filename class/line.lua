Line = Class {
    init = function(self, pointA, pointB)
        assert(pointA and pointA.x and pointA.y)
        assert(pointB and pointB.x and pointB.y)
        self.A = pointA
        self.B = pointB
    end;
    midpoint = function(self)
        return Point(Util.m.midpoint(self.A.x, self.A.y, self.B.x, self.B.y))
    end;
    draw = function (self)
        love.graphics.line(self.A.x, self.A.y, self.B.x, self.B.y)
    end;
}