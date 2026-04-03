-- [[ BoDcChii Project - v4.1: Minimalist BD 🎸 ]] --
-- Perbaikan: Pemisahan Logika Tombol & Prioritas Warna Merah

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

-- --- 3. LOGIKA ESP (SURVIVOR & KILLER) ---
local SurvivorEnabled = false
local KillerEnabled = false

-- Fungsi Deteksi Killer (Mendeteksi senjata/knife/folder killer)
local function CheckIfKiller(player)
    local char = player.Character
    if not char then return false end
    
    -- Cek Tool yang sedang dipegang atau ada di tas
    local tool = char:FindFirstChildOfClass("Tool") or player.Backpack:FindFirstChildOfClass("Tool")
    -- Cek Folder atau Tag "Killer" yang biasa ada di game District
    local folder = char:FindFirstChild("Killer") or player:FindFirstChild("Killer")
    
    if tool or folder then
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

-- Loop Render (Sangat Penting: Memisahkan Logika)
RunService.RenderStepped:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= Players.LocalPlayer and p.Character then
            local hl = p.Character:FindFirstChild("BDEsp")
            if not hl then
                hl = Instance.new("Highlight", p.Character)
                hl.Name = "BDEsp"
                hl.OutlineColor = Color3.new(1, 1, 1)
            end

            -- PRIORITAS LOGIKA:
            local isKiller = CheckIfKiller(p)

            if isKiller then
                -- Jika dia Killer, dia HANYA aktif kalau tombol Killer ON
                hl.FillColor = Color3.fromRGB(255, 0, 0) -- MERAH
                hl.Enabled = KillerEnabled
            else
                -- Jika dia Survivor, dia HANYA aktif kalau tombol Survivor ON
                hl.FillColor = Color3.fromRGB(0, 255, 0) -- HIJAU
                hl.Enabled = SurvivorEnabled
            end
        end
    end
end)

-- Event Klik Tombol
SurvBtn.MouseButton1Click:Connect(function()
    SurvivorEnabled = not SurvivorEnabled
    SurvBtn.Text = SurvivorEnabled and "ESP Survivor: ON" or "ESP Survivor: OFF"
    SurvBtn.BackgroundColor3 = SurvivorEnabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
end)

KillBtn.MouseButton1Click:Connect(function()
    KillerEnabled = not KillerEnabled
    KillBtn.Text = KillerEnabled and "ESP Killer: ON" or "ESP Killer: OFF"
    KillBtn.BackgroundColor3 = KillerEnabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
end)

-- --- 4. SISTEM MENU ---
OpenButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
local Exit = Instance.new("TextButton", MainFrame)
Exit.Size = UDim2.new(0, 25, 0, 25)
Exit.Position = UDim2.new(1, -30, 0, 7)
Exit.Text = "X"
Exit.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
Exit.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", Exit).CornerRadius = UDim.new(1, 0)
Exit.MouseButton1Click:Connect(function() MainFrame.Visible = false end)

-- --- 5. DRAG SYSTEM ---
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