-- [[ BoDcChii Project - v2.5: Violence District Special 🎸 ]] --

local UserInputService = game:GetService("UserInputService")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BoDcChii_Violence_Fix"
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

-- --- 1. WELCOME (BACK!) ---
local Welcome = Instance.new("TextLabel", ScreenGui)
Welcome.Size = UDim2.new(1, 0, 0, 60); Welcome.Position = UDim2.new(0, 0, 0.4, 0)
Welcome.BackgroundColor3 = Color3.new(0, 0, 0); Welcome.BackgroundTransparency = 0.5
Welcome.Text = "Welcome by @BoDcChii 😈"; Welcome.TextColor3 = Color3.fromRGB(255, 105, 180)
Welcome.TextSize = 35; Welcome.ZIndex = 1000
task.delay(2.5, function() Welcome:Destroy() end)

-- --- 2. ICON & MAIN FRAME ---
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

-- --- 3. SIDEBAR & BUTTONS ---
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 80, 1, 0); Sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
local TabLabel = Instance.new("TextLabel", Sidebar)
TabLabel.Size = UDim2.new(1, 0, 0, 45); TabLabel.Text = "1. Player"; TabLabel.TextColor3 = Color3.new(1, 1, 1)
TabLabel.BackgroundColor3 = Color3.fromRGB(45, 45, 45); TabLabel.Font = Enum.Font.SourceSansBold

local ButtonHolder = Instance.new("Frame", MainFrame)
ButtonHolder.Position = UDim2.new(0, 90, 0, 45); ButtonHolder.Size = UDim2.new(1, -100, 1, -55)
ButtonHolder.BackgroundTransparency = 1
local Layout = Instance.new("UIListLayout", ButtonHolder); Layout.Padding = UDim.new(0, 10)

-- --- 4. LOGIKA ESP VIOLENCE DISTRICT ---
local genActive, palActive = false, false

local function CreateViolenceESP(obj, name, color, labelText)
    if not obj:FindFirstChild(name) then
        -- Box ESP (Neon Kotak)
        local b = Instance.new("BoxHandleAdornment", obj)
        b.Name = name; b.Adornee = obj; b.AlwaysOnTop = true; b.ZIndex = 5
        b.Size = (obj:IsA("Model") and obj:GetExtentsSize() or obj.Size)
        b.Color3 = color; b.Transparency = 0.7
        
        -- Text ESP (Nama Melayang)
        local bill = Instance.new("BillboardGui", obj)
        bill.Name = name.."_Label"; bill.Size = UDim2.new(0, 100, 0, 50); bill.AlwaysOnTop = true; bill.ExtentsOffset = Vector3.new(0, 3, 0)
        local txt = Instance.new("TextLabel", bill)
        txt.Size = UDim2.new(1, 0, 1, 0); txt.BackgroundTransparency = 1; txt.Text = labelText
        txt.TextColor3 = color; txt.TextStrokeTransparency = 0; txt.TextSize = 14; txt.Font = Enum.Font.SourceSansBold
    end
end

local function ClearViolenceESP(name)
    for _, v in pairs(game.Workspace:GetDescendants()) do
        if v.Name == name or v.Name == name.."_Label" then v:Destroy() end
    end
end

task.spawn(function()
    while true do
        if genActive or palActive then
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if v:IsA("Model") or v:IsA("BasePart") then
                    local n = v.Name:lower()
                    -- Cek Generator di Violence District
                    if genActive and (n:find("generator") or n:find("gen") or n:find("engine")) then
                        CreateViolenceESP(v, "VD_Gen", Color3.fromRGB(0, 255, 255), "GENERATOR")
                    end
                    -- Cek Pallet di Violence District
                    if palActive and (n:find("pallet") or n:find("wood") or n:find("board")) then
                        CreateViolenceESP(v, "VD_Pal", Color3.fromRGB(255, 255, 0), "PALLET")
                    end
                end
            end
        end
        task.wait(4) -- Scan stabil untuk HP
    end
end)

-- --- 5. TOMBOL TOGGLE (HIJAU/MERAH) ---
local function CreateBtn(txt, callback, espName)
    local b = Instance.new("TextButton", ButtonHolder)
    b.Size = UDim2.new(1, 0, 0, 45); b.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    b.Text = txt..": OFF"; b.TextColor3 = Color3.new(1, 1, 1); b.Font = Enum.Font.SourceSansBold; Instance.new("UICorner", b)
    local s = false
    b.MouseButton1Click:Connect(function()
        s = not s
        b.BackgroundColor3 = s and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(180, 50, 50)
        b.Text = s and txt..": ON" or txt..": OFF"
        callback(s)
        if not s then ClearViolenceESP(espName) end
    end)
end

CreateBtn("1. ESP Generator", function(s) genActive = s end, "VD_Gen")
CreateBtn("2. ESP Pallet", function(s) palActive = s end, "VD_Pal")

-- EXIT
local Exit = Instance.new("TextButton", MainFrame)
Exit.Size = UDim2.new(0, 25, 0, 25); Exit.Position = UDim2.new(1, -30, 0, 5); Exit.Text = "X"
Exit.BackgroundColor3 = Color3.new(1, 0, 0); Exit.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
Instance.new("UICorner", Exit).CornerRadius = UDim.new(1, 0)