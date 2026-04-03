-- [[ BoDcChii VD Helper v2.0 - Survival & Killer Specialist 😈 ]] --

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BoDcChii_Main"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- 1. FLOATING ICON (Ikon Bulat "BD")
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

-- 2. MAIN FRAME (Lebar 220 sesuai request)
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Position = UDim2.new(0.5, -110, 0.3, 0)
MainFrame.Size = UDim2.new(0, 220, 0, 200)
MainFrame.Visible = false

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

OpenIcon.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- 3. SIDEBAR (Tempat Tombol Tab)
local Sidebar = Instance.new("Frame")
Sidebar.Parent = MainFrame
Sidebar.Size = UDim2.new(0, 50, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local SideCorner = Instance.new("UICorner")
SideCorner.CornerRadius = UDim.new(0, 10)
SideCorner.Parent = Sidebar

-- 4. CONTAINER HALAMAN
local PageContainer = Instance.new("Frame")
PageContainer.Parent = MainFrame
PageContainer.Position = UDim2.new(0, 55, 0, 5)
PageContainer.Size = UDim2.new(1, -60, 1, -10)
PageContainer.BackgroundTransparency = 1

-- FUNGSI BUAT HALAMAN
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

-- HALAMAN 1: SURVIVAL
local SurPage = CreatePage("SUR", true)

-- HALAMAN 2: KILLER
local KlrPage = CreatePage("KLR", false)

-- HALAMAN 3: ESP
local EspPage = CreatePage("ESP", false)

-- --- FUNGSI TOMBOL FITUR ---
local function AddButton(parent, text, color, callback)
    local Btn = Instance.new("TextButton")
    Btn.Parent = parent
    Btn.Size = UDim2.new(1, -5, 0, 35)
    Btn.BackgroundColor3 = color
    Btn.Text = text
    Btn.TextColor3 = Color3.new(1, 1, 1)
    Btn.Font = Enum.Font.SourceSansBold
    Btn.TextSize = 14
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = Btn
    
    Btn.MouseButton1Click:Connect(callback)
    return Btn
end

-- --- ISI HALAMAN 1: SURVIVAL (SUR) ---
AddButton(SurPage, "Auto Perfect Gen", Color3.fromRGB(0, 120, 215), function() print("Auto Gen Aktif") end)
AddButton(SurPage, "Auto Perfect Heal", Color3.fromRGB(0, 120, 215), function() print("Auto Heal Aktif") end)
AddButton(SurPage, "ESP Killer", Color3.fromRGB(200, 50, 50), function() print("ESP Killer Aktif") end)

-- --- ISI HALAMAN 2: KILLER (KLR) ---
AddButton(KlrPage, "ESP Survival", Color3.fromRGB(50, 150, 50), function() print("ESP Survival Aktif") end)

-- --- ISI HALAMAN 3: ESP (VISUAL) ---
AddButton(EspPage, "Full Brightness", Color3.fromRGB(255, 170, 0), function() 
    game:GetService("Lighting").Brightness = 2
    game:GetService("Lighting").GlobalShadows = false
    game:GetService("Lighting").FogEnd = 99999
end)
AddButton(EspPage, "ESP Generator", Color3.fromRGB(0, 150, 200), function() print("ESP Gen Aktif") end)
AddButton(EspPage, "ESP Pallet", Color3.fromRGB(0, 150, 200), function() print("ESP Pallet Aktif") end)
AddButton(EspPage, "ESP Gate", Color3.fromRGB(0, 150, 200), function() print("ESP Gate Aktif") end)

-- --- NAVIGASI TAB ---
local function CreateTabBtn(pos, text, page)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Parent = Sidebar
    TabBtn.Position = pos
    TabBtn.Size = UDim2.new(1, 0, 0, 40)
    TabBtn.Text = text
    TabBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    TabBtn.TextColor3 = Color3.new(1, 1, 1)
    TabBtn.Font = Enum.Font.SourceSansBold
    
    TabBtn.MouseButton1Click:Connect(function()
        SurPage.Visible = false
        KlrPage.Visible = false
        EspPage.Visible = false
        page.Visible = true
    end)
end

CreateTabBtn(UDim2.new(0,0,0,5), "SUR", SurPage)
CreateTabBtn(UDim2.new(0,0,0,50), "KLR", KlrPage)
CreateTabBtn(UDim2.new(0,0,0,95), "ESP", EspPage)