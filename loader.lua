local library = loadstring(game:HttpGet("https://github.com/waxxan2/Pulse-/raw/refs/heads/main/Gui.lua.txt"))()
_G.library = library 

local player = game.Players.LocalPlayer
_G.player = player 

local displayName = player.DisplayName
_G.displayName = displayName 

local repsPerTick = 1 

local window = library:AddWindow("Pulse Hub private | Muscle Legends || HI - ".. displayName, {
    title_bar = {
        Color3.fromRGB(180, 0, 255),
        Color3.fromRGB(60, 0, 100),
        Color3.fromRGB(0, 0, 0)
    }, 
    title_bar_transparency = 0.1, 
    background = {
        Color3.fromRGB(10, 5, 15),
        Color3.fromRGB(15, 10, 25),
        Color3.fromRGB(0, 0, 0)
    }, 
    background_transparency = 0.1, 
    main_color = Color3.fromRGB(104, 34, 139),
    min_size = Vector2.new(430, 290), 
    can_resize = true 
})
_G.window = window

local AutoFarm = window:AddTab("Farm")

_G.repToggle = false
AutoFarm:AddSwitch("💪 Auto Farm (Equip Any tool)", function(state)
    _G.repToggle = state
    task.spawn(function()
        while _G.repToggle do
            local event = game:GetService("Players").LocalPlayer:FindFirstChild("muscleEvent")
            if event then
                for i = 1, repsPerTick do
                    if not _G.repToggle then break end
                    event:FireServer("rep")
                end
            end
            task.wait(0.01)
        end
    end)
end)
