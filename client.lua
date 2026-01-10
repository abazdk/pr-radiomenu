local currentAnimation = "default"
local radioClicksEnabled = true

Citizen.CreateThread(function()
    local saved = GetResourceKvpString("abaz-radio_clicks")
    if saved ~= nil then
        radioClicksEnabled = (saved == "true")
    else
        radioClicksEnabled = true
    end
    exports["pma-voice"]:setVoiceProperty('micClicks', radioClicksEnabled)
    
    local savedAnim = GetResourceKvpString("abaz-radio_animation")
    if savedAnim ~= nil then
        currentAnimation = savedAnim
    else
        currentAnimation = "default"
    end
end)

local function getCheckmark(isSelected)
    return isSelected and '✓ ' or ''
end

local function openRadioMenu()
    lib.registerContext({
        id = 'radio_menu',
        title = 'Radio Animation Menu',
        options = {
            {
                title = getCheckmark(currentAnimation == 'crossed_arms') .. 'Crossed Arms',
                description = 'Vælg Crossed Arms animation',
                icon = 'hands',
                onSelect = function()
                    currentAnimation = 'crossed_arms'
                    SetResourceKvp("abaz-radio_animation", currentAnimation)
                    TriggerEvent('changeradioanim', currentAnimation)
                    lib.notify({
                        title = 'Radio Animation',
                        description = 'Crossed arms animation valgt!',
                        type = 'success'
                    })
                    openRadioMenu()
                end
            },
            {
                title = getCheckmark(currentAnimation == 'leanover') .. 'Leanover',
                description = 'Vælg Leanover animation',
                icon = 'person',
                onSelect = function()
                    currentAnimation = 'leanover'
                    SetResourceKvp("abaz-radio_animation", currentAnimation)
                    TriggerEvent('changeradioanim', currentAnimation)
                    lib.notify({
                        title = 'Radio Animation',
                        description = 'Leanover animation valgt!',
                        type = 'success'
                    })
                    openRadioMenu()
                end
            },
            {
                title = getCheckmark(currentAnimation == 'closeup') .. 'Closeup',
                description = 'Vælg Closeup animation',
                icon = 'magnifying-glass',
                onSelect = function()
                    currentAnimation = 'closeup'
                    SetResourceKvp("abaz-radio_animation", currentAnimation)
                    TriggerEvent('changeradioanim', currentAnimation)
                    lib.notify({
                        title = 'Radio Animation',
                        description = 'Closeup animation valgt!',
                        type = 'success'
                    })
                    openRadioMenu()
                end
            },
            {
                title = getCheckmark(currentAnimation == 'default') .. 'Default',
                description = 'Vælg Default animation',
                icon = 'rotate-left',
                onSelect = function()
                    currentAnimation = 'default'
                    SetResourceKvp("abaz-radio_animation", currentAnimation)
                    TriggerEvent('changeradioanim', currentAnimation)
                    lib.notify({
                        title = 'Radio Animation',
                        description = 'Default animation valgt!',
                        type = 'success'
                    })
                    openRadioMenu()
                end
            },
            {
                title = (radioClicksEnabled and '✓ ' or '✗ ') .. 'Radio Clicks',
                description = radioClicksEnabled and 'Radio clicks er aktiveret (klik for at deaktivere)' or 'Radio clicks er deaktiveret (klik for at aktivere)',
                icon = radioClicksEnabled and 'volume-high' or 'volume-xmark',
                onSelect = function()
                    radioClicksEnabled = not radioClicksEnabled
                    exports["pma-voice"]:setVoiceProperty('micClicks', radioClicksEnabled)
                    SetResourceKvp("abaz-radio_clicks", radioClicksEnabled and "true" or "false")
                    lib.notify({
                        title = 'Radio Clicks',
                        description = radioClicksEnabled and 'Radio clicks aktiveret!' or 'Radio clicks deaktiveret!',
                        type = 'success'
                    })
                    openRadioMenu() 
                end
            }
        }
    })
    
    lib.showContext('radio_menu')
end

RegisterCommand('radiomenu', function()
    openRadioMenu()
end, false)
