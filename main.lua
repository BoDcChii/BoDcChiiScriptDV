-- [[ BoDcChii Project - v1.6: Kembali ke yang Bisa 🎸 ]] --

local UserInputService = game:GetService("UserInputService")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BoDcChii_Final_BackToBasic"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- --- FUNGSI GESER (VERSI PALING STABIL) ---
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

-- --- 1. WELCOME (VERSI SEDERHANA) ---
local Welcome = Instance.new("TextLabel", ScreenGui)
Welcome.Size = UDim2.new(1, 0, 0, 50)
Welcome.Position = UDim2.new(0, 0, 0.4, 0)
Welcome.Text = "Welcome by @BoDcChii 😈"
Welcome.TextColor3 = Color3.fromRGB(255, 105, 180)
Welcome.BackgroundTransparency = 1
Welcome.TextSize = 30
task.delay(2, function() Welcome:Destroy() end)

-- --- 2. ICON BOCCHI (45x45) ---
local OpenIcon = Instance.new("ImageButton", ScreenGui)
OpenIcon.Size = UDim2.new(0, 45, 0, 45)
OpenIcon.Position = UDim2.new(0, 20, 0.5, 0)
OpenIcon.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
OpenIcon.Image = "rbxassetid://12130312683"
OpenIcon.ZIndex = 500
Instance.new("UICorner", OpenIcon).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", OpenIcon).Color = Color3.fromRGB(255, 105, 180)

MakeDraggable(OpenIcon) -- AKTIFKAN GESER ICON

-- --- 3. MAIN FRAME (MENU BAR) ---
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 280, 0, 250)
MainFrame.Position = UDim2.new(0.5, -140, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Visible = false
MainFrame.Active = true
Instance.new("UICorner", MainFrame)
Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(255, 105, 180)

MakeDraggable(MainFrame) -- AKTIFKAN GESER MENU BAR

OpenIcon.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- --- 4. SIDEBAR (1. PLAYER) ---
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 80, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

local TabLabel = Instance.new("TextLabel", Sidebar)
TabLabel.Size = UDim2.new(1, 0, 0, 45)
TabLabel.Text = "1. Player"
TabLabel.TextColor3 = Color3.new(1, 1, 1)
TabLabel.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TabLabel.Font = Enum.Font.SourceSansBold

-- --- 5. TOMBOL FITUR (PLAYER) ---
local function AddButton(num, txt, pos, callback)
    local b = Instance.new("TextButton", MainFrame)
    b.Size = UDim2.new(0, 180, 0, 40)
    b.Position = UDim2.new(0, 90, 0, pos)
    b.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    b.Text = num..". "..txt..": OFF"
    b.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", b)
    
    local active = false
    b.MouseButton1Click:Connect(function()
        active = not active
        b.BackgroundColor3 = active and Color3.fromRGB(0, 180, 100) or Color3.fromRGB(40, 40, 40)
        b.Text = active and num..". "..txt..": ON" or num..". "..txt..": OFF"
        callback(active)
    end)
end

-- Isi Fitur Player
AddButton("1", "Speed High", 50, function(s) 
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s and 60 or 16 
end)

AddButton("2", "Jump High", 100, function(s) 
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = s and 100 or 50
    game.Players.LocalPlayer.Character.Humanoid.UseJumpPower = true
end)

-- EXIT (X)
local Exit = Instance.new("TextButton", MainFrame)
Exit.Size = UDim2.new(0, 30, 0, 30)
Exit.Position = UDim2.new(1, -35, 0, 5)
Exit.Text = "X"; Exit.BackgroundColor3 = Color3.new(1, 0, 0)
Exit.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
Instance.new("UICorner", Exit).CornerRadius = UDim.new(1, 0)
