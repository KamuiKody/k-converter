local convert = {
    menu = 'qb-menu', -- 'qb-menu', 'nh-context'
    input = 'qb-input' --[NOT MADE YET] not backward compatible qb-input is far superior please do not change this...
}

CreateThread(function()
    for k,v in pairs(convert) do
        if GetResourceState(v) == 'missing' then
            TriggerServerEvent('converter:missing', v)
            return 
        end
    end
end)

function openMenu(menu)
    if convert.menu == 'qb-menu' then
        exports['qb-menu']:openMenu(menu)
    elseif convert.menu == 'nh-context' then
        local conversion = {}
        for _,v in pairs(menu) do
            conversion[#conversion+1] = {
                header = v.header,
                context = v.txt,
                event = v.params.event,
                image = v.image,
                args = v.params.args
            }
        end
        exports['nh-context']:ContextMenu(conversion)
    end
end

function ContextMenu(menu)
    if convert.menu == 'nh-context' then
        exports['nh-context']:ContextMenu(menu)
    elseif convert.menu == 'qb-menu' then
        local conversion = {}
        for _,v in pairs(menu) do
            local menuHeader = false
            if not v.event then
                menuHeader = true
            end
            conversion[#conversion+1] = {
                header = v.header,
                isMenuHeader = menuHeader,
                txt = v.context,
                image = v.image,
                params = {
                    event = v.event,
                    args = v.args
                }
            }
        end
        exports['qb-menu']:openMenu(conversion)
    end
end

function showHeader(menu)
    if convert.menu == 'qb-menu' then
        exports['qb-menu']:showHeader(menu)
    elseif convert.menu == 'nh-context' then
        local conversion = {}
        for _,v in pairs(menu) do
            conversion[#conversion+1] = {
                header = v.header,
                context = v.txt,
                event = v.params.event,
                image = v.image,
                args = v.params.args
            }
        end
        exports['nh-context']:ContextMenu(conversion)
    end
end

function closeMenu()
    if convert.menu == 'qb-menu' then
        exports['qb-menu']:closeMenu()
    elseif convert.menu == 'nh-context' then
        exports['nh-context']:CancelMenu()
    end
end

function CancelMenu()
    if convert.menu == 'qb-menu' then
        exports['qb-menu']:closeMenu()
    elseif convert.menu == 'nh-context' then
        exports['nh-context']:CancelMenu()
    end
end

-- function ShowInput(input)
--     if convert.input == 'qb-input' then
--         exports['qb-menu']:ShowInput(input)
--     elseif convert.input == 'nh-keyboard' then
--         TriggerServerEvent('converter:missing', 'no_input')        
--     end
-- end

-- function Keyboard(input)
--     if convert.input == 'nh-keyboard' then
--         exports['nh-keyboard']:Keyboard(input)
--     elseif convert.input == 'qb-input' then
              
--     end
-- end

-- function CancelKeyboard()
--     if convert.input == 'nh-keyboard' then
--         exports['nh-keyboard']:CancelKeyboard()
--     elseif convert.input == 'qb-input' then
--         return
--     end
-- end

exports("openMenu", openMenu)
exports("showHeader", showHeader)
exports("ContextMenu", ContextMenu)
exports("closeMenu", closeMenu)
exports("CancelMenu", CancelMenu)
