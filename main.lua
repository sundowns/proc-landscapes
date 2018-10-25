love.filesystem.setRequirePath(love.filesystem.getRequirePath()..";lib/?.lua;lib/;")
debug = false

love.math.setRandomSeed(os.time())

-- Constants
-- TODO: CONSIDER VARYING SOME OF THESE PER LANDSCAPE
local STEP_DURATION = 0.5 -- seconds
local STEPS = 10
local SPREAD = 30

-- Globals
local landscapes = {} -- operate in a table so we can add layers

function love.load()
    Class = require("class")
    Util = require("util")
    require("class.line")
    require("class.point")
    require("class.landscape")

    local newLandscape = Landscape(
        {1,0,0},
        STEP_DURATION,
        SPREAD,
        STEPS
    )
    newLandscape:addLine(Line(Point(0, love.graphics.getHeight()/2), Point(love.graphics.getWidth(),love.graphics.getHeight()/2)))
    table.insert(landscapes, newLandscape)
end

function love.update(dt)
    for i, landscape in ipairs(landscapes) do
        landscape:update(dt)
    end
end

function love.draw()
    for i, landscape in ipairs(landscapes) do
        landscape:draw()
    end
end

function love.keypressed(key)
    if key == "f1" then
        debug = not debug
    end
end
