-- [[ BoDcChii Project - v5.7: Azure Core Edition 🎸 ]] --

local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")

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
local IconStroke = Instance.new("UIStroke", OpenButton)
IconStroke.Color = Color3.fromRGB(255, 105, 180); IconStroke.Thickness = 2

-- --- 2. HALAMAN FITUR ---
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 240, 0, 280) -- Ukuran disesuaikan untuk 4 tombol
MainFrame.Position = UDim2.new(0.5, -120, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Visible = false
MainFrame.Active = true

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
local FrameStroke = Instance.new("UIStroke", MainFrame)
FrameStroke.Color = Color3.fromRGB(255, 105, 180); FrameStroke.Thickness = 2

local Header = Instance.new("TextLabel", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 40)
Header.Text = "BoDcChii Project"; Header.TextColor3 = Color3.new(1, 1, 1)
Header.BackgroundTransparency = 1; Header.Font = Enum.Font.SourceSansBold; Header.TextSize = 18

local Line = Instance.new("Frame", MainFrame)
Line.Size = UDim2.new(0.9, 0, 0, 2); Line.Position = UDim2.new(0.05, 0, 0, 40)
Line.BackgroundColor3 = Color3.fromRGB(255, 105, 180); Line.BorderSizePixel = 0

-- --- 3. CORE LOGIC (ESP & WORLD) ---
local killerESP = false
local survivorESP = false
local genESP = false
local fullBright = false

local function CreateESP(target, textName, color, tag)
    if not target then return end
    local name = "BochiESP_" .. tag
    if not target:FindFirstChild(name) then
        local bill = Instance.new("BillboardGui")
        bill.Name = name; bill.Size = UDim2.new(0, 100, 0, 40)
        bill.AlwaysOnTop = true; bill.Adornee = target; bill.Parent = target

        local text = Instance.new("TextLabel", bill)
        text.Size = UDim2.new(1, 0, 1, 0); text.BackgroundTransparency = 1
        text.Text = textName; text.TextColor3 = color
        text.TextStrokeTransparency = 0; text.Font = Enum.Font.SourceSansBold; text.TextScaled = true
    end
end

-- Looping Sistem Utama
task.spawn(function()
    while true do
        -- ESP Player
        if killerESP or survivorESP then
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= Players.LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
                    local char = plr.Character
                    if killerESP and char:FindFirstChildOfClass("Tool") then
                        CreateESP(char.Head, "KILLER", Color3.fromRGB(255, 0, 0), "P")
                    elseif survivorESP and not char:FindFirstChildOfClass("Tool") then
                        CreateESP(char.Head, "SURVIVOR", Color3.fromRGB(0, 255, 0), "P")
                    end
                end
            end
        end

        -- ESP Generator (Logic Azure Hub)
        if genESP then
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("ProximityPrompt") and (v.ObjectText:find("Gen") or v.ActionText:find("Repair")) then
                    local p = v.Parent:IsA("BasePart") and v.Parent or v.Parent:FindFirstChildWhichIsA("BasePart", true)
                    if p then CreateESP(p, "GENERATOR", Color3.fromRGB(0, 255, 255), "G") end
                end
            end
        end

        -- Fullbright Logic
        if fullBright then
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = false
        end

        -- Cleanup
        if not (killerESP or survivorESP or genESP) then
            for _, v in pairs(workspace:GetDescendants()) do
                if v.Name:find("BochiESP_") then v:Destroy() end
            end
        end
        task.wait(2)
    end
end)

-- --- 4. TOMBOL-TOMBOL ---
local function AddButton(txt, yPos, colorOn)
    local btn = Instance.new("TextButton", MainFrame)
    btn.Size = UDim2.new(0.9, 0, 0, 40); btn.Position = UDim2.new(0.05, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(180, 50, 50); btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Text = txt .. ": OFF"; btn.Font = Enum.Font.SourceSansBold; Instance.new("UICorner", btn)
    return btn
end

local btnK = AddButton("ESP Killer", 55)
local btnS = AddButton("ESP Survivor", 105)
local btnG = AddButton("ESP Generator", 155)
local btnF = AddButton("Fullbright", 205)

btnK.MouseButton1Click:Connect(function()
    killerESP = not killerESP
    btnK.Text = "ESP Killer: " .. (killerESP and "ON" or "OFF")
    btnK.BackgroundColor3 = killerESP and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(180, 50, 50)
end)

btnS.MouseButton1Click:Connect(function()
    survivorESP = not survivorESP
    btnS.Text = "ESP Survivor: " .. (survivorESP and "ON" or "OFF")
    btnS.BackgroundColor3 = survivorESP and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(180, 50, 50)
end)

btnG.MouseButton1Click:Connect(function()
    genESP = not genESP
    btnG.Text = "ESP Generator: " .. (genESP and "ON" or "OFF")
    btnG.BackgroundColor3 = genESP and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(180, 50, 50)
end)

btnF.MouseButton1Click:Connect(function()
    fullBright = not fullBright
    btnF.Text = "Fullbright: " .. (fullBright and "ON" or "OFF")
    btnF.BackgroundColor3 = fullBright and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(180, 50, 50)
    if not fullBright then Lighting.Brightness = 1; Lighting.GlobalShadows = true end
end)

-- --- 5. SISTEM MENU (OPEN/EXIT/DRAG) ---
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