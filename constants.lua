return {
    LANDSCAPES = {
        COUNT = 6,
        OCTAVES = 100, -- 100
        PERSISTENCE = 0.47, --0.47
        LACUNARITY = 0.90, -- 0.9
        BASE_OFFSET_HEIGHT_RATIO = 0.5,
        NOISE_SCALE = 500, -- 500
        GRADIENT_VALUE_CHANGE = 5,
        LAYER_COLOUR_CHANGE = 0.6
    },
    BACKGROUND = {  
        VALUE_MULTIPLIER = 25, --lightness
        GRADIENT_VALUE_CHANGE = 150
    }, 
    LUNAR_BODY = {
        SPAWN_RATE = 0.5,
        MIN_RADIUS = 20,
        MAX_RADIUS = 120,
        MIN_X = 0.1, -- % of image width
        MAX_X = 0.8, -- % of image width
        MIN_Y = 0.1, -- % of image height
        MAX_Y = 0.6, -- % of image height
        HUE_VARIANCE = 20
    },
    RENDER_DELAY =  0.05 
}