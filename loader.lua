local library = loadstring(game:HttpGet("https://github.com/waxxan2/Pulse/raw/refs/heads/main/SynioxGui%20(3).txt"))()
_G.library = library

local player = game.Players.LocalPlayer
_G.player = player

local displayName = player.DisplayName
_G.displayName = displayName

local repsPerTick = 1

local window = library:AddWindow("Pulse Hub Public | Muscle Legends || Hello - " .. displayName, {
    title_bar = {
        Color3.fromRGB(200, 0, 0),
        Color3.fromRGB(100, 0, 0),
        Color3.fromRGB(0, 0, 0)
    },
    title_bar_transparency = 0.1,
    background = {
        Color3.fromRGB(20, 0, 0),
        Color3.fromRGB(40, 0, 0),
        Color3.fromRGB(0, 0, 0)
    },
    background_transparency = 0.1,
    main_color = Color3.fromRGB(50, 180, 255),
    min_size = Vector2.new(430, 290),
    can_resize = true
})

_G.window = window

local AutoFarm = window:AddTab("Farm")

_G.autoFarmToggle = false
_G.weightToggle = false
_G.pushupsToggle = false
_G.handstandsToggle = false
_G.situpsToggle = false

AutoFarm:AddSwitch("💪 Auto Farm (Equip Any tool)", function(state)
    _G.autoFarmToggle = state
end)

AutoFarm:AddSwitch("🏋️‍♀️ Weight", function(state)
    _G.weightToggle = state
end)

AutoFarm:AddSwitch("💪 Pushups", function(state)
    _G.pushupsToggle = state
end)

AutoFarm:AddSwitch("🔥 Handstands", function(state)
    _G.handstandsToggle = state
end)

AutoFarm:AddSwitch("✨ Situps", function(state)
    _G.situpsToggle = state
end)

task.spawn(function()
    local muscleEvent = player:WaitForChild("muscleEvent")

    while task.wait(0.1) do
        local character = player.Character

        if not character then
            continue
        end

        if _G.autoFarmToggle then
            for i = 1, repsPerTick do
                if not _G.autoFarmToggle then
                    break
                end

                muscleEvent:FireServer("rep")
            end
        end

        if _G.weightToggle then
            local weight = character:FindFirstChild("Weight")
                or player.Backpack:FindFirstChild("Weight")

            if weight then
                if weight.Parent ~= character then
                    weight.Parent = character
                end

                muscleEvent:FireServer("rep")
            end
        end

        if _G.pushupsToggle then
            local pushups = character:FindFirstChild("Pushups")
                or player.Backpack:FindFirstChild("Pushups")

            if pushups then
                if pushups.Parent ~= character then
                    pushups.Parent = character
                end

                muscleEvent:FireServer("rep")
            end
        end

        if _G.handstandsToggle then
            local handstands = character:FindFirstChild("Handstands")
                or player.Backpack:FindFirstChild("Handstands")

            if handstands then
                if handstands.Parent ~= character then
                    handstands.Parent = character
                end

                muscleEvent:FireServer("rep")
            end
        end
                    
        if _G.situpsToggle then
            local situps = character:FindFirstChild("Situps")
                or player.Backpack:FindFirstChild("Situps")

            if situps then
                if situps.Parent ~= character then
                    situps.Parent = character
                end

                muscleEvent:FireServer("rep")
            end
        end
    end
end)

AutoFarm:AddSwitch("👊 Auto Punch", function(state)
    _G.fastHitActive = state
    if state then
        task.spawn(function()
            while _G.fastHitActive do
                local punch = player.Backpack:FindFirstChild("Punch")
                if punch then
                    punch.Parent = player.Character
                    if punch:FindFirstChild("attackTime") then
                        punch.attackTime.Value = 0
                    end
                end
                task.wait(0.1)
            end
        end)
        task.spawn(function()
            while _G.fastHitActive do
                local punch = player.Character and player.Character:FindFirstChild("Punch")
                if punch then
                    punch:Activate()
                end
                task.wait(0.1)
            end
        end)
    else
        local punch = player.Character and player.Character:FindFirstChild("Punch")
        if punch then
            punch.Parent = player.Backpack
        end
    end
end)

local rebirths = window:AddTab("Rebirths")

rebirths:AddTextBox("Rebirth Target", function(text)
    local newValue = tonumber(text)
    if newValue and newValue > 0 then
        targetRebirthValue = newValue
        updateStats() -- Call the stats update function
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Objetivo Actualizado",
            Text = "Nuevo objetivo: " .. tostring(targetRebirthValue) .. " renacimientos",
            Duration = 0
        })
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Size",
            Text = "Put a size larger than 0",
            Duration = 0
        })
    end
end)

local infiniteSwitch

local targetSwitch = rebirths:AddSwitch("Auto Rebirth Target", function(bool)
    _G.targetRebirthActive = bool
    
    if bool then
        if _G.infiniteRebirthActive and infiniteSwitch then
            infiniteSwitch:Set(false)
            _G.infiniteRebirthActive = false
        end
        
        spawn(function()
            while _G.targetRebirthActive and wait(0.1) do
                local currentRebirths = game.Players.LocalPlayer.leaderstats.Rebirths.Value
                
                if currentRebirths >= targetRebirthValue then
                    targetSwitch:Set(false)
                    _G.targetRebirthActive = false
                    
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "ÃƒÆ’Ã†â€™ÃƒÂ¢Ã¢â€šÂ¬Ã…Â¡ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â¡Objetivo Alcanzado!",
                        Text = "Has alcanzado " .. tostring(targetRebirthValue) .. " renacimientos",
                        Duration = 5
                    })
                    
                    break
                end
                
                game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest")
            end
        end)
    end
end, "automatic rebirth until reaching the goal")

infiniteSwitch = rebirths:AddSwitch("Auto Rebirth (Infinitely)", function(bool)
    _G.infiniteRebirthActive = bool
    
    if bool then
        if _G.targetRebirthActive and targetSwitch then
            targetSwitch:Set(false)
            _G.targetRebirthActive = false
        end
        
        spawn(function()
            while _G.infiniteRebirthActive and wait(0.1) do
                game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest")
            end
        end)
    end
end, "rebirth infinitely")

local sizeSwitch = rebirths:AddSwitch("Auto Size 1", function(bool)
    _G.autoSizeActive = bool
    
    if bool then
        spawn(function()
            while _G.autoSizeActive and wait() do
                game:GetService("ReplicatedStorage").rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", 1)
            end
        end)
    end
end, "Size 1")

local teleportSwitch = rebirths:AddSwitch("Auto Teleport to Muscle King", function(bool)
    _G.teleportActive = bool
    
    if bool then
        spawn(function()
            while _G.teleportActive and wait() do
                if game.Players.LocalPlayer.Character then
                    game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-8646, 17, -5738))
                end
            end
        end)
    end
end, "Tp to Mk")

local farmTab = window:AddTab("Rock")
 
local function gettool()
    for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v.Name == "Punch" and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
        end
    end
    game:GetService("Players").LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
    game:GetService("Players").LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
end
 
local tinyIslandRockSwitch = farmTab:AddSwitch("💎 Tiny Rock 0", function(bool)
    selectrock = "Tiny Island Rock"
    getgenv().autoFarm = bool
 
    if bool then
        spawn(function()
            while getgenv().autoFarm do
                task.wait()
                if game:GetService("Players").LocalPlayer.Durability.Value >= 0 then
                    for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                        if v.Name == "neededDurability" and v.Value == 0 and 
                           game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and 
                           game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
 
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
                            gettool()
                        end
                    end
                end
            end
        end)
    end
end)
 
local starterIslandRockSwitch = farmTab:AddSwitch("🔥 Starter Rock 100", function(bool)
    selectrock = "Starter Island Rock"
    getgenv().autoFarm = bool
 
    if bool then
        spawn(function()
            while getgenv().autoFarm do
                task.wait()
                if game:GetService("Players").LocalPlayer.Durability.Value >= 100 then
                    for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                        if v.Name == "neededDurability" and v.Value == 100 and 
                           game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and 
                           game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
 
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
                            gettool()
                        end
                    end
                end
            end
        end)
    end
end)
 
local legendBeachRockSwitch = farmTab:AddSwitch("🏖️ Legends Beach Rock 5k", function(bool)
    selectrock = "Legend Beach Rock"
    getgenv().autoFarm = bool
 
    if bool then
        spawn(function()
            while getgenv().autoFarm do
                task.wait()
                if game:GetService("Players").LocalPlayer.Durability.Value >= 5000 then
                    for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                        if v.Name == "neededDurability" and v.Value == 5000 and 
                           game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and 
                           game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
 
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
                            gettool()
                        end
                    end
                end
            end
        end)
    end
end)
 
local frostGymRockSwitch = farmTab:AddSwitch("❄️ Frozen Rock 150k", function(bool)
    selectrock = "Frost Gym Rock"
    getgenv().autoFarm = bool
 
    if bool then
        spawn(function()
            while getgenv().autoFarm do
                task.wait()
                if game:GetService("Players").LocalPlayer.Durability.Value >= 150000 then
                    for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                        if v.Name == "neededDurability" and v.Value == 150000 and 
                           game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and 
                           game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
 
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
                            gettool()
                        end
                    end
                end
            end
        end)
    end
end)
 
local mythicalGymRockSwitch = farmTab:AddSwitch("👾 Mythical Rock 400k ", function(bool)
    selectrock = "Mythical Gym Rock"
    getgenv().autoFarm = bool
 
    if bool then
        spawn(function()
            while getgenv().autoFarm do
                task.wait()
                if game:GetService("Players").LocalPlayer.Durability.Value >= 400000 then
                    for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                        if v.Name == "neededDurability" and v.Value == 400000 and 
                           game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and 
                           game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
 
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
                            gettool()
                        end
                    end
                end
            end
        end)
    end
end)
 
local eternalGymRockSwitch = farmTab:AddSwitch("🔥 Eternal Rock 750k", function(bool)
    selectrock = "Eternal Gym Rock"
    getgenv().autoFarm = bool
 
    if bool then
        spawn(function()
            while getgenv().autoFarm do
                task.wait()
                if game:GetService("Players").LocalPlayer.Durability.Value >= 750000 then
                    for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                        if v.Name == "neededDurability" and v.Value == 750000 and 
                           game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and 
                           game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
 
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
                            gettool()
                        end
                    end
                end
            end
        end)
    end
end)
 
local legendGymRockSwitch = farmTab:AddSwitch("🏆 Legends Rock 1m", function(bool)
    selectrock = "Legend Gym Rock"
    getgenv().autoFarm = bool
 
    if bool then
        spawn(function()
            while getgenv().autoFarm do
                task.wait()
                if game:GetService("Players").LocalPlayer.Durability.Value >= 1000000 then
                    for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                        if v.Name == "neededDurability" and v.Value == 1000000 and 
                           game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and 
                           game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
 
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
                            gettool()
                        end
                    end
                end
            end
        end)
    end
end)
 
local muscleKingGymRockSwitch = farmTab:AddSwitch("👑 Muscle King Rock 5m", function(bool)
    selectrock = "Muscle King Gym Rock"
    getgenv().autoFarm = bool
 
    if bool then
        spawn(function()
            while getgenv().autoFarm do
                task.wait()
                if game:GetService("Players").LocalPlayer.Durability.Value >= 5000000 then
                    for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                        if v.Name == "neededDurability" and v.Value == 5000000 and 
                           game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and 
                           game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
 
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
                            gettool()
                        end
                    end
                end
            end
        end)
    end
end)
 
local ancientJungleRockSwitch = farmTab:AddSwitch("🌴 Jungle Rock 10m", function(bool)
    selectrock = "Ancient Jungle Rock"
    getgenv().autoFarm = bool
 
    if bool then
        spawn(function()
            while getgenv().autoFarm do
                task.wait()
                if game:GetService("Players").LocalPlayer.Durability.Value >= 10000000 then
                    for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                        if v.Name == "neededDurability" and v.Value == 10000000 and 
                           game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and 
                           game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
 
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
                            gettool()
                        end
                    end
                end
            end
        end)
    end
end)

local ancientIndustrialRockSwitch = farmTab:AddSwitch("⚙️ Industrial Jungle Rock 25m", function(bool)
    selectrock = "Industrial Jungle Rock"
    getgenv().autoFarm = bool
 
    if bool then
        spawn(function()
            while getgenv().autoFarm do
                task.wait()
                if game:GetService("Players").LocalPlayer.Durability.Value >= 25000000 then
                    for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                        if v.Name == "neededDurability" and v.Value == 25000000 and 
                           game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and 
                           game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
 
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
                            gettool()
                        end
                    end
                end
            end
        end)
    end
end)

