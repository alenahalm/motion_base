require("vector")
require("mover")

function love.load()
    love.window.setTitle("Acceleration")
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    love.graphics.setBackgroundColor(150 / 255, 150 / 255, 150 / 255)
    mover = Mover:create(Vector:create(width/2, height/2), Vector:create(0, 0), 2)
    wind = Vector:create(0.01, 0)
    is_wind = false
    gravity = Vector:create(0, 0.01)
    is_gravity = false
    floating = Vector:create(0, -0.02)
    is_floating = false
end

function love.update(dt)
    if is_gravity then
        mover:apply_force(gravity)
    end
    if is_floating then
        mover:apply_force(floating)
    end
    if is_wind then
        mover:apply_force(wind)
    end
    friction = (mover.velocity * -1):norm()
    if friction then
        friction:mul(0.005)
        mover:apply_force(friction)
    end
    mover:update()
    mover:check_boundaries()
end

function love.draw()
    mover:draw()
    love.graphics.print("w: " .. tostring(is_wind) ..
                        " g: " .. tostring(is_gravity) ..
                        " f: " .. tostring(is_floating),
                        10, height - 20)
    love.graphics.line(width/2, 0, width/2, height)
end

function love.keypressed(key)
    if key == 'g' then
        is_gravity = not is_gravity
    end
    if key == 'f' then
        is_floating = not is_floating
    end
    if key == 'w' then
        is_wind = not is_wind
        if is_wind then 
            wind:mul(-1)
        end
    end
end