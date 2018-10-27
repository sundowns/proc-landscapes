love.math.setRandomSeed(os.time())
love.filesystem.setRequirePath(love.filesystem.getRequirePath()..";lib/?.lua;lib/;")
debug = false

-- Globals
local image = {} -- operate in a table so we can add layers

function love.load()
    Class = require("class")
    Util = require("util")
    constants = require("constants")
    require("class.landscape")
    require("class.image")
    require("class.colourHSV")

    love.filesystem.setIdentity("proc-landscapes")

    generate()
end

function generate()
    image = Image(Colour(love.math.random(255), love.math.random(20, 255), love.math.random(100,200)))
    image:addBulkLandscapes(constants.LANDSCAPES.COUNT)
end;

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
    elseif key == "space" then
        -- love.event.quit('restart')
        generate()
    end
end

function love.keyreleased(key)
    if key == "s" then
        if image.complete and not image.screenshotted then
            image:screenshot()
        end
    end
end