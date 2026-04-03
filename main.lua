-- [[ BoDcChii Project - v4.1: Minimalist BD 🎸 ]] --
-- Fix: Deteksi Berdasarkan Role (Bukan Senjata) agar tidak tertukar

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

-- --- 2. HALAMAN MENU ---
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 240, 0, 200)
MainFrame.Position = UDim2.new(0.5, -120, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Visible = false
MainFrame.Active = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
local Stroke = Instance.new("UIStroke", MainFrame)
Stroke.Color = Color3.fromRGB(255, 105, 180)
Stroke.Thickness = 2

local Header = Instance.new("TextLabel", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 40)
Header.Text = "BoDcChii Project"
Header.TextColor3 = Color3.new(1, 1, 1)
Header.BackgroundTransparency = 1
Header.Font = Enum.Font.SourceSansBold
Header.TextSize = 18

-- --- 3. LOGIKA ESP ---
local _SurvOn = false
local _KillOn = false

-- Fungsi Deteksi Killer yang Tidak Tergantung Senjata
local function IsKiller(p)
    local char = p.Character
    if not char then return false end
    
    -- 1. Cek Team (Biasanya Killer punya Tim Merah/Killer)
    if p.Team and (p.Team.Name:lower():find("killer") or p.Team.Name:lower():find("murder")) then
        return true
    end
    
    -- 2. Cek Folder/Value Role (Sering ada di game District)
    local role = p:FindFirstChild("Role") or char:FindFirstChild("Role")
    if role and (role.Value == "Killer" or role.Value == 2) then
        return true
    end

    -- 3. Cek Atribut khusus Killer (Killer biasanya punya Health lebih banyak)
    local hum = char:FindFirstChild("Humanoid")
    if hum and hum.MaxHealth > 100 then -- Biasanya Killer darahnya 200+
        return true
    end

    return false
end

-- Tombol ESP Survivor
local SurvBtn = Instance.new("TextButton", MainFrame)
SurvBtn.Size = UDim2.new(0.85, 0, 0, 35)
SurvBtn.Position = UDim2.new(0.075, 0, 0, 60)
SurvBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
SurvBtn.Text = "ESP Survivor: OFF"
SurvBtn.TextColor3 = Color3.new(1, 1, 1)
SurvBtn.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", SurvBtn)

-- Tombol ESP Killer
local KillBtn = Instance.new("TextButton", MainFrame)
KillBtn.Size = UDim2.new(0.85, 0, 0, 35)
KillBtn.Position = UDim2.new(0.075, 0, 0, 105)
KillBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
KillBtn.Text = "ESP Killer: OFF"
KillBtn.TextColor3 = Color3.new(1, 1, 1)
KillBtn.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", KillBtn)

-- Render Loop (Pemisahan Logika)
RunService.RenderStepped:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= Players.LocalPlayer and p.Character then
            local highlight = p.Character:FindFirstChild("BDEsp")
            if not highlight then
                highlight = Instance.new("Highlight", p.Character)
                highlight.Name = "BDEsp"
                highlight.OutlineColor = Color3.new(1, 1, 1)
            end

            -- LOGIKA PEMISAHAN BERDASARKAN ROLE
            if IsKiller(p) then
                highlight.FillColor = Color3.fromRGB(255, 0, 0) -- MERAH
                highlight.Enabled = _KillOn
            else
                highlight.FillColor = Color3.fromRGB(0, 255, 0) -- HIJAU
                highlight.Enabled = _SurvOn
            end
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

-- --- 4. SISTEM MENU & DRAG ---
OpenButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
local Exit = Instance.new("TextButton", MainFrame)
Exit.Size = UDim2.new(0, 25, 0, 25)
Exit.Position = UDim2.new(1, -30, 0, 7)
Exit.Text = "X"
Exit.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
Exit.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", Exit).CornerRadius = UDim.new(1, 0)
Exit.MouseButton1Click:Connect(function() MainFrame.Visible = false end)

local dragging, dragStart, startPos
OpenButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true; dragStart = input.Position; startPos = OpenButton.Position
    end
end)
UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - dragStart
        OpenButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UIS.InputEnded:Connect(function(input) dragging = false end)