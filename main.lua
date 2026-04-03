-- [[ BoDcChii Project - v2.0: Generator & Pallet ESP 🎸 ]] --

local UserInputService = game:GetService("UserInputService")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BoDcChii_Final_v2"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- --- FUNGSI GESER ---
local function MakeDraggable(obj)
    local dragging, dragInput, dragStart, startPos
    obj.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            dragging = true; dragStart = input.Position; startPos = obj.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    obj.InputChanged:Connect(function(input) if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then dragInput = input end end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- --- 1. WELCOME ---
local Welcome = Instance.new("TextLabel", ScreenGui)
Welcome.Size = UDim2.new(1, 0, 0, 50); Welcome.Position = UDim2.new(0, 0, 0.4, 0)
Welcome.Text = "Welcome by @BoDcChii 😈"; Welcome.TextColor3 = Color3.fromRGB(255, 105, 180)
Welcome.BackgroundTransparency = 1; Welcome.TextSize = 30
task.delay(2, function() Welcome:Destroy() end)

-- --- 2. ICON BOCCHI ---
local OpenIcon = Instance.new("ImageButton", ScreenGui)
OpenIcon.Size = UDim2.new(0, 45, 0, 45); OpenIcon.Position = UDim2.new(0, 20, 0.5, 0)
OpenIcon.BackgroundColor3 = Color3.fromRGB(20, 20, 20); OpenIcon.Image = "rbxassetid://12130312683"
OpenIcon.ZIndex = 500
Instance.new("UICorner", OpenIcon).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", OpenIcon).Color = Color3.fromRGB(255, 105, 180)
MakeDraggable(OpenIcon)

-- --- 3. MAIN FRAME ---
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 280, 0, 220); MainFrame.Position = UDim2.new(0.5, -140, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15); MainFrame.Visible = false; MainFrame.Active = true
Instance.new("UICorner", MainFrame); Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(255, 105, 180)
MakeDraggable(MainFrame)

OpenIcon.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- --- 4. SIDEBAR ---
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 80, 1, 0); Sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
local TabLabel = Instance.new("TextLabel", Sidebar)
TabLabel.Size = UDim2.new(1, 0, 0, 45); TabLabel.Text = "1. Player"; TabLabel.TextColor3 = Color3.new(1, 1, 1)
TabLabel.BackgroundColor3 = Color3.fromRGB(45, 45, 45); TabLabel.Font = Enum.Font.SourceSansBold

-- --- 5. LOGIKA ESP ---
local genESPActive = false
local palletESPActive = false

local function ApplyESP(obj, name, color)
    if not obj:FindFirstChild(name) then
        local h = Instance.new("Highlight", obj)
        h.Name = name; h.FillColor = color
        h.OutlineColor = Color3.new(1, 1, 1)
        h.AlwaysOnTop = true
    end
end

local function RemoveESP(name)
    for _, v in pairs(game.Workspace:GetDescendants()) do
        if v.Name == name and v:IsA("Highlight") then v:Destroy() end
    end
end

task.spawn(function()
    while true do
        if genESPActive then
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if (v.Name:lower():find("generator") or v.Name:lower():find("gen")) and (v:IsA("Model") or v:IsA("BasePart")) then
                    ApplyESP(v, "Gen_ESP", Color3.fromRGB(0, 255, 255))
                end
            end
        else RemoveESP("Gen_ESP") end
        
        if palletESPActive then
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if v.Name:lower():find("pallet") and (v:IsA("Model") or v:IsA("BasePart")) then
                    ApplyESP(v, "Pallet_ESP", Color3.fromRGB(255, 255, 0)) -- Kuning untuk Pallet
                end
            end
        else RemoveESP("Pallet_ESP") end
        
        task.wait(2.5)
    end
end)

-- --- 6. TOMBOL-TOMBOL ---

-- TOMBOL ESP GENERATOR
local BtnGen = Instance.new("TextButton", MainFrame)
BtnGen.Size = UDim2.new(0, 180, 0, 40); BtnGen.Position = UDim2.new(0, 90, 0, 50)
BtnGen.BackgroundColor3 = Color3.fromRGB(180, 50, 50); BtnGen.Text = "1. ESP Generator: OFF"
BtnGen.TextColor3 = Color3.new(1, 1, 1); BtnGen.Font = Enum.Font.SourceSansBold; Instance.new("UICorner", BtnGen)

BtnGen.MouseButton1Click:Connect(function()
    genESPActive = not genESPActive
    BtnGen.BackgroundColor3 = genESPActive and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(180, 50, 50)
    BtnGen.Text = genESPActive and "1. ESP Generator: ON" or "1. ESP Generator: OFF"
end)

-- TOMBOL ESP PALLET
local BtnPallet = Instance.new("TextButton", MainFrame)
BtnPallet.Size = UDim2.new(0, 180, 0, 40); BtnPallet.Position = UDim2.new(0, 90, 0, 100)
BtnPallet.BackgroundColor3 = Color3.fromRGB(180, 50, 50); BtnPallet.Text = "2. ESP Pallet: OFF"
BtnPallet.TextColor3 = Color3.new(1, 1, 1); BtnPallet.Font = Enum.Font.SourceSansBold; Instance.new("UICorner", BtnPallet)

BtnPallet.MouseButton1Click:Connect(function()
    palletESPActive = not palletESPActive
    BtnPallet.BackgroundColor3 = palletESPActive and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(180, 50, 50)
    BtnPallet.Text = palletESPActive and "2. ESP Pallet: ON" or "2. ESP Pallet: OFF"
end)

-- EXIT (X)
local Exit = Instance.new("TextButton", MainFrame)
Exit.Size = UDim2.new(0, 30, 0, 30); Exit.Position = UDim2.new(1, -35, 0, 5); Exit.Text = "X"
Exit.BackgroundColor3 = Color3.new(1, 0, 0); Exit.TextColor3 = Color3.new(1, 1, 1)
Exit.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
Instance.new("UICorner", Exit).CornerRadius = UDim.new(1, 0)
