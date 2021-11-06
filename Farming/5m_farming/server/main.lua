-- Leaked By: Leaking Hub | J. Snow | leakinghub.com
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

RegisterNetEvent('5m_farming:buyItem')
AddEventHandler('5m_farming:buyItem', function(item, count, price)
	local s = source
	local x = ESX.GetPlayerFromId(s)

	if x.getMoney() >= (count * price) then
		x.removeMoney(count * price)
		x.addInventoryItem(item, count)
	end
end)

RegisterNetEvent('5m_farming:removeItem')
AddEventHandler('5m_farming:removeItem', function(item)
	local s = source
	local x = ESX.GetPlayerFromId(s)
	x.removeInventoryItem(item, 1)
end)

RegisterNetEvent('5m_farming:giveItem')
AddEventHandler('5m_farming:giveItem', function (item, count)
	local s = source
	local x = ESX.GetPlayerFromId(s)
	x.addInventoryItem(item, 2)

	if item == 'wheat_seed' then
		x.addInventoryItem('wheat', count)
	elseif item == 'orange_seed' then
		x.addInventoryItem('orange', count)
	elseif item == 'coffee_seed' then
		x.addInventoryItem('coffee', count)
	elseif item == 'bean_seed' then
		x.addInventoryItem('bean', count)
	end
end)

ESX.RegisterUsableItem('wheat_seed', function(source)
	TriggerClientEvent('5m_farming:useItem', source, 'wheat_seed', 'Wheat')
end)

ESX.RegisterUsableItem('orange_seed', function(source)
	TriggerClientEvent('5m_farming:useItem', source, 'orange_seed', 'Orange')
end)

ESX.RegisterUsableItem('coffee_seed', function(source)
	TriggerClientEvent('5m_farming:useItem', source, 'coffee_seed', 'Coffee')
end)

ESX.RegisterUsableItem('bean_seed', function(source)
	TriggerClientEvent('5m_farming:useItem', source, 'bean_seed', 'Bean')
end)

ESX.RegisterUsableItem('giesskanne_voll', function(source)
	local s = source
	local x = ESX.GetPlayerFromId(s)

	x.removeInventoryItem('giesskanne_voll', 1)
	x.addInventoryItem('giesskanne_leer', 1)
	TriggerClientEvent('5m_farming:useKanne', source)
end)

ESX.RegisterUsableItem('giesskanne_leer', function(source)
	TriggerClientEvent('5m_farming:fillKanne', source)
end)

RegisterNetEvent('5m_farming:fillKanne')
AddEventHandler('5m_farming:fillKanne', function()
	local s = source
	local x = ESX.GetPlayerFromId(s)

	x.addInventoryItem('giesskanne_voll', 1)
	x.removeInventoryItem('giesskanne_leer', 1)
end)

local items = {
    ['bean'] = 1,
    ['coffee'] = 1,
    ['orange'] = 1,
    ['wheat'] = 1
}

RegisterNetEvent('5m_farming:sellItems')
AddEventHandler('5m_farming:sellItems', function()
	local s = source
	local x = ESX.GetPlayerFromId(s)

	for key, value in pairs(items) do
		local xitem = x.getInventoryItem(key)

		if xitem.count > 0 then
			x.removeInventoryItem(key, xitem.count)
			x.addMoney(xitem.count * value)
		end
	end
end)