local fl = 300
local dots = {}
local numDots = 200
local cZ = 3000
local radius = 1000
local baseAngle = 0
local rotationSpeed = 0.01
local yPos = 0

function love.load()
    love.graphics.setColor(255, 255, 255)

    for i=0, numDots-1 do
        local dot = {
            angle = 0.2 * i,
            y = 3000 - 6000 / numDots * i
        }
        dot.x = math.cos(dot.angle + baseAngle) * radius
        dot.z = cZ + math.sin(dot.angle + baseAngle) * radius
        table.insert(dots, dot)
    end
end

function love.mousemoved(x, y)
    rotationSpeed = (x - love.graphics:getWidth() / 2) * 0.00005
    yPos = (y - love.graphics:getHeight() / 2) * 2
end

function love.draw()
    baseAngle = baseAngle + rotationSpeed

    love.graphics.translate(love.graphics:getWidth() / 2, love.graphics:getHeight() / 2)

    for _, dot in pairs(dots) do
        local perspective = fl / (fl + dot.z)

        love.graphics.push()
        love.graphics.scale(perspective, perspective)
        love.graphics.translate(dot.x, dot.y)
        
        love.graphics.circle('fill', 0, 0, 40)  
        love.graphics.pop()

        dot.x = math.cos(dot.angle + baseAngle) * radius
        dot.z = cZ + math.sin(dot.angle + baseAngle) * radius
    end
end
