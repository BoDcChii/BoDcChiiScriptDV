-- [[ BoDcChii Project - v2.3: Super Aggressive ESP 🎸 ]] --

local UserInputService = game:GetService("UserInputService")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BoDcChii_Final_v2_3"
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

-- --- 1. ICON BOCCHI ---
local OpenIcon = Instance.new("ImageButton", ScreenGui)
OpenIcon.Size = UDim2.new(0, 45, 0, 45); OpenIcon.Position = UDim2.new(0, 20, 0.5, 0)
OpenIcon.BackgroundColor3 = Color3.fromRGB(20, 20, 20); OpenIcon.Image = "rbxassetid://12130312683"
OpenIcon.ZIndex = 500
Instance.new("UICorner", OpenIcon).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", OpenIcon).Color = Color3.fromRGB(255, 105, 180)
MakeDraggable(OpenIcon)

-- --- 2. MAIN FRAME ---
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 280, 0, 220); MainFrame.Position = UDim2.new(0.5, -140, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15); MainFrame.Visible = false; MainFrame.Active = true
Instance.new("UICorner", MainFrame); Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(255, 105, 180)
MakeDraggable(MainFrame)

OpenIcon.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- --- 3. SIDEBAR ---
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 80, 1, 0); Sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
local TabLabel = Instance.new("TextLabel", Sidebar)
TabLabel.Size = UDim2.new(1, 0, 0, 45); TabLabel.Text = "1. Player"; TabLabel.TextColor3 = Color3.new(1, 1, 1)
TabLabel.BackgroundColor3 = Color3.fromRGB(45, 45, 45); TabLabel.Font = Enum.Font.SourceSansBold

-- --- 4. BUTTON HOLDER ---
local ButtonHolder = Instance.new("Frame", MainFrame)
ButtonHolder.Position = UDim2.new(0, 90, 0, 45); ButtonHolder.Size = UDim2.new(1, -100, 1, -55)
ButtonHolder.BackgroundTransparency = 1
local Layout = Instance.new("UIListLayout", ButtonHolder)
Layout.Padding = UDim.new(0, 10); Layout.SortOrder = Enum.SortOrder.LayoutOrder

-- --- 5. LOGIKA ESP AGRESIF ---
local genActive = false
local palActive = false

-- Fungsi untuk memberi cahaya ke objek
local function CreateHighlight(obj, name, color)
    if not obj:FindFirstChild(name) then
        local h = Instance.new("Highlight")
        h.Parent = obj
        h.Name = name
        h.FillColor = color
        h.OutlineColor = Color3.new(1, 1, 1)
        h.FillTransparency = 0.5
        h.AlwaysOnTop = true
    end
end

-- Loop pencarian
task.spawn(function()
    while true do
        if genActive or palActive then
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if v:IsA("Model") or v:IsA("BasePart") then
                    local name = v.Name:lower()
                    
                    -- Pencarian Generator (Cari kata 'gen', 'motor', atau 'engine')
                    if genActive and (name:find("gen") or name:find("motor") or name:find("engine")) then
                        CreateHighlight(v, "Gen_ESP", Color3.fromRGB(0, 255, 255))
                    end
                    
                    -- Pencarian Pallet (Cari kata 'pallet' atau 'board')
                    if palActive and (name:find("pallet") or name:find("board")) then
                        CreateHighlight(v, "Pal_ESP", Color3.fromRGB(255, 255, 0))
                    end
                end
            end
        else
            -- Hapus jika OFF
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if v.Name == "Gen_ESP" or v.Name == "Pal_ESP" then v:Destroy() end
            end
        end
        task.wait(2)
    end
end)

-- --- 6. TOMBOL TOGGLE ---
local function CreateToggle(text, callback)
    local b = Instance.new("TextButton", ButtonHolder)
    b.Size = UDim2.new(1, 0, 0, 45); b.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    b.Text = text..": OFF"; b.TextColor3 = Color3.new(1, 1, 1); b.Font = Enum.Font.SourceSansBold
    Instance.new("UICorner", b)
    
    local state = false
    b.MouseButton1Click:Connect(function()
        state = not state
        b.BackgroundColor3 = state and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(180, 50, 50)
        b.Text = state and text..": ON" or text..": OFF"
        callback(state)
        
        -- Hapus instan kalau di OFF kan
        if not state then
            local targetName = (text:find("Generator") and "Gen_ESP" or "Pal_ESP")
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if v.Name == targetName then v:Destroy() end
            end
        end
    end)
end

CreateToggle("1. ESP Generator", function(s) genActive = s end)
CreateToggle("2. ESP Pallet", function(s) palActive = s end)

-- EXIT
local Exit = Instance.new("TextButton", MainFrame)
Exit.Size = UDim2.new(0, 25, 0, 25); Exit.Position = UDim2.new(1, -30, 0, 5); Exit.Text = "X"
Exit.BackgroundColor3 = Color3.new(1, 0, 0); Exit.TextColor3 = Color3.new(1, 1, 1)
Exit.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
Instance.new("UICorner", Exit).CornerRadius = UDim.new(1, 0)