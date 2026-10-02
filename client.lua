local ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    for _, location in ipairs(Config.TowerLocations) do
        local blip = AddBlipForCoord(location.x, location.y, location.z)
        SetBlipSprite(blip, 1)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 1.0)
        SetBlipColour(blip, 3)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Tower Hack")
        EndTextCommandSetBlipName(blip)
    end
end)

RegisterNetEvent('towerhack:startHack')
AddEventHandler('towerhack:startHack', function(towerId)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local towerCoords = Config.TowerLocations[towerId]

    if #(playerCoords - vector3(towerCoords.x, towerCoords.y, towerCoords.z)) < 2.0 then
        ESX.TriggerServerCallback('towerhack:attemptHack', function(success)
            if success then
                ESX.ShowNotification('Hack successful!')
            else
                ESX.ShowNotification('Hack failed!')
            end
        end, towerId)
    else
        ESX.ShowNotification('You are not near the tower!')
    end
end)