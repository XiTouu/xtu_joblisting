ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)

------------ Création du Menu / Sous Menu -----------

RMenu.Add('example', 'main', RageUI.CreateMenu("Pôle Emplois", "Tous les métiers disponible en ville"))
RMenu.Add('example', 'nonwl', RageUI.CreateSubMenu(RMenu:Get('example', 'main'), "Métiers Public", "Métiers sans candidature"))
RMenu.Add('example', 'wl', RageUI.CreateSubMenu(RMenu:Get('example', 'main'), "Métiers WL", "Métiers sous candidature"))

local metierFree = {
    {value = 'slaughterer', label = 'Abatteur'},
    {value = 'miner', label = 'Mineur'},
    {value = 'fueler', label = 'Raffineur'},
    {value = 'lumberjack', label = 'Bûcherons'}
}

local metierWL = {
    {label = 'Policier'},
    {label = 'Ambulancier'},
    {label = 'Concessionaire Voiture'},
    {label = 'Mécanos'},
    {label = 'Concessionaire Moto'}
}

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('example', 'main'), true, true, true, function()

            RageUI.Button("Métiers Public", "Métiers sans candidature", {RightLabel = "→→→"},true, function()
            end, RMenu:Get('example', 'nonwl'))

            RageUI.Button("Métiers WL", "Métiers sous candidature", {RightLabel = "→→→"},true, function()
            end, RMenu:Get('example', 'wl'))

            RageUI.Button("~r~Démissioner", "Démissioner de votre métier", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('xtujob:SetJobUnemployed')
                end
            end)
        end, function()
        end)

        RageUI.IsVisible(RMenu:Get('example', 'nonwl'), true, true, true, function()

            for k, v in pairs(metierFree) do 
                RageUI.Button(v.label, "Vous voulez devenir ~r~".. v.label .. " ~w~?", {RightLabel = "→ ~b~Choisir"}, true, function(Hovered, Active, Selected)
                    

                    if Selected then
                        local jobname = v.label 

                        TriggerServerEvent('xtujob:setjob', v, count)
                    end
                end)
           end
        end, function()
        end)

            RageUI.IsVisible(RMenu:Get('example', 'wl'), true, true, true, function()

                for k, v in pairs(metierWL) do 
                    RageUI.Button(v.label, "Vous voulez devenir ~r~".. v.label .. " ~w~?", {RightLabel = "→ ~b~Choisir"}, true, function(Hovered, Active, Selected)
                        
    
                        if Selected then
                            local job = v.value
                            local jobname = v.label 
    
                            TriggerServerEvent('xtujob:WlNotification')
                        end
                    end)
               end          
            end, function()
                ---Panels
            end, 1)
    
            Citizen.Wait(0)
        end
    end)



    ---------------------------------------- Position du Menu --------------------------------------------

    local position = {
        {x = -268.46 , y = -957.07, z = 31.22, angle = 202.04}
    }
    
    local peds = {
        {x = -268.46 , y = -957.07, z = 30.22, angle = 202.04}
    }
    
    
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
    
            for k in pairs(position) do
    
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
    
                if dist <= 1.0 then

                   RageUI.Text({
                        message = "Appuyez sur [~b~E~w~] pour acceder au ~b~Pôle Emplois",
                        time_display = 1
                    })
                   -- ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour acceder au ~b~Shop")
                    if IsControlJustPressed(1,51) then
                        RageUI.Visible(RMenu:Get('example', 'main'), not RageUI.Visible(RMenu:Get('example', 'main')))
                    end
                end
            end
        end
    end)

    -- Blips

    Citizen.CreateThread(function()
        for _, info in pairs(position) do
            info.blip = AddBlipForCoord(info.x, info.y, info.z)
            SetBlipSprite(info.blip, 407)
            SetBlipDisplay(info.blip, 4)
            SetBlipScale(info.blip, 1.2)
            SetBlipColour(info.blip, 7)
            SetBlipAsShortRange(info.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Pôle Emplois")
            EndTextCommandSetBlipName(info.blip)
        end
    end)

    -- Ped

    Citizen.CreateThread(function()
        for k in pairs(peds) do
    
                local hash = GetHashKey("cs_bankman")
                while not HasModelLoaded(hash) do
                    RequestModel(hash)
                    Wait(20)
                end
    
                ped = CreatePed("PED_TYPE_CIVMALE", "cs_bankman", peds[k].x, peds[k].y, peds[k].z, peds[k].angle, false, true)
                SetBlockingOfNonTemporaryEvents(ped, true)
                SetEntityInvincible(ped, true)
                FreezeEntityPosition(ped, true)
        end
    end)
