-- [[ BoDcChii Project - v1.3: Full Fix 🎸 ]] --

local UserInputService = game:GetService("UserInputService")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BoDcChii_Final_Fixed"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- --- 1. FUNGSI DRAG (KHUSUS HP - RINGAN) ---
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

-- --- 2. WELCOME SCREEN (KATA SAMBUTAN) ---
local WelcomeLabel = Instance.new("TextLabel", ScreenGui)
WelcomeLabel.Size = UDim2.new(1, 0, 1, 0)
WelcomeLabel.BackgroundTransparency = 1
WelcomeLabel.Text = "Welcome by @BoDcChii 😈"
WelcomeLabel.TextColor3 = Color3.fromRGB(255, 105, 180) -- Pink
WelcomeLabel.Font = Enum.Font.SpecialElite
WelcomeLabel.TextSize = 35
WelcomeLabel.ZIndex = 1000

task.spawn(function()
    task.wait(1.5)
    for i = 0, 1, 0.1 do WelcomeLabel.TextTransparency = i; task.wait(0.05) end
    WelcomeLabel:Destroy()
end)

-- --- 3. FLOATING ICON BOCCHI (KECIL & GESER) ---
local OpenIcon = Instance.new("ImageButton", ScreenGui)
OpenIcon.Size = UDim2.new(0, 45, 0, 45)
OpenIcon.Position = UDim2.new(0, 15, 0.5, 0)
OpenIcon.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
OpenIcon.Image = "rbxassetid://12130312683"
OpenIcon.Visible = false
OpenIcon.ZIndex = 500
local CornerIcon = Instance.new("UICorner", OpenIcon); CornerIcon.CornerRadius = UDim.new(1, 0)
local StrokeIcon = Instance.new("UIStroke", OpenIcon); StrokeIcon.Color = Color3.fromRGB(255, 105, 180); StrokeIcon.Thickness = 2

task.delay(1.7, function() OpenIcon.Visible = true end)
MakeDraggable(OpenIcon) -- Aktifkan geser icon

-- --- 4. MAIN FRAME (MENU BAR) ---
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 280, 0, 220)
MainFrame.Position = UDim2.new(0.5, -140, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Visible = false
MainFrame.ZIndex = 100
MainFrame.Active = true -- Penting buat geser
local CornerMain = Instance.new("UICorner", MainFrame)
local StrokeMain = Instance.new("UIStroke", MainFrame); StrokeMain.Color = Color3.fromRGB(255, 105, 180)

MakeDraggable(MainFrame) -- Aktifkan geser menu bar

OpenIcon.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- --- 5. SIDEBAR (TAB 1. PLAYER) ---
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 80, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Sidebar.ZIndex = 101

local TabText = Instance.new("TextLabel", Sidebar)
TabText.Size = UDim2.new(1, 0, 0, 40)
TabText.Text = "1. PLAYER"
TabText.TextColor3 = Color3.new(1, 1, 1)
TabText.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TabText.ZIndex = 102
TabText.Font = Enum.Font.SourceSansBold

-- --- 6. TOMBOL FITUR (DI HALAMAN PLAYER) ---

-- SPEED
local BtnSpeed = Instance.new("TextButton", MainFrame)
BtnSpeed.Size = UDim2.new(0, 170, 0, 40)
BtnSpeed.Position = UDim2.new(0, 95, 0, 50)
BtnSpeed.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
BtnSpeed.Text = "1. SPEED: OFF"
BtnSpeed.TextColor3 = Color3.new(1, 1, 1)
BtnSpeed.ZIndex = 200
Instance.new("UICorner", BtnSpeed)

local speedOn = false
BtnSpeed.MouseButton1Click:Connect(function()
    speedOn = not speedOn
    BtnSpeed.BackgroundColor3 = speedOn and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(45, 45, 45)
    BtnSpeed.Text = speedOn and "1. SPEED: ON" or "1. SPEED: OFF"
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speedOn and 60 or 16
end)

-- JUMP
local BtnJump = Instance.new("TextButton", MainFrame)
BtnJump.Size = UDim2.new(0, 170, 0, 40)
BtnJump.Position = UDim2.new(0, 95, 0, 100)
BtnJump.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
BtnJump.Text = "2. JUMP: OFF"
BtnJump.TextColor3 = Color3.new(1, 1, 1)
BtnJump.ZIndex = 200
Instance.new("UICorner", BtnJump)

local jumpOn = false
BtnJump.MouseButton1Click:Connect(function()
    jumpOn = not jumpOn
    BtnJump.BackgroundColor3 = jumpOn and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(45, 45, 45)
    BtnJump.Text = jumpOn and "2. JUMP: ON" or "2. JUMP: OFF"
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = jumpOn and 100 or 50
    game.Players.LocalPlayer.Character.Humanoid.UseJumpPower = true
end)

-- EXIT (X)
local Exit = Instance.new("TextButton", MainFrame)
Exit.Size = UDim2.new(0, 25, 0, 25)
Exit.Position = UDim2.new(1, -30, 0, 5)
Exit.Text = "X"
Exit.BackgroundColor3 = Color3.new(1, 0, 0)
Exit.TextColor3 = Color3.new(1, 1, 1)
Exit.ZIndex = 300
Exit.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
Instance.new("UICorner", Exit).CornerRadius = UDim.new(1, 0)

-- WATERMARK
local Footer = Instance.new("TextLabel", MainFrame)
Footer.Size = UDim2.new(0, 170, 0, 20)
Footer.Position = UDim2.new(0, 95, 1, -25)
Footer.Text = "@BoDcChii | v1.3"
Footer.TextColor3 = Color3.fromRGB(255, 105, 180)
Footer.BackgroundTransparency = 1
Footer.ZIndex = 110
