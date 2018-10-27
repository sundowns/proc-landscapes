love.filesystem.setRequirePath(love.filesystem.getRequirePath()..";lib/?.lua;lib/;")
debug = false
local running = true

love.math.setRandomSeed(os.time())

-- Globals
local image = {} -- operate in a table so we can add layers

function love.load()
    Class = require("class")
    Util = require("util")
    constants = require("constants")
    require("class.landscape")
    require("class.image")
    require("class.colourHSV")

    image = Image(Colour(love.math.random(255), love.math.random(20, 255), love.math.random(150,255)))
    image:addBulkLandscapes(constants.LANDSCAPES.COUNT)
end

function love.update(dt)
    image:update(dt)
end

function love.draw()
    image:draw()

    if debug then
        love.graphics.setColor(0,1,1)
        Util.love.renderStats(0, 0)
    end
end

function love.keypressed(key)
    if key == "f1" then
        debug = not debug
    elseif key == "escape" then
        love.event.quit()
    elseif key == "r" then
        love.event.quit('restart')
    end
end
