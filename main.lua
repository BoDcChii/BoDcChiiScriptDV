-- [[ BoDcChii Project - v5.8: Azure Optimized 🎸 ]] --

local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")

-- 1. CLEANUP & INITIALIZATION
if CoreGui:FindFirstChild("BoDcChii_Minimalist") then
    CoreGui.BoDcChii_Minimalist:Destroy()
end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "BoDcChii_Minimalist"
ScreenGui.ResetOnSpawn = false

-- --- 2. GUI: ICON "BD" ---
local OpenButton = Instance.new("TextButton", ScreenGui)
OpenButton.Size = UDim2.new(0, 50, 0, 50); OpenButton.Position = UDim2.new(0, 20, 0.5, -25)
OpenButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30); OpenButton.Text = "BD"
OpenButton.TextColor3 = Color3.fromRGB(255, 105, 180); OpenButton.TextSize = 24
OpenButton.Font = Enum.Font.SourceSansBold; OpenButton.ZIndex = 500
Instance.new("UICorner", OpenButton).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", OpenButton).Color = Color3.fromRGB(255, 105, 180)

-- --- 3. GUI: MAIN MENU (v4.1 Style) ---
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 240, 0, 280); MainFrame.Position = UDim2.new(0.5, -120, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15); MainFrame.Visible = false
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(255, 105, 180)

local Header = Instance.new("TextLabel", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 40); Header.Text = "BoDcChii Project v5.8"; Header.TextColor3 = Color3.new(1, 1, 1)
Header.BackgroundTransparency = 1; Header.Font = Enum.Font.SourceSansBold; Header.TextSize = 18

local Line = Instance.new("Frame", MainFrame)
Line.Size = UDim2.new(0.9, 0, 0, 2); Line.Position = UDim2.new(0.05, 0, 0, 40)
Line.BackgroundColor3 = Color3.fromRGB(255, 105, 180); Line.BorderSizePixel = 0

-- --- 4. CORE ESP LOGIC ---
local killerESP, survivorESP, genESP, fullBright = false, false, false, false

local function ApplyESP(obj, text, color, id)
    if not obj then return end
    local tag = "BD_ESP_" .. id
    if not obj:FindFirstChild(tag) then
        local bbg = Instance.new("BillboardGui", obj)
        bbg.Name = tag; bbg.Size = UDim2.new(0, 80, 0, 20); bbg.AlwaysOnTop = true
        local txt = Instance.new("TextLabel", bbg)
        txt.Size = UDim2.new(1, 0, 1, 0); txt.BackgroundTransparency = 1
        txt.Text = text; txt.TextColor3 = color; txt.Font = Enum.Font.SourceSansBold
        txt.TextScaled = true; txt.TextStrokeTransparency = 0
    end
end

-- Looping Monitoring (Optimization: 1-2 detik per scan)
task.spawn(function()
    while true do
        -- PLAYER ESP
        if killerESP or survivorESP then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= Players.LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                    local isKiller = p.Character:FindFirstChildOfClass("Tool")
                    if killerESP and isKiller then
                        ApplyESP(p.Character.Head, "KILLER", Color3.new(1,0,0), "P")
                    elseif survivorESP and not isKiller then
                        ApplyESP(p.Character.Head, "SURVIVOR", Color3.new(0,1,0), "P")
                    end
                end
            end
        end

        -- GENERATOR ESP (Azure Logic)
        if genESP then
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("ProximityPrompt") and (v.ObjectText:find("Gen") or v.ActionText:find("Repair")) then
                    local target = v.Parent:IsA("BasePart") and v.Parent or v.Parent:FindFirstChildWhichIsA("BasePart", true)
                    if target then ApplyESP(target, "GENERATOR", Color3.new(0,1,1), "G") end
                end
            end
        end

        -- FULLBRIGHT
        if fullBright then
            Lighting.Brightness = 2; Lighting.ClockTime = 14; Lighting.FogEnd = 100000
        end

        task.wait(1.5)
    end
end)

-- --- 5. BUTTONS & UI LOGIC ---
local function MakeBtn(txt, y, toggle)
    local b = Instance.new("TextButton", MainFrame)
    b.Size = UDim2.new(0.9, 0, 0, 40); b.Position = UDim2.new(0.05, 0, 0, y)
    b.BackgroundColor3 = Color3.fromRGB(180, 50, 50); b.TextColor3 = Color3.new(1,1,1)
    b.Text = txt .. ": OFF"; b.Font = Enum.Font.SourceSansBold; Instance.new("UICorner", b)
    return b
end

local bK = MakeBtn("ESP Killer", 55); local bS = MakeBtn("ESP Survivor", 105)
local bG = MakeBtn("ESP Generator", 155); local bF = MakeBtn("Fullbright", 205)

bK.MouseButton1Click:Connect(function() killerESP = not killerESP; bK.Text = "ESP Killer: " .. (killerESP and "ON" or "OFF"); bK.BackgroundColor3 = killerESP and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(180, 50, 50) end)
bS.MouseButton1Click:Connect(function() survivorESP = not survivorESP; bS.Text = "ESP Survivor: " .. (survivorESP and "ON" or "OFF"); bS.BackgroundColor3 = survivorESP and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(180, 50, 50) end)
bG.MouseButton1Click:Connect(function() genESP = not genESP; bG.Text = "ESP Generator: " .. (genESP and "ON" or "OFF"); bG.BackgroundColor3 = genESP and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(180, 50, 50) end)
bF.MouseButton1Click:Connect(function() fullBright = not fullBright; bF.Text = "Fullbright: " .. (fullBright and "ON" or "OFF"); bF.BackgroundColor3 = fullBright and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(180, 50, 50) if not fullBright then Lighting.Brightness = 1 end end)

-- --- 6. DRAG & TOGGLE MENU ---
OpenButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
local Exit = Instance.new("TextButton", MainFrame)
Exit.Size = UDim2.new(0, 25, 0, 25); Exit.Position = UDim2.new(1, -30, 0, 7); Exit.Text = "X"
Exit.BackgroundColor3 = Color3.fromRGB(200, 50, 50); Instance.new("UICorner", Exit).CornerRadius = UDim.new(1, 0)
Exit.MouseButton1Click:Connect(function() MainFrame.Visible = false end)

local dragging, dragStart, startPos
OpenButton.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true; dragStart = input.Position; startPos = OpenButton.Position end end)
UIS.InputChanged:Connect(function(input) if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then local delta = input.Position - dragStart; OpenButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y) end end)
UIS.InputEnded:Connect(function(input) dragging = false end)