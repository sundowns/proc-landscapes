love.filesystem.setRequirePath(love.filesystem.getRequirePath()..";lib/?.lua;lib/;")
debug = false
local running = true

love.math.setRandomSeed(os.time())

-- Constants
-- TODO: CONSIDER VARYING SOME OF THESE PER LANDSCAPE
local LANDSCAPE_COUNT = 10

-- Globals
local image = {} -- operate in a table so we can add layers

function love.load()
    Class = require("class")
    Util = require("util")
    require("class.landscape")
    require("class.image")

    image = Image()

    for i = 1, LANDSCAPE_COUNT do
        image:addLandscape(love.math.random(love.graphics.getHeight()/10, love.graphics.getHeight()/2), love.graphics.getWidth(), i)
    end
end

function love.update(dt)
    if running then
        image:update(dt)
    end
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
    elseif key == "space" then
        running = not running
    elseif key == "escape" then
        love.event.quit()
    elseif key == "r" then
        love.event.quit('restart')
    end
end
