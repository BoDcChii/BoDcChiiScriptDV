-- [[ BoDcChii Project - v5.5: Killer & Survivor ESP 🎸 ]] --

local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
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
OpenButton.TextColor3 = Color3.fromRGB(255, 105, 180) -- Warna Pink
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
MainFrame.Size = UDim2.new(0, 240, 0, 220) -- Tinggi ditambah untuk tombol baru
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
Header.Text = "BoDcChii Project"; Header.TextColor3 = Color3.new(1, 1, 1)
Header.BackgroundTransparency = 1; Header.Font = Enum.Font.SourceSansBold; Header.TextSize = 18

local Line = Instance.new("Frame", MainFrame)
Line.Size = UDim2.new(0.9, 0, 0, 2); Line.Position = UDim2.new(0.05, 0, 0, 40)
Line.BackgroundColor3 = Color3.fromRGB(255, 105, 180); Line.BorderSizePixel = 0

-- --- 3. ESP SYSTEM (LOGIKA KILLER & SURVIVOR) ---
local killerESP = false
local survivorESP = false

local function CreateESP(char, textName, color)
    if not char then return end
    local head = char:FindFirstChild("Head")
    if not head then return end
    
    if not head:FindFirstChild("BochiESP") then
        local bill = Instance.new("BillboardGui")
        bill.Name = "BochiESP"
        bill.Size = UDim2.new(0,100,0,40)
        bill.AlwaysOnTop = true
        bill.Adornee = head
        bill.Parent = head -- Menempel langsung di kepala agar stabil

        local text = Instance.new("TextLabel")
        text.Parent = bill
        text.Size = UDim2.new(1,0,1,0)
        text.BackgroundTransparency = 1
        text.Text = textName
        text.TextColor3 = color
        text.TextStrokeTransparency = 0
        text.TextScaled = true
        text.Font = Enum.Font.SourceSansBold
    end
end

local function ClearESP()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr.Character then
            local head = plr.Character:FindFirstChild("Head")
            if head and head:FindFirstChild("BochiESP") then
                head.BochiESP:Destroy()
            end
        end
    end
end

-- Looping Utama
task.spawn(function()
    while true do
        if killerESP or survivorESP then
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= Players.LocalPlayer and plr.Character then
                    local char = plr.Character
                    if char:FindFirstChild("Humanoid") then
                        -- Deteksi Killer (Punya Tool)
                        if killerESP and char:FindFirstChildOfClass("Tool") then
                            CreateESP(char, "KILLER", Color3.fromRGB(255,0,0))
                        -- Deteksi Survivor (Tidak punya Tool)
                        elseif survivorESP and not char:FindFirstChildOfClass("Tool") then
                            CreateESP(char, "SURVIVOR", Color3.fromRGB(0,255,0))
                        end
                    end
                end
            end
        else
            ClearESP()
        end
        task.wait(1)
    end
end)

-- --- 4. TOMBOL TOGGLE ---
local KillBtn = Instance.new("TextButton", MainFrame)
KillBtn.Size = UDim2.new(0.9, 0, 0, 45); KillBtn.Position = UDim2.new(0.05, 0, 0, 60)
KillBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
KillBtn.Text = "ESP Killer: OFF"; KillBtn.TextColor3 = Color3.new(1, 1, 1)
KillBtn.Font = Enum.Font.SourceSansBold; Instance.new("UICorner", KillBtn)

local SurvBtn = Instance.new("TextButton", MainFrame)
SurvBtn.Size = UDim2.new(0.9, 0, 0, 45); SurvBtn.Position = UDim2.new(0.05, 0, 0, 115)
SurvBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
SurvBtn.Text = "ESP Survivor: OFF"; SurvBtn.TextColor3 = Color3.new(1, 1, 1)
SurvBtn.Font = Enum.Font.SourceSansBold; Instance.new("UICorner", SurvBtn)

KillBtn.MouseButton1Click:Connect(function()
    killerESP = not killerESP
    KillBtn.BackgroundColor3 = killerESP and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(180, 50, 50)
    KillBtn.Text = killerESP and "ESP Killer: ON" or "ESP Killer: OFF"
end)

SurvBtn.MouseButton1Click:Connect(function()
    survivorESP = not survivorESP
    SurvBtn.BackgroundColor3 = survivorESP and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(180, 50, 50)
    SurvBtn.Text = survivorESP and "ESP Survivor: ON" or "ESP Survivor: OFF"
end)

-- --- 5. LOGIKA BUKA/TUTUP & DRAG ---
OpenButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

local Exit = Instance.new("TextButton", MainFrame)
Exit.Size = UDim2.new(0, 25, 0, 25); Exit.Position = UDim2.new(1, -30, 0, 7); Exit.Text = "X"
Exit.BackgroundColor3 = Color3.fromRGB(200, 50, 50); Instance.new("UICorner", Exit).CornerRadius = UDim.new(1, 0)
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