-- [[ BoDcChii Project - v4.1: Minimalist BD 🎸 ]] --
-- Update: Added ESP Survivor (Green Highlight)

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
MainFrame.Size = UDim2.new(0, 240, 0, 200) -- Ukuran ditambah sedikit untuk tombol
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

local Line = Instance.new("Frame", MainFrame)
Line.Size = UDim2.new(0.9, 0, 0, 2)
Line.Position = UDim2.new(0.05, 0, 0, 40)
Line.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
Line.BorderSizePixel = 0

-- --- 3. FITUR ESP SURVIVOR ---
local EspEnabled = false

local EspBtn = Instance.new("TextButton", MainFrame)
EspBtn.Size = UDim2.new(0.8, 0, 0, 35)
EspBtn.Position = UDim2.new(0.1, 0, 0, 60)
EspBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50) -- Default Merah (Mati)
EspBtn.Text = "ESP Survivor: OFF"
EspBtn.TextColor3 = Color3.new(1, 1, 1)
EspBtn.Font = Enum.Font.SourceSansBold
EspBtn.TextSize = 16
Instance.new("UICorner", EspBtn).CornerRadius = UDim.new(0, 6)

-- Fungsi untuk membuat Highlight
local function ApplyEsp(character)
    if not character:FindFirstChild("BDSurvivorESP") then
        local highlight = Instance.new("Highlight")
        highlight.Name = "BDSurvivorESP"
        highlight.Parent = character
        highlight.FillColor = Color3.fromRGB(0, 255, 0) -- Hijau
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.FillTransparency = 0.5
        highlight.Enabled = EspEnabled
    end
end

-- Update Loop
RunService.RenderStepped:Connect(function()
    if EspEnabled then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= Players.LocalPlayer and p.Character then
                local hl = p.Character:FindFirstChild("BDSurvivorESP")
                if not hl then
                    ApplyEsp(p.Character)
                else
                    hl.Enabled = true
                end
            end
        end
    else
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("BDSurvivorESP") then
                p.Character.BDSurvivorESP.Enabled = false
            end
        end
    end
end)

EspBtn.MouseButton1Click:Connect(function()
    EspEnabled = not EspEnabled
    if EspEnabled then
        EspBtn.Text = "ESP Survivor: ON"
        EspBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50) -- Hijau (Aktif)
    else
        EspBtn.Text = "ESP Survivor: OFF"
        EspBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50) -- Merah (Mati)
    end
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