return {
    CONFIG_NAME="avatar",
    LANDSCAPES = {
        COUNT = 6,
        OCTAVES = 6, -- 100
        PERSISTENCE = 0.47, --0.47
        LACUNARITY = 0.9, -- 0.9
        BASE_OFFSET_HEIGHT_RATIO = 0.4,
        MIN_OFFSET_CHANGE_MULTIPLIER = 0.1,
        MAX_OFFSET_CHANGE_MULTIPLIER = 0.2,
        NOISE_SCALE = 700, -- 500
        GRADIENT_VALUE_CHANGE = 5,
        LAYER_COLOUR_CHANGE = 0.25,
    },
    BACKGROUND = {  
        VALUE_MULTIPLIER = 25, --lightness
        GRADIENT_VALUE_CHANGE = 150
    }, 
    LUNAR_BODY = {
        CHANCE_OF_ANY = 1,
        SPAWN_RATE = 1,
        MAX_SPAWNS = 2,
        MIN_RADIUS = 30,
        MAX_RADIUS = 120,
        MIN_X = 0.1, -- % of image width
        MAX_X = 0.8, -- % of image width
        MIN_Y = 0.1, -- % of image height
        MAX_Y = 0.5, -- % of image height
        HUE_VARIANCE = 50
    },
    RENDER_DELAY =  0.01,
    HEIGHT = 800,
    WIDTH = 800,
}