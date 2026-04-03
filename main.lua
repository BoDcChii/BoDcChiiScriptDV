-- [[ BoDcChii Project - v4.1: Minimalist BD 🎸 ]] --
-- Update: Added Separate ESP (Survivor: Green | Killer: Red)

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

-- --- 1. ICON TEKS "BD" ---
local OpenButton = Instance.new("TextButton", ScreenGui)
OpenButton.Size = UDim2.new(0, 50, 0, 50)
OpenButton.Position = UDim2.new(0, 20, 0.5, -25)
OpenButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
OpenButton.Text = "BD" 
OpenButton.TextColor3 = Color3.fromRGB(255, 105, 180)
OpenButton.TextSize = 24
OpenButton.Font = Enum.Font.SourceSansBold
OpenButton.ZIndex = 500

local IconCorner = Instance.new("UICorner", OpenButton)
IconCorner.CornerRadius = UDim.new(0, 12)
local IconStroke = Instance.new("UIStroke", OpenButton)
IconStroke.Color = Color3.fromRGB(255, 105, 180)
IconStroke.Thickness = 2

-- --- 2. HALAMAN FITUR ---
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 240, 0, 220) -- Ukuran disesuaikan untuk 2 tombol
MainFrame.Position = UDim2.new(0.5, -120, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Visible = false
MainFrame.Active = true

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
local FrameStroke = Instance.new("UIStroke", MainFrame)
FrameStroke.Color = Color3.fromRGB(255, 105, 180)
FrameStroke.Thickness = 2

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

-- Fungsi cek apakah pemain adalah Killer (Berdasarkan Tool/Senjata)
local function IsKiller(player)
    -- Biasanya Killer punya tool "Knife" atau "Weapon" di Backpack atau Character
    if player.Backpack:FindFirstChild("Knife") or player.Backpack:FindFirstChild("Weapon") or 
       (player.Character and (player.Character:FindFirstChild("Knife") or player.Character:FindFirstChild("Weapon"))) then
        return true
    end
    return false
end

local function CreateESP(btn, text, colorOn)
    btn.Size = UDim2.new(0.8, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 14
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
end

-- Tombol ESP Survivor
local SurvBtn = Instance.new("TextButton", MainFrame)
SurvBtn.Name = "SurvBtn"
SurvBtn.Text = "ESP Survivor: OFF"
SurvBtn.Position = UDim2.new(0.1, 0, 0, 60)
CreateESP(SurvBtn)

-- Tombol ESP Killer
local KillBtn = Instance.new("TextButton", MainFrame)
KillBtn.Name = "KillBtn"
KillBtn.Text = "ESP Killer: OFF"
KillBtn.Position = UDim2.new(0.1, 0, 0, 105)
CreateESP(KillBtn)

-- Update Loop
RunService.RenderStepped:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= Players.LocalPlayer and p.Character then
            local hl = p.Character:FindFirstChild("BDEsp")
            
            if not hl then
                hl = Instance.new("Highlight")
                hl.Name = "BDEsp"
                hl.Parent = p.Character
                hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                hl.FillTransparency = 0.5
            end

            -- Logika Pemisahan Warna
            if IsKiller(p) then
                hl.FillColor = Color3.fromRGB(255, 0, 0) -- Merah untuk Killer
                hl.Enabled = KillerEnabled
            else
                hl.FillColor = Color3.fromRGB(0, 255, 0) -- Hijau untuk Survivor
                hl.Enabled = SurvivorEnabled
            end
        end
    end
end)

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

-- --- 4. LOGIKA BUKA/TUTUP ---
OpenButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

local Exit = Instance.new("TextButton", MainFrame)
Exit.Size = UDim2.new(0, 25, 0, 25)
Exit.Position = UDim2.new(1, -30, 0, 7)
Exit.Text = "X"
Exit.TextColor3 = Color3.new(1, 1, 1)
Exit.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
Instance.new("UICorner", Exit).CornerRadius = UDim.new(1, 0)

Exit.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- --- 5. DRAG SYSTEM UNTUK ICON ---
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