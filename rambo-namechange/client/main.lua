local QBCore = exports['qb-core']:GetCoreObject()

exports['qb-target']:AddCircleZone("namechange", vector3(-549.01, -191.42, 38.1), 1.0, {
    name="namechange",
    useZ=true,
    debugPoly=false,
    minZ=29.0,
    maxZ=31.0
}, {
    options = {
        {
            event = "rambo-namechange:client:openMenu",
            icon = "fas fa-user-edit",
            label = "Change Name",
        },
    },
    distance = 1.5
})

RegisterNetEvent('rambo-namechange:client:openMenu', function()
    local citizenId = QBCore.Functions.GetPlayerData().citizenid
    local input = lib.inputDialog('Name Change', {'First Name', 'Last Name'})
    if not input then return end
    local firstname = input[1]
    local lastname = input[2]
    if firstname and lastname and citizenId then
        local alert = lib.alertDialog({
            header = 'You will disconnect after changing your name!',
            content = 'Are you sure?',
            centered = true,
            cancel = true
        })
        if alert == 'confirm' then
            TriggerServerEvent('rambo-namechange:server:changeName', firstname, lastname, citizenId)
        else
            QBCore.Functions.Notify('Cancelled!', 'error', 7500)
        end
    end
end)