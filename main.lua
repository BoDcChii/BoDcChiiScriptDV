-- [[ BoDcChii Project - v5.4: Survivor & Killer ESP 🎸 ]] --

local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

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
OpenButton.TextColor3 = Color3.fromRGB(255, 105, 180) -- Pink
OpenButton.TextSize = 24
OpenButton.Font = Enum.Font.SourceSansBold
OpenButton.ZIndex = 500
Instance.new("UICorner", OpenButton).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", OpenButton).Color = Color3.fromRGB(255, 105, 180)

-- --- 2. HALAMAN MENU ---
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 240, 0, 220) -- Tinggi ditambah sedikit
MainFrame.Position = UDim2.new(0.5, -120, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Visible = false
MainFrame.Active = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(255, 105, 180)

local Header = Instance.new("TextLabel", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 40)
Header.Text = "BoDcChii Project"; Header.TextColor3 = Color3.new(1, 1, 1)
Header.BackgroundTransparency = 1; Header.Font = Enum.Font.SourceSansBold; Header.TextSize = 18

local Line = Instance.new("Frame", MainFrame)
Line.Size = UDim2.new(0.9, 0, 0, 2); Line.Position = UDim2.new(0.05, 0, 0, 40)
Line.BackgroundColor3 = Color3.fromRGB(255, 105, 180); Line.BorderSizePixel = 0

-- --- 3. LOGIKA ESP SURVIVOR & KILLER ---
local survActive = false
local killActive = false

local function CreateESP(char, color, labelName)
    local root = char:FindFirstChild("HumanoidRootPart")
    if root and not root:FindFirstChild("BochiESP_" .. labelName) then
        local bill = Instance.new("BillboardGui")
        bill.Name = "BochiESP_" .. labelName
        bill.Size = UDim2.new(0, 100, 0, 40)
        bill.AlwaysOnTop = true
        bill.Adornee = root
        bill.Parent = root

        local txt = Instance.new("TextLabel", bill)
        txt.Size = UDim2.new(1, 0, 1, 0)
        txt.BackgroundTransparency = 1
        txt.Text = labelName
        txt.TextColor3 = color
        txt.TextStrokeTransparency = 0
        txt.Font = Enum.Font.SourceSansBold
        txt.TextScaled = true
    end
end

-- Looping Scan Karakter
task.spawn(function()
    while true do
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                -- Logika ESP Survivor (Warna Hijau)
                if survActive then
                    CreateESP(p.Character, Color3.fromRGB(0, 255, 100), "SURVIVOR")
                end
                
                -- Logika ESP Killer (Warna Merah & Deteksi Senjata)
                -- Catatan: Biasanya Killer punya model berbeda atau memegang Tool tertentu
                if killActive then
                    local isKiller = p.Character:FindFirstChildOfClass("Tool") or p.Name:lower():find("killer")
                    if isKiller then
                        CreateESP(p.Character, Color3.fromRGB(255, 50, 50), "KILLER")
                    end
                end
            end
        end
        
        -- Hapus jika fitur dimatikan
        if not survActive or not killActive then
            for _, v in pairs(workspace:GetDescendants()) do
                if (not survActive and v.Name == "BochiESP_SURVIVOR") or (not killActive and v.Name == "BochiESP_KILLER") then
                    v:Destroy()
                end
            end
        end
        task.wait(2)
    end
end)

-- --- 4. TOMBOL-TOMBOL ---
local SurvBtn = Instance.new("TextButton", MainFrame)
SurvBtn.Size = UDim2.new(0.9, 0, 0, 45); SurvBtn.Position = UDim2.new(0.05, 0, 0, 60)
SurvBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
SurvBtn.Text = "ESP Survivor: OFF"; SurvBtn.TextColor3 = Color3.new(1, 1, 1)
SurvBtn.Font = Enum.Font.SourceSansBold; Instance.new("UICorner", SurvBtn)

local KillBtn = Instance.new("TextButton", MainFrame)
KillBtn.Size = UDim2.new(0.9, 0, 0, 45); KillBtn.Position = UDim2.new(0.05, 0, 0, 115)
KillBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
KillBtn.Text = "ESP Killer: OFF"; KillBtn.TextColor3 = Color3.new(1, 1, 1)
KillBtn.Font = Enum.Font.SourceSansBold; Instance.new("UICorner", KillBtn)

SurvBtn.MouseButton1Click:Connect(function()
    survActive = not survActive
    SurvBtn.BackgroundColor3 = survActive and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(180, 50, 50)
    SurvBtn.Text = survActive and "ESP Survivor: ON" or "ESP Survivor: OFF"
end)

KillBtn.MouseButton1Click:Connect(function()
    killActive = not killActive
    KillBtn.BackgroundColor3 = killActive and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(180, 50, 50)
    KillBtn.Text = killActive and "ESP Killer: ON" or "ESP Killer: OFF"
end)

-- --- 5. SISTEM KONTROL ---
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