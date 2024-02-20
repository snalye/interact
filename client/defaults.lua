if GetConvar('interact_disabledefault', 'false') == 'true' then
    return
end

local api = require 'client.interactions'



api.addGlobalVehicleInteraction({
    distance = 5.0,
    interactDst = 1.5,
    offset = vec3(0.0, 1.0, 0.0),
    bone = 'boot',
    options = {
        name = 'interact:trunk',
        label = 'Trunk',
        action = function(entity)
            if GetVehicleDoorLockStatus(entity) ~= 1 then
                return lib.notify({ type = 'error', title = 'The trunk is locked.' })
            end

            if GetVehicleDoorAngleRatio(entity, 5) <= 0.0  then
                return lib.notify({ type = 'error', title = 'the trunk is not open' })
            end

            local plate = GetVehicleNumberPlateText(entity)
            local invId = 'trunk'..plate
            local coords = GetEntityCoords(entity)

            TaskTurnPedToFaceCoord(cache.ped, coords.x, coords.y, coords.z, 0)

            if not exports.ox_inventory:openInventory('trunk', { id = invId, netid = NetworkGetNetworkIdFromEntity(entity), entityid = entity, door = 5 }) then return end
        end,
    }

})

--[[local dumpsters = {218085040, 666561306, -58485588, -206690185, 1511880420, 682791951}

-- Test code for models

for i = 1, #dumpsters do
    api.addModelInteraction({
        model = dumpsters[i],
        distance = 30.0,
        interactDst = 2,
        offset = vec3(0.0, -0.5, 1.0),
        options = {
            name = 'interact:trunk',
            label = 'Search Dumpster',
            distance = 20,
            action = function()
                print("works just fine")
            end
        }
    })
end]]