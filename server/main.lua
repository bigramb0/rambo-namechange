RegisterNetEvent('rambo-namechange:server:changeName', function(firstname, lastname, citizenID)
    local src = source
    local result = MySQL.scalar.await('SELECT charinfo FROM players WHERE citizenid = ?', { citizenID })
    if result then
        DropPlayer(src, 'You have changed your name. Please reconnect to the server.')
        local charinfo = json.decode(result)
        charinfo.firstname = firstname
        charinfo.lastname = lastname
        local updated = json.encode(charinfo)
        MySQL.update('UPDATE players SET charinfo = ? WHERE citizenid = ?', { updated, citizenID })
    else
        TriggerClientEvent('QBCore:Notify', source, 'Something went wrong, please try again later.', 'error', 7500)
    end
end)