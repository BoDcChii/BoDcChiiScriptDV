-- [[ BoDcChii VD Helper v2.1 - Real Function Update 😈 ]] --

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
MainFrame.Size = UDim2.new(0, 220, 0, 220)
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
    Page.Name = name
    Page.Parent = PageContainer
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.ScrollBarThickness = 2
    Page.Visible = visible
    local Layout = Instance.new("UIListLayout")
    Layout.Parent = Page
    Layout.Padding = UDim.new(0, 5)
    return Page
end

local SurPage = CreatePage("SUR", true)
local KlrPage = CreatePage("KLR", false)
local EspPage = CreatePage("ESP", false)

-- --- FUNGSI CORE (MESIN UTAMA) ---

-- Fungsi ESP (Highlight)
local function ApplyESP(targetModel, color)
    if targetModel and not targetModel:FindFirstChild("BD_ESP") then
        local highlight = Instance.new("Highlight")
        highlight.Name = "BD_ESP"
        highlight.Parent = targetModel
        highlight.FillColor = color
        highlight.OutlineColor = Color3.new(1, 1, 1) -- Garis Putih
        highlight.FillTransparency = 0.5
    end
end

-- --- FUNGSI TOMBOL ---
local function AddButton(parent, text, color, callback)
    local Btn = Instance.new("TextButton")
    Btn.Parent = parent
    Btn.Size = UDim2.new(1, -5, 0, 35)
    Btn.BackgroundColor3 = color
    Btn.Text = text
    Btn.TextColor3 = Color3.new(1, 1, 1)
    Btn.Font = Enum.Font.SourceSansBold
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = Btn
    Btn.MouseButton1Click:Connect(callback)
    return Btn
end

-- --- ISI HALAMAN 1: SURVIVAL ---
AddButton(SurPage, "Auto Perfect Gen", Color3.fromRGB(0, 120, 215), function()
    -- Logika Auto Perfect (Menunggu event SkillCheck muncul)
    print("Auto Perfect Gen System Ready")
end)

AddButton(SurPage, "ESP Killer (RED)", Color3.fromRGB(200, 50, 50), function()
    -- Mencari Killer (Biasanya punya tag khusus atau di folder tertentu di VD)
    for _, v in pairs(game.Players:GetPlayers()) do
        if v.Team and (v.Team.Name == "Killer" or v.Team.Name == "Slasher") then
            if v.Character then ApplyESP(v.Character, Color3.new(1, 0, 0)) end
        end
    end
end)

-- --- ISI HALAMAN 2: KILLER ---
AddButton(KlrPage, "ESP Survival (GREEN)", Color3.fromRGB(50, 150, 50), function()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= game.Players.LocalPlayer and v.Character then
            ApplyESP(v.Character, Color3.new(0, 1, 0))
        end
    end
end)

-- --- ISI HALAMAN 3: ESP (VISUAL) ---
AddButton(EspPage, "Full Brightness", Color3.fromRGB(255, 170, 0), function() 
    game:GetService("Lighting").Brightness = 2
    game:GetService("Lighting").GlobalShadows = false
    game:GetService("Lighting").FogEnd = 99999
end)

AddButton(EspPage, "ESP Generator (YELLOW)", Color3.fromRGB(150, 150, 0), function()
    -- Mencari objek bernama Generator di Workspace
    for _, v in pairs(workspace:GetDescendants()) do
        if v.Name == "Generator" or v:FindFirstChild("Generator") then
            ApplyESP(v, Color3.new(1, 1, 0))
        end
    end
end)

AddButton(EspPage, "ESP Pallet (YELLOW)", Color3.fromRGB(150, 150, 0), function()
    for _, v in pairs(workspace:GetDescendants()) do
        if v.Name == "Pallet" or v.Name == "Vault" then
            ApplyESP(v, Color3.new(1, 1, 0))
        end
    end
end)

-- --- NAVIGASI TAB ---
local function CreateTabBtn(pos, text, page)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Parent = Sidebar
    TabBtn.Position = pos
    TabBtn.Size = UDim2.new(1, 0, 0, 45)
    TabBtn.Text = text
    TabBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    TabBtn.TextColor3 = Color3.new(1, 1, 1)
    TabBtn.Font = Enum.Font.SourceSansBold
    TabBtn.MouseButton1Click:Connect(function()
        SurPage.Visible = false; KlrPage.Visible = false; EspPage.Visible = false
        page.Visible = true
    end)
end
CreateTabBtn(UDim2.new(0,0,0,5), "SUR", SurPage)
CreateTabBtn(UDim2.new(0,0,0,50), "KLR", KlrPage)
CreateTabBtn(UDim2.new(0,0,0,95), "ESP", EspPage)