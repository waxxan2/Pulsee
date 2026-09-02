local library = loadstring(game:HttpGet("https://github.com/waxxan2/Pulse/raw/refs/heads/main/SynioxGui%20(3).txt"))()
_G.library = library 

local player = game.Players.LocalPlayer
_G.player = player 

local displayName = player.DisplayName
_G.displayName = displayName 

local repsPerTick = 1 

local window = library:AddWindow("Pulse Hub Public | Muscle Legends || Hello - ".. displayName, {
    title_bar = {
        Color3.fromRGB(200, 0, 0),
        Color3.fromRGB(100, 0, 0),
        Color3.fromRGB(0, 0, 0)
    },
    title_bar_transparency = 0.1,
    background = {
        Color3.fromRGB(20,0, 0),
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

AutoFarm:AddSwitch("💪 Auto Farm (Equip Any tool)", function(state)
    _G.autoFarmToggle = state
end)

AutoFarm:AddSwitch(" weight ", function(state)
    _G.weightToggle = state
end)

task.spawn(function()
    local muscleEvent = player:WaitForChild("muscleEvent")

    while task.wait(0.1) do
        if _G.autoFarmToggle then
            for i = 1, repsPerTick do
                if not _G.autoFarmToggle then break end
                muscleEvent:FireServer("rep")
            end
        end

        if _G.weightToggle then
            local character = player.Character
            if character then
                local weight = player.Backpack:FindFirstChild("Pushups") or character:FindFirstChild("Weight")
                if weight then
                    if weight.Parent ~= character then
                        weight.Parent = character
                    end
                    muscleEvent:FireServer("rep")
                end
            end
        end
    end
end)
_G.repToggle = false

AutoFarm:AddSwitch(" Pushups ", function(state)
    _G.repToggle = state
end)

task.spawn(function()
    local player = game:GetService("Players").LocalPlayer
    local muscleEvent = player:WaitForChild("muscleEvent")

    while task.wait(0.1) do
        if _G.repToggle then
            local character = player.Character
            if character then
                local pushups = player.Backpack:FindFirstChild("Pushups") or character:FindFirstChild("Pushups")
                
                if weight then
                    if pushups.Parent ~= character then
                        pushups.Parent = character
                    end
                    
                    muscleEvent:FireServer("rep")
                end
            end
        end
    end
end)
