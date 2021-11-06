-- Leaked By: Leaking Hub | J. Snow | leakinghub.com
ESX               = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("hell_mushroomfarmer:sell")
AddEventHandler("hell_mushroomfarmer:sell", function()
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    local money = math.random(80,500)
      xPlayer.addMoney(money)
      TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'success', text = '' ..money.. '$ Dollers Made.', length = 2500 })
end)