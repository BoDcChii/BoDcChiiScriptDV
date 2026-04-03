-- [[ BoDcChii VD Helper v3.4 - Deep Isolation Fix 😈 ]] --

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BoDcChii_Isolated"
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
MainFrame.Size = UDim2.new(0, 220, 0, 250)
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
    Btn.Parent = parent; Btn.Size = UDim2.new(1, -5, 0, 35); Btn.BackgroundColor3 = offColor
    Btn.Text = text .. ": OFF"; Btn.TextColor3 = Color3.new(1, 1, 1); Btn.Font = Enum.Font.SourceSansBold
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6); btnCorner.Parent = Btn
    Btn.MouseButton1Click:Connect(function()
        IsActive = not IsActive
        Btn.BackgroundColor3 = IsActive and Color3.fromRGB(0, 200, 100) or offColor
        Btn.Text = IsActive and text .. ": ON" or text .. ": OFF"
        callback(IsActive)
    end)
    return Btn
end

-- --- CORE ENGINE (ISOLATED MODE) ---

-- A. SISTEM KILLER (MERAH)
local function KillerESP(state)
    _G.KillerActive = state
    if state then
        task.spawn(function()
            while _G.KillerActive do
                task.wait(0.5)
                for _, p in pairs(game.Players:GetPlayers()) do
                    if p ~= game.Players.LocalPlayer and p.Character then
                        -- Deteksi Killer berdasarkan Tim atau Senjata
                        local isK = (p.Team and p.Team.Name:lower():find("killer")) or p.Character:FindFirstChild("Knife") or p.Character:FindFirstChild("Weapon")
                        
                        if isK then
                            local hi = p.Character:FindFirstChild("BD_Killer_ESP") or Instance.new("Highlight")
                            hi.Name = "BD_Killer_ESP"
                            hi.Parent = p.Character
                            hi.FillColor = Color3.fromRGB(255, 0, 0) -- MERAH MATI
                            hi.OutlineColor = Color3.new(1,1,1)
                            hi.FillTransparency = 0.4
                        else
                            if p.Character:FindFirstChild("BD_Killer_ESP") then p.Character.BD_Killer_ESP:Destroy() end
                        end
                    end
                end
            end
        end)
    else
        for _, p in pairs(game.Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("BD_Killer_ESP") then p.Character.BD_Killer_ESP:Destroy() end
        end
    end
end

-- B. SISTEM SURVIVOR (HIJAU)
local function SurvivalESP(state)
    _G.SurviActive = state
    if state then
        task.spawn(function()
            while _G.SurviActive do
                task.wait(0.5)
                for _, p in pairs(game.Players:GetPlayers()) do
                    if p ~= game.Players.LocalPlayer and p.Character then
                        -- Deteksi Survivor (Bukan Killer)
                        local isK = (p.Team and p.Team.Name:lower():find("killer")) or p.Character:FindFirstChild("Knife") or p.Character:FindFirstChild("Weapon")
                        
                        if not isK then
                            local hi = p.Character:FindFirstChild("BD_Survi_ESP") or Instance.new("Highlight")
                            hi.Name = "BD_Survi_ESP"
                            hi.Parent = p.Character
                            hi.FillColor = Color3.fromRGB(0, 255, 0) -- HIJAU MATI
                            hi.OutlineColor = Color3.new(1,1,1)
                            hi.FillTransparency = 0.4
                        else
                            if p.Character:FindFirstChild("BD_Survi_ESP") then p.Character.BD_Survi_ESP:Destroy() end
                        end
                    end
                end
            end
        end)
    else
        for _, p in pairs(game.Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("BD_Survi_ESP") then p.Character.BD_Survi_ESP:Destroy() end
        end
    end
end

-- C. SISTEM OBJECT (GEN & PALLET)
local function ObjectESP(state, key, color)
    _G["Obj_"..key] = state
    if state then
        task.spawn(function()
            while _G["Obj_"..key] do
                task.wait(1)
                for _, v in pairs(workspace:GetDescendants()) do
                    if v.Name:find(key) or (v.Parent and v.Parent.Name:find(key)) then
                        if not v:FindFirstChild("BD_Obj_ESP") then
                            local hi = Instance.new("Highlight")
                            hi.Name = "BD_Obj_ESP"; hi.Parent = v; hi.FillColor = color; hi.FillTransparency = 0.5
                        end
                    end
                end
            end
        end)
    else
        for _, v in pairs(workspace:GetDescendants()) do
            if v:FindFirstChild("BD_Obj_ESP") then v.BD_Obj_ESP:Destroy() end
        end
    end
end

-- --- SETUP TOMBOL ---
CreateToggleButton(SurPage, "ESP Killer", Color3.fromRGB(200, 50, 50), function(s) KillerESP(s) end)

CreateToggleButton(KlrPage, "ESP Survival", Color3.fromRGB(200, 50, 50), function(s) SurvivalESP(s) end)

CreateToggleButton(EspPage, "Full Bright", Color3.fromRGB(200, 50, 50), function(s)
    game:GetService("Lighting").Brightness = s and 2 or 1
end)
CreateToggleButton(EspPage, "ESP Generator", Color3.fromRGB(200, 50, 50), function(s) ObjectESP(s, "Generator", Color3.new(1,1,0)) end)
CreateToggleButton(EspPage, "ESP Pallet", Color3.fromRGB(200, 50, 50), function(s) ObjectESP(s, "Pallet", Color3.new(1,1,0)) end)

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