-- [[ BoDcChii VD Helper v0.2 - Fixed & Locked 😈 ]] --

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BoDcChii_v02"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- --- FUNGSI DESTROY TOTAL ---
local function ExitScript()
    _G.KillerActive = false
    _G.SurviActive = false
    _G.ObjScan = false
    for _, v in pairs(workspace:GetDescendants()) do
        if v.Name == "BD_ESP" then v:Destroy() end
    end
    ScreenGui:Destroy()
end

-- 1. FLOATING ICON (BD)
local OpenIcon = Instance.new("TextButton")
OpenIcon.Parent = ScreenGui
OpenIcon.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
OpenIcon.Position = UDim2.new(0, 15, 0.4, 0)
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
MainFrame.Size = UDim2.new(0, 220, 0, 280) -- Ukuran pas
MainFrame.Visible = false
MainFrame.ZIndex = 5
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

OpenIcon.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- 3. TOMBOL SILANG (X) - PAKSA PALING DEPAN
local ExitBtn = Instance.new("TextButton")
ExitBtn.Parent = MainFrame
ExitBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
ExitBtn.Position = UDim2.new(1, -30, 0, 5)
ExitBtn.Size = UDim2.new(0, 25, 0, 25)
ExitBtn.Text = "X"
ExitBtn.TextColor3 = Color3.new(1, 1, 1)
ExitBtn.Font = Enum.Font.SourceSansBold
ExitBtn.ZIndex = 10 -- Biar nggak ketutup
local ExitCorner = Instance.new("UICorner")
ExitCorner.CornerRadius = UDim.new(1, 0)
ExitCorner.Parent = ExitBtn

ExitBtn.MouseButton1Click:Connect(ExitScript)

-- 4. SIDEBAR & PAGES
local Sidebar = Instance.new("Frame")
Sidebar.Parent = MainFrame
Sidebar.Size = UDim2.new(0, 50, 1, -30)
Sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local PageContainer = Instance.new("Frame")
PageContainer.Parent = MainFrame
PageContainer.Position = UDim2.new(0, 55, 0, 35)
PageContainer.Size = UDim2.new(1, -60, 1, -70)
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

-- 5. WATERMARK @BoDcChii & v0.1
local Footer = Instance.new("TextLabel")
Footer.Parent = MainFrame
Footer.Position = UDim2.new(0, 0, 1, -25)
Footer.Size = UDim2.new(1, 0, 0, 20)
Footer.BackgroundTransparency = 1
Footer.Text = "@BoDcChii | v0.1"
Footer.TextColor3 = Color3.fromRGB(0, 170, 255)
Footer.Font = Enum.Font.SourceSansBold
Footer.TextSize = 13
Footer.ZIndex = 10

-- --- FUNGSI TOGGLE ---
local function CreateToggle(parent, text, callback)
    local active = false
    local btn = Instance.new("TextButton")
    btn.Parent = parent; btn.Size = UDim2.new(1, -5, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.Text = text .. ": OFF"; btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 6); c.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        active = not active
        btn.BackgroundColor3 = active and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(50, 50, 50)
        btn.Text = active and text .. ": ON" or text .. ": OFF"
        callback(active)
    end)
end

-- --- CORE LOGIC (ANTI-WARNABERUBAH) ---
local function RunESP(state, mode, color)
    _G[mode.."_Active"] = state
    if state then
        task.spawn(function()
            while _G[mode.."_Active"] do
                task.wait(0.5)
                for _, p in pairs(game.Players:GetPlayers()) do
                    if p ~= game.Players.LocalPlayer and p.Character then
                        -- Deteksi Killer Super Teliti
                        local isK = (p.Team and p.Team.Name:lower():find("killer")) or 
                                    p.Character:FindFirstChild("Knife") or 
                                    p.Character:FindFirstChild("Weapon") or
                                    p.Name:lower():find("killer")

                        if (mode == "Killer" and isK) or (mode == "Survivor" and not isK) then
                            local hi = p.Character:FindFirstChild("BD_ESP") or Instance.new("Highlight")
                            hi.Name = "BD_ESP"; hi.Parent = p.Character; hi.FillColor = color
                            hi.FillTransparency = 0.4; hi.OutlineColor = Color3.new(1,1,1)
                        else
                            -- Jika dia bukan target, hapus ESP-nya (Cegah warna berubah)
                            if p.Character:FindFirstChild("BD_ESP") then 
                                -- Hanya hapus jika loop lain tidak sedang mewarnainya
                                local other = (mode == "Killer") and "Survivor_Active" or "Killer_Active"
                                if not _G[other] then p.Character.BD_ESP:Destroy() end
                            end
                        end
                    end
                end
            end
        end)
    else
        for _, p in pairs(game.Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("BD_ESP") then p.Character.BD_ESP:Destroy() end
        end
    end
end

-- --- SETUP MENU ---
CreateToggle(SurPage, "ESP Killer", function(s) RunESP(s, "Killer", Color3.new(1,0,0)) end)
CreateToggle(KlrPage, "ESP Survival", function(s) RunESP(s, "Survivor", Color3.new(0,1,0)) end)
CreateToggle(EspPage, "Bright", function(s) game:GetService("Lighting").Brightness = s and 2 or 1 end)

-- --- NAVIGASI ---
local function Tab(pos, txt, p)
    local b = Instance.new("TextButton")
    b.Parent = Sidebar; b.Position = pos; b.Size = UDim2.new(1, 0, 0, 45)
    b.Text = txt; b.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    b.TextColor3 = Color3.new(1, 1, 1); b.Font = Enum.Font.SourceSansBold
    b.MouseButton1Click:Connect(function()
        SurPage.Visible = false; KlrPage.Visible = false; EspPage.Visible = false; p.Visible = true
    end)
end
Tab(UDim2.new(0,0,0,5), "SUR", SurPage)
Tab(UDim2.new(0,0,0,55), "KLR", KlrPage)
Tab(UDim2.new(0,0,0,105), "ESP", EspPage)