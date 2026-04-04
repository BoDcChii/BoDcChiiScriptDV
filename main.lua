-- [[ BoDcChii Project - v4.1: Minimalist BD 🎸 ]] --
-- Update: Added ESP Generator (Yellow) + Improved Draggable UI

local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

-- Bersihkan versi sebelumnya
if CoreGui:FindFirstChild("BoDcChii_Minimalist") then
    CoreGui.BoDcChii_Minimalist:Destroy()
end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "BoDcChii_Minimalist"
ScreenGui.ResetOnSpawn = false

-- --- FUNGSI DRAG OPTIMIZED ---
local function EnableDrag(gui)
    local dragging, dragInput, dragStart, startPos
    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    gui.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- --- 1. ICON "BD" ---
local OpenButton = Instance.new("TextButton", ScreenGui)
OpenButton.Size = UDim2.new(0, 50, 0, 50)
OpenButton.Position = UDim2.new(0, 20, 0.5, -25)
OpenButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
OpenButton.Text = "BD" 
OpenButton.TextColor3 = Color3.fromRGB(255, 105, 180)
OpenButton.TextSize = 24
OpenButton.Font = Enum.Font.SourceSansBold
OpenButton.ZIndex = 500
Instance.new("UICorner", OpenButton).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", OpenButton).Color = Color3.fromRGB(255, 105, 180)

EnableDrag(OpenButton)

-- --- 2. HALAMAN MENU ---
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 240, 0, 240) -- Ukuran ditambah untuk 3 tombol
MainFrame.Position = UDim2.new(0.5, -120, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Visible = false
MainFrame.Active = true

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
local Stroke = Instance.new("UIStroke", MainFrame)
Stroke.Color = Color3.fromRGB(255, 105, 180)
Stroke.Thickness = 2

EnableDrag(MainFrame)

local Header = Instance.new("TextLabel", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 40)
Header.Text = "BoDcChii Project"
Header.TextColor3 = Color3.new(1, 1, 1)
Header.BackgroundTransparency = 1
Header.Font = Enum.Font.SourceSansBold
Header.TextSize = 18

-- --- 3. LOGIKA ESP ---
local _SurvOn, _KillOn, _GenOn = false, false, false

local function IsKiller(p)
    local char = p.Character
    if not char then return false end
    if p.Team and (p.Team.Name:lower():find("killer") or p.Team.Name:lower():find("murder")) then return true end
    local hum = char:FindFirstChild("Humanoid")
    return hum and hum.MaxHealth > 100
end

local function CreateButton(name, pos, text)
    local btn = Instance.new("TextButton", MainFrame)
    btn.Name = name
    btn.Size = UDim2.new(0.85, 0, 0, 35)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    btn.Text = text .. ": OFF"
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    Instance.new("UICorner", btn)
    return btn
end

local SurvBtn = CreateButton("SurvBtn", UDim2.new(0.075, 0, 0, 60), "ESP Survivor")
local KillBtn = CreateButton("KillBtn", UDim2.new(0.075, 0, 0, 105), "ESP Killer")
local GenBtn = CreateButton("GenBtn", UDim2.new(0.075, 0, 0, 150), "ESP Generator")

-- Render Loop
RunService.RenderStepped:Connect(function()
    -- ESP Player (Survivor & Killer)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= Players.LocalPlayer and p.Character then
            local hl = p.Character:FindFirstChild("BDEsp") or Instance.new("Highlight", p.Character)
            hl.Name = "BDEsp"
            hl.OutlineColor = Color3.new(1, 1, 1)
            
            if IsKiller(p) then
                hl.FillColor = Color3.fromRGB(255, 0, 0)
                hl.Enabled = _KillOn
            else
                hl.FillColor = Color3.fromRGB(0, 255, 0)
                hl.Enabled = _SurvOn
            end
        end
    end
    
    -- ESP Generator (Yellow)
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if obj.Name == "Generator" or obj.Name == "Gen" then -- Sesuaikan dengan nama object di game
            local hl = obj:FindFirstChild("GenEsp") or Instance.new("Highlight", obj)
            hl.Name = "GenEsp"
            hl.FillColor = Color3.fromRGB(255, 255, 0) -- KUNING
            hl.OutlineColor = Color3.new(1, 1, 1)
            hl.Enabled = _GenOn
        end
    end
end)

-- Click Events
SurvBtn.MouseButton1Click:Connect(function()
    _SurvOn = not _SurvOn
    SurvBtn.Text = _SurvOn and "ESP Survivor: ON" or "ESP Survivor: OFF"
    SurvBtn.BackgroundColor3 = _SurvOn and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
end)

KillBtn.MouseButton1Click:Connect(function()
    _KillOn = not _KillOn
    KillBtn.Text = _KillOn and "ESP Killer: ON" or "ESP Killer: OFF"
    KillBtn.BackgroundColor3 = _KillOn and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
end)

GenBtn.MouseButton1Click:Connect(function()
    _GenOn = not _GenOn
    GenBtn.Text = _GenOn and "ESP Generator: ON" or "ESP Generator: OFF"
    GenBtn.BackgroundColor3 = _GenOn and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
end)

-- --- 4. SISTEM BUKA/TUTUP ---
OpenButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
local Exit = Instance.new("TextButton", MainFrame)
Exit.Size = UDim2.new(0, 25, 0, 25)
Exit.Position = UDim2.new(1, -30, 0, 7)
Exit.Text = "X"
Exit.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
Exit.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", Exit).CornerRadius = UDim.new(1, 0)
Exit.MouseButton1Click:Connect(function() MainFrame.Visible = false end)