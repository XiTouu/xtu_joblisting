ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}

RegisterNetEvent('xtujob:SetJobUnemployed')
AddEventHandler('xtujob:SetJobUnemployed', function(job)

    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
    xPlayer.setJob("unemployed", 0)	
    TriggerClientEvent("esx:showAdvancedNotification", source,'Pôle Emplois', 'Nouveaux Métier', 'Vous etes maintenant ~b~Chomeur', 'CHAR_DAVE', 1)
end)

-- Job Pole emplois

RegisterNetEvent('xtujob:setjob')
AddEventHandler('xtujob:setjob', function(job)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    xPlayer.setJob(job.value, 0)
    TriggerClientEvent("esx:showAdvancedNotification", source,'Pôle Emplois', 'Nouveaux Métier', 'Vous etes maintenant ~b~'.. job.label .. "!", 'CHAR_DAVE', 1)

end)

--Job WL

RegisterNetEvent('xtujob:WlNotification')
AddEventHandler('xtujob:WlNotification', function()
    TriggerClientEvent("esx:showAdvancedNotification", source,'Pôle Emplois', 'Candidature', 'Veuillez vous rendre sur le discord pour postuler : ~g~discord.gg/rPP6hX', 'CHAR_DAVE', 1)
end)