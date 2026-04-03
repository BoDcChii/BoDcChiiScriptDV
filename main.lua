-- [[ BoDcChii VD Helper v3.0 - Stable & No Glitch 😈 ]] --

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BoDcChii_Stable"
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

-- --- CORE FUNCTIONS (LIGHTWEIGHT) ---

-- 1. FUNGSI ESP PLAYER (PAKAI TEKS BIAR RINGAN)
local function SimpleESP(state, targetType, color)
    -- targetType: 1 = Killer, 2 = Survivor
    if state then
        _G.ESP_Loop = game:GetService("RunService").Heartbeat:Connect(function()
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= game.Players.LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                    local isKiller = false
                    if p.Team and (p.Team.Name:lower():find("killer") or p.Team.Name:lower():find("slasher")) then
                        isKiller = true
                    end

                    if (targetType == 1 and isKiller) or (targetType == 2 and not isKiller) then
                        if not p.Character.Head:FindFirstChild("BD_Tag") then
                            local tag = Instance.new("BillboardGui")
                            tag.Name = "BD_Tag"
                            tag.Parent = p.Character.Head
                            tag.Size = UDim2.new(0, 100, 0, 50)
                            tag.Adornee = p.Character.Head
                            tag.AlwaysOnTop = true
                            tag.ExtentsOffset = Vector3.new(0, 3, 0)

                            local label = Instance.new("TextLabel")
                            label.Parent = tag
                            label.BackgroundTransparency = 1
                            label.Size = UDim2.new(1, 0, 1, 0)
                            label.Text = isKiller and "⚠️ KILLER ⚠️" or "👤 SURVIVOR"
                            label.TextColor3 = color
                            label.TextStrokeTransparency = 0
                            label.Font = Enum.Font.SourceSansBold
                            label.TextSize = 14
                        end
                    else
                        if p.Character.Head:FindFirstChild("BD_Tag") then p.Character.Head.BD_Tag:Destroy() end
                    end
                end
            end
        end)
    else
        if _G.ESP_Loop then _G.ESP_Loop:Disconnect() end
        for _, p in pairs(game.Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("Head") and p.Character.Head:FindFirstChild("BD_Tag") then
                p.Character.Head.BD_Tag:Destroy()
            end
        end
    end
end

-- --- SETUP TOMBOL ---
CreateToggleButton(SurPage, "Perfect Gen (Disabled)", Color3.fromRGB(100, 100, 100), function(s) 
    print("Fitur dimatikan sementara agar tidak bug UI")
end)

CreateToggleButton(SurPage, "ESP Killer", Color3.fromRGB(200, 50, 50), function(s) 
    SimpleESP(s, 1, Color3.fromRGB(255, 0, 0)) 
end)

CreateToggleButton(KlrPage, "ESP Survival", Color3.fromRGB(200, 50, 50), function(s) 
    SimpleESP(s, 2, Color3.fromRGB(0, 255, 0)) 
end)

CreateToggleButton(EspPage, "Full Bright", Color3.fromRGB(200, 50, 50), function(s)
    game:GetService("Lighting").Brightness = s and 2 or 1
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