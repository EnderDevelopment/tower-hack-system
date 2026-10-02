local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('towerhack:attemptHack', function(source, cb, towerId)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getInventoryItem(Config.TowerHack.RequiredItem).count > 0 then
        local success = math.random(1, 100) <= Config.TowerHack.SuccessChance

        if success then
            xPlayer.addAccountMoney('bank', Config.TowerHack.Reward)
            MySQL.Async.execute('INSERT INTO tower_hacks (player_id, tower_id, hack_time, success) VALUES (@player_id, @tower_id, NOW(), @success)', {
                ['@player_id'] = xPlayer.identifier,
                ['@tower_id'] = towerId,
                ['@success'] = success
            })
        end

        cb(success)
    else
        xPlayer.showNotification('You need a hacking device to start the hack!')
        cb(false)
    end
end)