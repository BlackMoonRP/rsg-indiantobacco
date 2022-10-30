local QRCore = exports['qr-core']:GetCoreObject()
local indiantrader

-- prompts
Citizen.CreateThread(function()
    for indiantrader, v in pairs(Config.IndianTraderLocations) do
        exports['qr-core']:createPrompt(v.location, v.coords, QRCore.Shared.Keybinds['J'], 'Open ' .. v.name, {
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

-- outlaw menu
RegisterNetEvent('rsg-indiantrader:client:openMenu', function(data)
    exports['qr-menu']:openMenu({
        {
            header = "| Indian Trader Menu |",
            isMenuHeader = true,
        },
        {
            header = "Trade 10 Indian Tobacco",
            txt = "trade 10 tobacco for 1 indian cigars",
            params = {
                event = 'rsg-indiantrader:server:tradetobacco',
				isServer = true,
				args = {trade = 1}
            }
        },
        {
            header = "Trade 50 Indian Tobacco",
            txt = "trade 50 tobacco for 5 indian cigars",
            params = {
                event = 'rsg-indiantrader:server:tradetobacco',
				isServer = true,
				args = {trade = 5}
            }
        },
        {
            header = "Trade 100 Indian Tobacco",
            txt = "trade 10 tobacco for 10 indian cigars",
            params = {
                event = 'rsg-indiantrader:server:tradetobacco',
				isServer = true,
				args = {trade = 10}
            }
        },
        {
            header = "Open Trader Shop",
            txt = "buy indian trade items",
            params = {
                event = 'rsg-indiantrader:client:OpenIndianShop',
				isServer = false,
				args = {}
            }
        },
        {
            header = "Close Menu",
            txt = '',
            params = {
                event = 'qr-menu:closeMenu',
            }
        },
    })
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