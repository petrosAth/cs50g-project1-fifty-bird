--[[
    Pause Class
    Author: Petros Athanasoulis
    coding@athanasoulis.me

    Pause enables the player to pause the game during play
    or countdown time. It displays a black transparent overlay with a pause icon in
    the middle and the message "Press P to Resume!"
]]

Pause = Class{}

local PAUSE_IMAGE = love.graphics.newImage('pause.png')

function Pause:init()
    self.status = false
end


function Pause:update(dt)
    -- pause game) only during 'countdown' and 'play' states
    if love.keyboard.wasPressed('p') and (gStateMachine.currentStateName == 'countdown' or gStateMachine.currentStateName == 'play') then
        if not self.status then
            self.status = true
            sounds['pause']:play()
            sounds['music']:pause()
        else
            self.status = false
            sounds['music']:play()
        end
    end

    if self.status then
        scrolling = false
    elseif gStateMachine.currentStateName == 'score' then
        scrolling = false

        gStateMachine:update(dt)
    else
        scrolling = true

        gStateMachine:update(dt)
    end
end


function Pause:render()
    love.graphics.setColor(0, 0, 0, 0.75)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(PAUSE_IMAGE, VIRTUAL_WIDTH / 2 - 35, 64)
    
    love.graphics.setFont(mediumFont)    
    love.graphics.printf('Press P to Resume!', 0, 146, VIRTUAL_WIDTH, 'center')
end