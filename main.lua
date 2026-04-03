-- [[ BoDcChii VD Helper v2.2 - Toggle & ESP Fix 😈 ]] --

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
MainFrame.Size = UDim2.new(0, 220, 0, 230)
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

-- --- FUNGSI TOGGLE WARNA & ESP ---
local function CreateToggleButton(parent, text, offColor, onColor, callback)
    local IsActive = false
    local Btn = Instance.new("TextButton")
    Btn.Parent = parent
    Btn.Size = UDim2.new(1, -5, 0, 35)
    Btn.BackgroundColor3 = offColor -- Awalnya Merah/Warna Mati
    Btn.Text = text .. ": OFF"
    Btn.TextColor3 = Color3.new(1, 1, 1)
    Btn.Font = Enum.Font.SourceSansBold
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = Btn
    
    Btn.MouseButton1Click:Connect(function()
        IsActive = not IsActive
        if IsActive then
            Btn.BackgroundColor3 = Color3.fromRGB(0, 200, 100) -- Hijau (Aktif)
            Btn.Text = text .. ": ON"
        else
            Btn.BackgroundColor3 = offColor -- Kembali ke warna awal
            Btn.Text = text .. ": OFF"
        end
        callback(IsActive)
    end)
    return Btn
end

-- Fungsi ESP Universal
local function ManageESP(state, targetName, color)
    if state then
        for _, v in pairs(workspace:GetDescendants()) do
            -- Mencoba mencari berdasarkan Nama atau Nama Ortu (biar makin akurat di VD)
            if v.Name:find(targetName) or (v.Parent and v.Parent.Name:find(targetName)) then
                if v:IsA("Model") or v:IsA("BasePart") then
                    if not v:FindFirstChild("BD_Highlight") then
                        local highlight = Instance.new("Highlight")
                        highlight.Name = "BD_Highlight"
                        highlight.Parent = v
                        highlight.FillColor = color
                        highlight.OutlineColor = Color3.new(1, 1, 1)
                        highlight.FillTransparency = 0.4
                    end
                end
            end
        end
    else
        for _, v in pairs(workspace:GetDescendants()) do
            if v:FindFirstChild("BD_Highlight") then
                v.BD_Highlight:Destroy()
            end
        end
    end
end

-- --- ISI HALAMAN 1: SURVIVAL ---
CreateToggleButton(SurPage, "Perfect Gen", Color3.fromRGB(200, 50, 50), nil, function(state)
    -- Logika Auto Gen akan kita masukkan setelah ini
end)

CreateToggleButton(SurPage, "ESP Killer", Color3.fromRGB(200, 50, 50), nil, function(state)
    -- Di VD Killer biasanya namanya "Killer" atau ada di folder "Players" dengan tim merah
    ManageESP(state, "Killer", Color3.new(1, 0, 0)) -- MERAH
end)

-- --- ISI HALAMAN 2: KILLER ---
CreateToggleButton(KlrPage, "ESP Survival", Color3.fromRGB(200, 50, 50), nil, function(state)
    ManageESP(state, "Survivor", Color3.new(0, 1, 0)) -- HIJAU
end)

-- --- ISI HALAMAN 3: ESP (VISUAL) ---
CreateToggleButton(EspPage, "Full Bright", Color3.fromRGB(200, 50, 50), nil, function(state)
    if state then
        game:GetService("Lighting").Brightness = 2
        game:GetService("Lighting").GlobalShadows = false
    else
        game:GetService("Lighting").Brightness = 1
        game:GetService("Lighting").GlobalShadows = true
    end
end)

CreateToggleButton(EspPage, "ESP Generator", Color3.fromRGB(200, 50, 50), nil, function(state)
    ManageESP(state, "Generator", Color3.new(1, 1, 0)) -- KUNING
end)

CreateToggleButton(EspPage, "ESP Pallet", Color3.fromRGB(200, 50, 50), nil, function(state)
    ManageESP(state, "Pallet", Color3.new(1, 1, 0)) -- KUNING
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