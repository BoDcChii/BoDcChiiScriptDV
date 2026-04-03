-- [[ BoDcChii Project - v2.4: Deep Scan & Box ESP 🎸 ]] --

local UserInputService = game:GetService("UserInputService")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BoDcChii_DeepScan_v2"
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

-- --- 1. MENU BASE ---
local OpenIcon = Instance.new("ImageButton", ScreenGui)
OpenIcon.Size = UDim2.new(0, 45, 0, 45); OpenIcon.Position = UDim2.new(0, 20, 0.5, 0)
OpenIcon.BackgroundColor3 = Color3.fromRGB(20, 20, 20); OpenIcon.Image = "rbxassetid://12130312683"
OpenIcon.ZIndex = 500
Instance.new("UICorner", OpenIcon).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", OpenIcon).Color = Color3.fromRGB(255, 105, 180)
MakeDraggable(OpenIcon)

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 280, 0, 220); MainFrame.Position = UDim2.new(0.5, -140, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15); MainFrame.Visible = false; MainFrame.Active = true
Instance.new("UICorner", MainFrame); Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(255, 105, 180)
MakeDraggable(MainFrame)

OpenIcon.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- --- 2. SIDEBAR & LAYOUT ---
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 80, 1, 0); Sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
local TabLabel = Instance.new("TextLabel", Sidebar)
TabLabel.Size = UDim2.new(1, 0, 0, 45); TabLabel.Text = "1. Player"; TabLabel.TextColor3 = Color3.new(1, 1, 1)
TabLabel.BackgroundColor3 = Color3.fromRGB(45, 45, 45); TabLabel.Font = Enum.Font.SourceSansBold

local ButtonHolder = Instance.new("Frame", MainFrame)
ButtonHolder.Position = UDim2.new(0, 90, 0, 45); ButtonHolder.Size = UDim2.new(1, -100, 1, -55)
ButtonHolder.BackgroundTransparency = 1
local Layout = Instance.new("UIListLayout", ButtonHolder); Layout.Padding = UDim.new(0, 10)

-- --- 3. LOGIKA ESP TERKUAT (BOX + HIGHLIGHT) ---
local genActive = false
local palActive = false

local function CreateESP(obj, name, color)
    if not obj:FindFirstChild(name) then
        -- 1. Cahaya (Highlight)
        local h = Instance.new("Highlight", obj)
        h.Name = name; h.FillColor = color; h.AlwaysOnTop = true
        
        -- 2. Kotak Neon (Box) - Backup jika Highlight gagal
        local b = Instance.new("BoxHandleAdornment", obj)
        b.Name = name.."_Box"; b.Adornee = obj; b.AlwaysOnTop = true
        b.ZIndex = 10; b.Size = (obj:IsA("Model") and obj:GetExtentsSize() or obj.Size)
        b.Color3 = color; b.Transparency = 0.6
    end
end

local function ClearESP(name)
    for _, v in pairs(game:GetDescendants()) do
        if v.Name == name or v.Name == name.."_Box" then v:Destroy() end
    end
end

task.spawn(function()
    while true do
        if genActive or palActive then
            -- Scan Workspace secara menyeluruh
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Model") or v:IsA("BasePart") then
                    local lowName = v.Name:lower()
                    -- Cek Generator
                    if genActive and (lowName:find("gen") or lowName:find("motor") or lowName:find("engine") or lowName:find("machine")) then
                        CreateESP(v, "Bocchi_Gen", Color3.fromRGB(0, 255, 255))
                    end
                    -- Cek Pallet
                    if palActive and (lowName:find("pallet") or lowName:find("board") or lowName:find("wood")) then
                        CreateESP(v, "Bocchi_Pal", Color3.fromRGB(255, 255, 0))
                    end
                end
            end
        end
        task.wait(3)
    end
end)

-- --- 4. TOMBOL TOGGLE ---
local function CreateToggle(text, callback, espName)
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
        if not state then ClearESP(espName) end
    end)
end

CreateToggle("1. ESP Generator", function(s) genActive = s end, "Bocchi_Gen")
CreateToggle("2. ESP Pallet", function(s) palActive = s end, "Bocchi_Pal")

-- EXIT
local Exit = Instance.new("TextButton", MainFrame)
Exit.Size = UDim2.new(0, 25, 0, 25); Exit.Position = UDim2.new(1, -30, 0, 5); Exit.Text = "X"
Exit.BackgroundColor3 = Color3.new(1, 0, 0); Exit.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
Instance.new("UICorner", Exit).CornerRadius = UDim.new(1, 0)