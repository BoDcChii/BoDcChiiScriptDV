-- [[ BoDcChii Project - v2.2: Multi-ESP & Layout Fix 🎸 ]] --

local UserInputService = game:GetService("UserInputService")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BoDcChii_Final_v2_2"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- --- FUNGSI DRAG ---
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

-- --- 5. CONTAINER TOMBOL (BIAR GAK KETUMPUK) ---
local ButtonHolder = Instance.new("Frame", MainFrame)
ButtonHolder.Position = UDim2.new(0, 90, 0, 45); ButtonHolder.Size = UDim2.new(1, -100, 1, -55)
ButtonHolder.BackgroundTransparency = 1

local Layout = Instance.new("UIListLayout", ButtonHolder)
Layout.Padding = UDim.new(0, 10); Layout.SortOrder = Enum.SortOrder.LayoutOrder

-- --- 6. LOGIKA MULTI-ESP ---
local genActive = false
local palActive = false

task.spawn(function()
    while true do
        for _, v in pairs(game.Workspace:GetDescendants()) do
            -- LOGIKA SEMUA GENERATOR
            if genActive and (v.Name:lower():find("generator") or v.Name:lower():find("gen")) and (v:IsA("Model") or v:IsA("BasePart")) then
                if not v:FindFirstChild("Gen_ESP") then
                    local h = Instance.new("Highlight", v); h.Name = "Gen_ESP"; h.FillColor = Color3.fromRGB(0, 255, 255); h.AlwaysOnTop = true
                end
            elseif not genActive and v.Name == "Gen_ESP" then v:Destroy() end

            -- LOGIKA SEMUA PALLET
            if palActive and v.Name:lower():find("pallet") and (v:IsA("Model") or v:IsA("BasePart")) then
                if not v:FindFirstChild("Pal_ESP") then
                    local h = Instance.new("Highlight", v); h.Name = "Pal_ESP"; h.FillColor = Color3.fromRGB(255, 255, 0); h.AlwaysOnTop = true
                end
            elseif not palActive and v.Name == "Pal_ESP" then v:Destroy() end
        end
        task.wait(1.5) -- Scan lebih cepat
    end
end)

-- --- 7. TOMBOL-TOMBOL ---
local function CreateToggle(text, callback)
    local b = Instance.new("TextButton", ButtonHolder)
    b.Size = UDim2.new(1, 0, 0, 40); b.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    b.Text = text..": OFF"; b.TextColor3 = Color3.new(1, 1, 1); b.Font = Enum.Font.SourceSansBold
    Instance.new("UICorner", b)
    
    local state = false
    b.MouseButton1Click:Connect(function()
        state = not state
        b.BackgroundColor3 = state and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(180, 50, 50)
        b.Text = state and text..": ON" or text..": OFF"
        callback(state)
    end)
end

CreateToggle("1. ESP Generator", function(s) genActive = s end)
CreateToggle("2. ESP Pallet", function(s) palActive = s end)

-- EXIT
local Exit = Instance.new("TextButton", MainFrame)
Exit.Size = UDim2.new(0, 25, 0, 25); Exit.Position = UDim2.new(1, -30, 0, 5); Exit.Text = "X"
Exit.BackgroundColor3 = Color3.new(1, 0, 0); Exit.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
Instance.new("UICorner", Exit).CornerRadius = UDim.new(1, 0)