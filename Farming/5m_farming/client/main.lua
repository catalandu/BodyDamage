-- Leaked By: Leaking Hub | J. Snow | leakinghub.com
local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}


ESX = nil
local PlayerData = {}
local props = {
    --{label = "", item = "", state = 0, water = 100, prop = nil}
}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()
end)

local enableField = false

function toggleField(enable)
    SetNuiFocus(enable, enable)
    enableField = enable

    if enable then
        SendNUIMessage({
            action = 'open'
        }) 
    else
        SendNUIMessage({
            action = 'close'
        }) 
    end
end

AddEventHandler('onResourceStart', function(name)
    if GetCurrentResourceName() ~= name then
        return
    end

    toggleField(false)
end)

AddEventHandler('onResourceStop', function(name)
    if GetCurrentResourceName() ~= name then
        return
    end

    for key, value in pairs(props) do
        ESX.Game.DeleteObject(value.prop)
    end
end)

RegisterNUICallback('escape', function(data, cb)
    toggleField(false)
    SetNuiFocus(false, false)

    cb('ok')
end)

local shops = {
    vector3(-408.61, -6497.25, -27.83)
}

--[[ Citizen.CreateThread(function()
	for k,v in pairs(Config.Zones) do
		local blip = AddBlipForCoord(v)

		SetBlipSprite (blip, 479)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.8)
		SetBlipColour (blip, 25)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString("Acker")
		EndTextCommandSetBlipName(blip)
	end
end) ]]

Citizen.CreateThread(function()
    for k,v in pairs(Config.Zones) do
      local blip = AddBlipForCoord(v.Pos.x, v.Pos.y, v.Pos.z)
      SetBlipDisplay(blip, 4)
      SetBlipScale  (blip, 1.0)
      SetBlipColour (blip, 2)
      SetBlipAsShortRange(blip, true)
      BeginTextCommandSetBlipName("STRING")
      SetBlipSprite (blip, 479)
      SetBlipAsShortRange(blip, true)
      SetBlipColour (blip, 2)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString("Farmer job")
      EndTextCommandSetBlipName(blip)
    end
end)

Citizen.CreateThread(function()
    while true do
        for k,v in pairs(shops) do
            DrawMarker(21, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 255, false, false, 2, 45.0, nil, nil, false)
        end
        Wait(1)
    end
end)

CreateThread(function ()
    while true do
        local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
        for k,v in pairs(shops) do
            local x2,y2,z2 = table.unpack(v)
            local dist = GetDistanceBetweenCoords(x,y,z,x2,y2,z2,false)

            if dist <= 1.5 then
                ShowHelp("Press ~INPUT_CONTEXT~ to buy seeds")

                if IsControlJustPressed(0, 38) then
                    toggleField(true)
                end
            end
        end

        Wait(0)
    end
end)

function ShowHelp(msg, thisFrame, duration)
    AddTextEntry('esxHelpNotification', msg)
    BeginTextCommandDisplayHelp('esxHelpNotification')
	EndTextCommandDisplayHelp(0, false, true, duration or -1)
end

RegisterNUICallback('buy', function(data, cb)
    local item, count, price = data.item, data.count, data.price

    TriggerServerEvent('5m_farming:buyItem', item, count, price)

    cb('ok')
end)

local field = {
    {
        coords = vector3(282.19, 6480.26, 30.16)
    },
    {
        coords = vector3(263.44, 6478.27, 30.63)
    }
}

CreateThread(function()
    while true do
        for k,v in pairs(field) do
            DrawMarker(0, v.coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.5, 255, 0, 0, 255, false, false, 2, 45.0, nil, nil, false)
        end
        Wait(1)
    end
end)

CreateThread(function()
    while true do
        local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))

        for k,v in pairs(field) do
            local x2,y2,z2 = table.unpack(v.coords)
            local dist = GetDistanceBetweenCoords(x,y,z,x2,y2,z2,false)

            if dist <= 3.0 then
                ShowHelp("Plant a seed and become a farmer")
            end
        end

        Wait(1)
    end
end)

RegisterNetEvent('5m_farming:useItem')
AddEventHandler('5m_farming:useItem', function (itemname, label)
    local fieldS = isClosteField()
    local k,d = fieldS.key, fieldS.dist

    if d <= 3.0 then
        TriggerServerEvent('5m_farming:removeItem', itemname)
        startScenario("world_human_gardener_plant")
        Wait(5000)
        ClearPedTasks(GetPlayerPed(-1))
        
        local x,y,z = table.unpack(field[k].coords)
        z = z - 4.5
        
        ESX.Game.SpawnObject('prop_plant_01a', vector3(x,y,z), function(obj)
            FreezeEntityPosition(obj, true)
            table.insert(props, {label = label, item = itemname, state = 0, water = 100, prop = obj})
        end)
        
    else
        ESX.ShowNotification("You are nowhere near a field!")
    end
end)

CreateThread(function()
    while true do
        Wait(1.5 * 1000)

        for key, value in pairs(props) do
            local newState = (value.state + 1)

            if newState <= 150 then
                local x,y,z = table.unpack(GetEntityCoords(value.prop))
                SetEntityCoords(value.prop, x, y, (z + 0.004), 0, 0, 0, false)
                value.state = value.state + 1
            end
        end
    end
end)

CreateThread(function()
    while true do
        Wait(500)

        for key, value in pairs(props) do
            if value.water <= 0.0 then
                table.remove(props)
                ESX.Game.DeleteObject(value.prop)
                ESX.ShowNotification("Your plant ran out of water and it broke!")
            else
                value.water = round(value.water - 0.1, 1)
            end
        end
    end
end)

function isClosteField()
    local ped = GetPlayerPed(-1)
    local coords = GetEntityCoords(ped)
    local x,y,z = table.unpack(coords)
    local temp = {}

    for k,v in pairs(field) do
        local x2,y2,z2 = table.unpack(v.coords)
        local dist = GetDistanceBetweenCoords(x,y,z,x2,y2,z2,false)

        table.insert(temp, {key = k, dist = dist})
    end

    table.sort(temp, function(a,b) return a.dist < b.dist end)
    
    return temp[1]
end

function isClostePlant()
    local ped = GetPlayerPed(-1)
    local coords = GetEntityCoords(ped)
    local x,y,z = table.unpack(coords)
    local temp = {}

    for k,v in pairs(props) do
        local x2,y2,z2 = table.unpack(GetEntityCoords(v.prop))
        local dist = GetDistanceBetweenCoords(x,y,z,x2,y2,z2,false)

        table.insert(temp, {key = k, dist = dist})
    end

    table.sort(temp, function(a,b) return a.dist < b.dist end)
    
    return temp[1]
end

function startAttitude(lib, anim)
	ESX.Streaming.RequestAnimSet(lib, function()
		SetPedMovementClipset(PlayerPedId(), anim, true)
	end)
end

function startAnim(lib, anim)
	ESX.Streaming.RequestAnimDict(lib, function()
		TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
	end)
end

function startScenario(anim)
	TaskStartScenarioInPlace(PlayerPedId(), anim, 0, false)
end

CreateThread(function()
    while true do
        for key, value in pairs(props) do
            local x,y,z = table.unpack(GetEntityCoords(value.prop))

            Draw3DText(x, y, z + 1.400, '[ Seed: ' .. value.label .. ' ]', 4, 0.1, 0.1)
            Draw3DText(x, y, z + 1.600, '[ Grow: ' .. (round((value.state / 150) * 100, 0)) .. '% ]', 4, 0.1, 0.1)
            Draw3DText(x, y, z + 1.800, '[ Water: ' .. value.water .. '% ]', 4, 0.1, 0.1)
        
            if value.state >= 150 then
                Draw3DText(x, y, z + 2.0, '[ Harvest with ~r~[E]~s~ ]', 4, 0.1, 0.1)

                if IsControlJustPressed(0, 38) then
                    ESX.Game.DeleteObject(value.prop)
                    table.remove(props, key)

                    local ernte = math.random(8, 13)
                    TriggerServerEvent('5m_farming:giveItem', value.item, ernte)
                    ESX.ShowNotification(("You have %sx %s harvested"):format(ernte, value.label))
                end
            end
        end

        Wait(1)
    end
end)

function Draw3DText(x,y,z,textInput,fontId,scaleX,scaleY)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)    
    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    SetTextScale(scaleX*scale, scaleY*scale)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextColour(250, 250, 250, 255)
    SetTextDropshadow(1, 1, 1, 1, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

RegisterNetEvent('5m_farming:useKanne')
AddEventHandler('5m_farming:useKanne', function()
    local plantS = isClostePlant()
    local k,d = plantS.key, plantS.dist

    Wait(2500)

    if d <= 3.0 then
        if (props[k].water + 30.0) > 100.0 then
            props[k].water = 100.0
        else
            props[k].water = props[k].water + 30.0
        end
    end
end)

RegisterNetEvent('5m_farming:fillKanne')
AddEventHandler('5m_farming:fillKanne', function()
    if IsEntityInWater(GetPlayerPed(-1)) then
        startScenario("world_human_gardener_plant")
        Wait(5000)
        ClearPedTasks(GetPlayerPed(-1))

        TriggerServerEvent('5m_farming:fillKanne')
    end
end)

local verkauf = vector3(-2508.032, 3613.787, 14.19591)

CreateThread(function()
    while true do
        DrawMarker(21, verkauf, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 255, false, false, 2, 45.0, nil, nil, false)

        local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
        local x2,y2,z2 = table.unpack(verkauf)
        local dist = GetDistanceBetweenCoords(x,y,z,x2,y2,z2, true)

        if dist <= 2.5 then
            ShowHelp("Press ~INPUT_CONTEXT~ to sell crops")

            if IsControlJustPressed(0, 38) then
                TriggerServerEvent('5m_farming:sellItems')
                ESX.ShowNotification("You sold your harvest!")
            end
        end

        Wait(1)
    end
end)