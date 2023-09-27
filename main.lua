require "vector"
require "mover"
require "liquid"

function love.load()
    love.window.setTitle("Acceleration")
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    love.graphics.setBackgroundColor(150 / 255, 150 / 255, 150 / 255)
    mover = Mover:create(Vector:create(width/2, height/4), Vector:create(0, 0))
    water = Liquid:create(200, height-300, 350, 300, 0.25)
    gravity = Vector:create(0, 0.01)
end

function love.update(dt)
    mover:apply_force(gravity)
    friction = (mover.velocity * -1):norm()
    if friction then
        friction:mul(0.003)
        mover:apply_force(friction)
    end
    if water:is_inside(mover) then
        mag = mover.velocity:mag()
        drag = water.c * mag * mag
        drag_vec = (mover.velocity * -1):norm()
        drag_vec:mul(drag)
        mover:apply_force(drag_vec)
    end
    mover:check_boundaries()
    mover:update()
end

function love.draw()
    mover:draw()
    water:draw()
end