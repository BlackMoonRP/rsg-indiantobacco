local RSGCore = exports['rsg-core']:GetCoreObject()
local indiantrader

-- prompts
Citizen.CreateThread(function()
    for indiantrader, v in pairs(Config.IndianTraderLocations) do
        exports['rsg-core']:createPrompt(v.location, v.coords, RSGCore.Shared.Keybinds['J'], 'Open ' .. v.name, {
            type = 'client',
            event = 'rsg-indiantrader:client:openMenu',
            args = {},
        })
        if v.showblip == true then
            local IndianTraderBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
            SetBlipSprite(IndianTraderBlip, Config.Blip.blipSprite, 1)
            SetBlipScale(IndianTraderBlip, Config.Blip.blipScale)
            Citizen.InvokeNative(0x9CB1A1623062F402, IndianTraderBlip, Config.Blip.blipName)
        end
    end
end)

-- draw marker if set to true in config
CreateThread(function()
    while true do
        local sleep = 0
        for indiantrader, v in pairs(Config.IndianTraderLocations) do
            if v.showmarker == true then
                Citizen.InvokeNative(0x2A32FAA57B937173, 0x07DCE236, v.coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 215, 0, 155, false, false, false, 1, false, false, false)
            end
        end
        Wait(sleep)
    end
end)

-- indian trader menu
RegisterNetEvent('rsg-indiantrader:client:openMenu', function(data)
    lib.registerContext(
        {
            id = 'indiantrader_menu',
            title = 'Indian Trader Menu',
            position = 'top-right',
            options = {
                {
                    title = 'Trade 10 Indian Tobacco',
                    description = 'trade 10 tobacco for 1 indian cigars',
                    icon = 'fa-solid fa-arrows-rotate',
                    serverEvent = 'rsg-indiantrader:server:tradetobacco',
                    args = {trade = 1}
                },
                {
                    title = 'Trade 50 Indian Tobacco',
                    description = 'trade 50 tobacco for 5 indian cigars',
                    icon = 'fa-solid fa-arrows-rotate',
                    serverEvent = 'rsg-indiantrader:server:tradetobacco',
                    args = {trade = 5}
                },
                {
                    title = 'Trade 100 Indian Tobacco',
                    description = 'trade 10 tobacco for 10 indian cigars',
                    icon = 'fa-solid fa-arrows-rotate',
                    serverEvent = 'rsg-indiantrader:server:tradetobacco',
                    args = {trade = 10}
                },
            }
        }
    )
    lib.showContext('indiantrader_menu')
end)

-- indian trader shop
RegisterNetEvent('rsg-indiantrader:client:OpenIndianShop')
AddEventHandler('rsg-indiantrader:client:OpenIndianShop', function()
    local ShopItems = {}
    ShopItems.label = "Indian Trader"
    ShopItems.items = Config.IndianTraderShop
    ShopItems.slots = #Config.IndianTraderShop
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "IndianTraderShop_"..math.random(1, 99), ShopItems)
end)