local QBCore = exports['qb-core']:GetCoreObject()

local identifier = "rk_linkedin"

CreateThread(function ()
    while GetResourceState("lb-phone") ~= "started" do
        Wait(500)
    end

    local function AddApp()
        local added, errorMessage = exports["lb-phone"]:AddCustomApp({
            identifier = identifier,
            name = "LinkedIn",
            description = "Connect with your business partners",
            developer = "LinkedIn, Inc.",
            defaultApp = false, -- OPTIONAL if set to true, app should be added without having to download it,
            size = 59812, -- OPTIONAL in kb
            --price = 999999, -- OPTIONAL, Make players pay with in-game money to download the app
            images = {}, -- OPTIONAL array of images for the app on the app store
            ui = GetCurrentResourceName() .. "/ui/index.html", -- this is the path to the HTML file, can also be a URL
            icon = "https://cfx-nui-" .. GetCurrentResourceName() .. "/ui/assets/icon.png"
        })

        if not added then
            print("Could not add app:", errorMessage)
        end
    end

    AddApp()

    AddEventHandler("onResourceStart", function(resource)
        if resource == "lb-phone" then
            AddApp()
        end
    end)
end)

RegisterNUICallback('getLinkedInData', function(data, cb)
    QBCore.Functions.TriggerCallback('lb-businessapp:getEmployees', function(employees)
        cb(employees)
    end)
end)

RegisterNUICallback('addLinkedInToContact', function(data, cb)
    TriggerServerEvent('lb-businessapp:saveContact', data)
    cb('ok')
end)