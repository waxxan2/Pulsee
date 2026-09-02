
local library = loadstring(game:HttpGet("https://github.com/waxxan2/Pulse/raw/refs/heads/main/SynioxGui%20(3).txt"))()
_G.library = library 

local player = game.Players.LocalPlayer
_G.player = player 

local displayName = player.DisplayName
_G.displayName = displayName 

local repsPerTick = 1 

local window = library:AddWindow("Pulse Hub Public | Muscle Legends || Hello - ".. displayName, {
    title_bar = {
        Color3.fromRGB(200, 0, 0),     -- Canlı Kırmızı
        Color3.fromRGB(100, 0, 0),     -- Koyu Kırmızı
        Color3.fromRGB(0, 0, 0)        -- Siyah
    }, 
    title_bar_transparency = 0.1, 
    background = {
        Color3.fromRGB(20, 0, 0),      -- Çok Koyu Kırmızı Arkaplan
        Color3.fromRGB(40, 0, 0),      -- Biraz daha açık Koyu Kırmızı
        Color3.fromRGB(0, 0, 0)        -- Siyah
    }, 
    background_transparency = 0.1, 
    main_color = Color3.fromRGB(180, 0, 0), -- Ana Vurgu Rengi (Kırmızı)
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
            task.wait(0.1)
        end
    end)
end)
-- Oyuncu ve servisleri tanımla
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local vim = game:GetService("VirtualInputManager")

-- Otomatik Weight Kuşanma ve Rep Fonksiyonu
local function autoMuscle()
    -- Sürekli çalışması için döngü
    while task.wait(0.1) do
        pcall(function()
            -- 1. En iyi ağırlığı bul ve kuşan
            local backpack = player:FindFirstChild("Backpack")
            local char = player.Character
            
            if backpack and char then
                -- Önce elinde ağırlık var mı bak, yoksa en iyisini bul
                local currentWeight = char:FindFirstChildOfClass("Tool")
                if not currentWeight or not currentWeight.Name:lower():find("weight") then
                    -- En yüksek değere sahip ağırlığı çanta veya envanterde ara
                    local bestWeight = nil
                    
                    for _, item in ipairs(backpack:GetChildren()) do
                        if item:IsA("Tool") and item.Name:lower():find("weight") then
                            bestWeight = item
                            break -- En basit mantıkla ilk bulduğu veya envanterdeki ağırlığı alır
                        end
                    end
                    
                    if bestWeight then
                        char.Humanoid:EquipTool(bestWeight)
                    end
                end
            end
            
            -- 2. Otomatik Rep Kaldırma (Tıklama simülasyonu)
            -- Oyuncunun gücüne/rep değerine göre otomatik tetiklenir
            vim:SendMouseButtonEvent(0, 0, 0, true, game, 0)
            task.wait(0.01)
            vim:SendMouseButtonEvent(0, 0, 0, false, game, 0)
        end)
    end
end

-- Scripti başlat
task.spawn(autoMuscle)
print("Muscles Legends Auto-Weight & Lift aktif!")
