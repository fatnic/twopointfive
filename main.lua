local fl = 300
local stars = {}
local numStars = 21
local cZ = 1300
local radius = 1000
local baseAngle = 0
local rotationSpeed = 0.01
local yPos = 0

function love.load()
    love.graphics.setColor(255, 255, 255)

    for i=0, numStars-1 do
        local star = {
            y = 0,
            angle = (math.pi * 2 / numStars) * i,
            image = love.graphics.newImage('star.png')
        }
        star.x = math.cos(star.angle + baseAngle) * radius
        star.z = cZ + math.sin(star.angle + baseAngle) * radius
        table.insert(stars, star)
    end
end

function love.mousemoved(x, y)
    rotationSpeed = (x - love.graphics:getWidth() / 2) * 0.00005
    yPos = (y - love.graphics:getHeight() / 2) * 2
end

function love.draw()
    baseAngle = baseAngle + rotationSpeed

    love.graphics.translate(love.graphics:getWidth() / 2, love.graphics:getHeight() / 2)
    table.sort(stars, function(a,b) return a.z > b.z end)

    for _, star in pairs(stars) do
        local perspective = fl / (fl + star.z)
        star.y = yPos

        love.graphics.push()
        love.graphics.scale(perspective, perspective)
        love.graphics.translate(star.x, star.y)
        love.graphics.translate(-star.image:getWidth() / 2, -star.image:getHeight() / 2)
        love.graphics.draw(star.image, 0, 0)  
        love.graphics.pop()

        star.x = math.cos(star.angle + baseAngle) * radius
        star.z = cZ + math.sin(star.angle + baseAngle) * radius
    end
end
