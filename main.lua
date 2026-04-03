-- [[ BoDcChii VD Helper v2.8 - Ghost Engine 😈 ]] --

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
MainFrame.Size = UDim2.new(0, 220, 0, 260)
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

-- --- CORE ENGINE (THE GHOST) ---

-- 1. AUTO PERFECT ENGINE (Ultra Fast Scan)
local function AutoSkillCheck(state)
    _G.AutoSkillActive = state
    task.spawn(function()
        while _G.AutoSkillActive do
            task.wait()
            local pGui = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
            if pGui then
                for _, v in pairs(pGui:GetDescendants()) do
                    -- Memindai objek yang muncul saat SkillCheck (biasanya berupa baris/jarum)
                    if v:IsA("GuiObject") and v.Visible and (v.Name:lower():find("skill") or v.Name:lower():find("perfect") or v.Name:lower():find("check")) then
                        -- Metode Input Alternatif (Keydown/Keyup)
                        local vim = game:GetService("VirtualInputManager")
                        vim:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
                        task.wait(0.01)
                        vim:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
                        task.wait(0.15)
                    end
                end
            end
        end
    end)
end

-- 2. PLAYER ESP ENGINE (Workspace Wide Scan)
local function PlayerESP(state, mode, color)
    -- mode: 1 = Killer, 2 = Survivor
    if state then
        _G.PlayerTracker = game:GetService("RunService").Heartbeat:Connect(function()
            for _, v in pairs(workspace:GetChildren()) do
                -- Mencari Model Karakter Manusia
                if v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                    local player = game.Players:GetPlayerFromCharacter(v)
                    if v ~= game.Players.LocalPlayer.Character then
                        
                        -- Logika Deteksi Killer (Cek Senjata atau Nama Spesifik)
                        local isKiller = false
                        if v:FindFirstChild("Knife") or v:FindFirstChild("Weapon") or (player and player.Team and player.Team.Name:lower():find("killer")) then
                            isKiller = true
                        end

                        if (mode == 1 and isKiller) or (mode == 2 and not isKiller) then
                            local hi = v:FindFirstChild("BD_ESP") or Instance.new("Highlight")
                            hi.Name = "BD_ESP"; hi.Parent = v; hi.FillColor = color; hi.FillTransparency = 0.4
                        else
                            if v:FindFirstChild("BD_ESP") then v.BD_ESP:Destroy() end
                        end
                    end
                end
            end
        end)
    else
        if _G.PlayerTracker then _G.PlayerTracker:Disconnect() end
        for _, v in pairs(workspace:GetDescendants()) do
            if v.Name == "BD_ESP" then v:Destroy() end
        end
    end
end

-- 3. OBJECT ESP ENGINE
local function ObjectESP(state, key, color)
    if state then
        for _, v in pairs(workspace:GetDescendants()) do
            if v.Name:lower():find(key:lower()) then
                local hi = v:FindFirstChild("BD_ObjESP") or Instance.new("Highlight")
                hi.Name = "BD_ObjESP"; hi.Parent = v; hi.FillColor = color; hi.FillTransparency = 0.5
            end
        end
    else
        for _, v in pairs(workspace:GetDescendants()) do
            if v.Name == "BD_ObjESP" then v:Destroy() end
        end
    end
end

-- --- TAB SUR ---
CreateToggleButton(SurPage, "Perfect Gen", Color3.fromRGB(200, 50, 50), function(s) AutoSkillCheck(s) end)
CreateToggleButton(SurPage, "Perfect Heal", Color3.fromRGB(200, 50, 50), function(s) AutoSkillCheck(s) end)
CreateToggleButton(SurPage, "ESP Killer", Color3.fromRGB(200, 50, 50), function(s) PlayerESP(s, 1, Color3.new(1, 0, 0)) end)

-- --- TAB KLR ---
CreateToggleButton(KlrPage, "ESP Survival", Color3.fromRGB(200, 50, 50), function(s) PlayerESP(s, 2, Color3.new(0, 1, 0)) end)

-- --- TAB ESP ---
CreateToggleButton(EspPage, "Full Bright", Color3.fromRGB(200, 50, 50), function(s)
    game:GetService("Lighting").Brightness = s and 2 or 1
    game:GetService("Lighting").GlobalShadows = not s
end)
CreateToggleButton(EspPage, "ESP Gen", Color3.fromRGB(200, 50, 50), function(s) ObjectESP(s, "Generator", Color3.new(1, 1, 0)) end)
CreateToggleButton(EspPage, "ESP Pallet", Color3.fromRGB(200, 50, 50), function(s) ObjectESP(s, "Pallet", Color3.new(1, 1, 0)) end)
CreateToggleButton(EspPage, "ESP Gate", Color3.fromRGB(200, 50, 50), function(s) ObjectESP(s, "Gate", Color3.new(1, 1, 0)) end)

-- --- NAV ---
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