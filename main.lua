-- [[ BoDcChii VD Helper v2.6 - Perfect Gen & Heal Fix 😈 ]] --

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BoDcChii_Main"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- 1. FLOATING ICON
local OpenIcon = Instance.new("TextButton")
OpenIcon.Parent = ScreenGui
OpenIcon.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
OpenIcon.Position = UDim2.new(0, 10, 0.4, 0)
OpenIcon.Size = UDim2.new(0, 45, 0, 45)
OpenIcon.Text = "BD"
OpenIcon.TextColor3 = Color3.new(1, 1, 1)
OpenIcon.Font = Enum.Font.SourceSansBold
OpenIcon.Draggable = true
local IconCorner = Instance.new("UICorner")
IconCorner.CornerRadius = UDim.new(1, 0)
IconCorner.Parent = OpenIcon

-- 2. MAIN FRAME
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Position = UDim2.new(0.5, -110, 0.3, 0)
MainFrame.Size = UDim2.new(0, 220, 0, 250) -- Tinggi ditambah dikit buat tombol Heal
MainFrame.Visible = false
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

OpenIcon.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- 3. SIDEBAR & PAGES
local Sidebar = Instance.new("Frame")
Sidebar.Parent = MainFrame
Sidebar.Size = UDim2.new(0, 50, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local PageContainer = Instance.new("Frame")
PageContainer.Parent = MainFrame
PageContainer.Position = UDim2.new(0, 55, 0, 5)
PageContainer.Size = UDim2.new(1, -60, 1, -10)
PageContainer.BackgroundTransparency = 1

local function CreatePage(name, visible)
    local Page = Instance.new("ScrollingFrame")
    Page.Name = name; Page.Parent = PageContainer; Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1; Page.ScrollBarThickness = 2; Page.Visible = visible
    local Layout = Instance.new("UIListLayout")
    Layout.Parent = Page; Layout.Padding = UDim.new(0, 5)
    return Page
end

local SurPage = CreatePage("SUR", true)
local KlrPage = CreatePage("KLR", false)
local EspPage = CreatePage("ESP", false)

-- --- FUNGSI TOGGLE ---
local function CreateToggleButton(parent, text, offColor, callback)
    local IsActive = false
    local Btn = Instance.new("TextButton")
    Btn.Parent = parent
    Btn.Size = UDim2.new(1, -5, 0, 35)
    Btn.BackgroundColor3 = offColor
    Btn.Text = text .. ": OFF"
    Btn.TextColor3 = Color3.new(1, 1, 1)
    Btn.Font = Enum.Font.SourceSansBold
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = Btn
    
    Btn.MouseButton1Click:Connect(function()
        IsActive = not IsActive
        Btn.BackgroundColor3 = IsActive and Color3.fromRGB(0, 200, 100) or offColor
        Btn.Text = IsActive and text .. ": ON" or text .. ": OFF"
        callback(IsActive)
    end)
    return Btn
end

-- --- CORE FUNCTIONS ---

-- 1. FUNGSI AUTO PERFECT (GEN & HEAL)
local function AutoSkillCheck(state)
    _G.AutoSkillActive = state
    task.spawn(function()
        while _G.AutoSkillActive do
            task.wait()
            local PlayerGui = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
            if PlayerGui then
                -- Mencari elemen SkillCheck di UI
                for _, v in pairs(PlayerGui:GetDescendants()) do
                    -- Deteksi SkillCheck (Mencari zona sukses/jarum)
                    if v.Name:find("SkillCheck") or v.Name:find("SuccessZone") or v.Name:find("PerfectZone") then
                        if v.Visible == true or v.BackgroundTransparency < 1 then
                            game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.Space, false, game)
                            task.wait(0.05)
                            game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.Space, false, game)
                            task.wait(0.3) -- Delay agar tidak spam input
                        end
                    end
                end
            end
        end
    end)
end

-- 2. Fungsi ESP Player
local function PlayerESP(state, targetType, color)
    if state then
        _G.PlayerLoop = game:GetService("RunService").RenderStepped:Connect(function()
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= game.Players.LocalPlayer and p.Character then
                    local isKiller = false
                    if p.Team and (p.Team.Name:lower():find("killer") or p.Team.Name:lower():find("slasher")) then isKiller = true end
                    if (targetType == 1 and isKiller) or (targetType == 2 and not isKiller) then
                        local hi = p.Character:FindFirstChild("BD_PlayerESP") or Instance.new("Highlight")
                        hi.Name = "BD_PlayerESP"
                        hi.Parent = p.Character
                        hi.FillColor = color
                        hi.FillTransparency = 0.4
                    else
                        if p.Character:FindFirstChild("BD_PlayerESP") then p.Character.BD_PlayerESP:Destroy() end
                    end
                end
            end
        end)
    else
        if _G.PlayerLoop then _G.PlayerLoop:Disconnect() end
        for _, p in pairs(game.Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("BD_PlayerESP") then p.Character.BD_PlayerESP:Destroy() end
        end
    end
end

-- 3. Fungsi ESP Objek
local function ObjectESP(state, nameKey, color)
    if state then
        for _, v in pairs(workspace:GetDescendants()) do
            if v.Name:find(nameKey) or (v.Parent and v.Parent.Name:find(nameKey)) then
                if not v:FindFirstChild("BD_ObjESP") then
                    local hi = Instance.new("Highlight")
                    hi.Name = "BD_ObjESP"; hi.Parent = v; hi.FillColor = color; hi.FillTransparency = 0.5
                end
            end
        end
    else
        for _, v in pairs(workspace:GetDescendants()) do
            if v:FindFirstChild("BD_ObjESP") then v.BD_ObjESP:Destroy() end
        end
    end
end

-- --- TOMBOL-TOMBOL ---
-- TAB SURVIVAL
CreateToggleButton(SurPage, "Perfect Gen", Color3.fromRGB(200, 50, 50), function(s)
    AutoSkillCheck(s)
end)
CreateToggleButton(SurPage, "Perfect Heal", Color3.fromRGB(200, 50, 50), function(s)
    AutoSkillCheck(s) -- Menggunakan logika yang sama karena UI-nya mirip
end)
CreateToggleButton(SurPage, "ESP Killer", Color3.fromRGB(200, 50, 50), function(s)
    PlayerESP(s, 1, Color3.fromRGB(255, 0, 0))
end)

-- TAB KILLER
CreateToggleButton(KlrPage, "ESP Survival", Color3.fromRGB(200, 50, 50), function(s)
    PlayerESP(s, 2, Color3.fromRGB(0, 255, 0))
end)

-- TAB ESP
CreateToggleButton(EspPage, "Full Bright", Color3.fromRGB(200, 50, 50), function(s)
    game:GetService("Lighting").Brightness = s and 2 or 1
    game:GetService("Lighting").GlobalShadows = not s
end)
CreateToggleButton(EspPage, "ESP Gen", Color3.fromRGB(200, 50, 50), function(s)
    ObjectESP(s, "Generator", Color3.new(1, 1, 0))
end)
CreateToggleButton(EspPage, "ESP Pallet", Color3.fromRGB(200, 50, 50), function(s)
    ObjectESP(s, "Pallet", Color3.new(1, 1, 0))
end)
CreateToggleButton(EspPage, "ESP Gate", Color3.fromRGB(200, 50, 50), function(s)
    ObjectESP(s, "Gate", Color3.new(1, 1, 0))
end)

-- --- NAVIGASI ---
local function CreateTabBtn(pos, text, page)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Parent = Sidebar; TabBtn.Position = pos; TabBtn.Size = UDim2.new(1, 0, 0, 45)
    TabBtn.Text = text; TabBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    TabBtn.TextColor3 = Color3.new(1, 1, 1); TabBtn.Font = Enum.Font.SourceSansBold
    TabBtn.MouseButton1Click:Connect(function()
        SurPage.Visible = false; KlrPage.Visible = false; EspPage.Visible = false; page.Visible = true
    end)
end
CreateTabBtn(UDim2.new(0,0,0,5), "SUR", SurPage)
CreateTabBtn(UDim2.new(0,0,0,50), "KLR", KlrPage)
CreateTabBtn(UDim2.new(0,0,0,95), "ESP", EspPage)