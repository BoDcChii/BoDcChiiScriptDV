-- [[ BoDcChii Project - STEP: Player Page Only 🎸 ]] --

local UserInputService = game:GetService("UserInputService")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BoDcChii_Step_Player"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- --- FUNGSI DRAG (BIAR BISA DIGESER) ---
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

-- --- 1. WELCOME SCREEN ---
local WelcomeLabel = Instance.new("TextLabel")
WelcomeLabel.Parent = ScreenGui; WelcomeLabel.BackgroundTransparency = 1; WelcomeLabel.Size = UDim2.new(1, 0, 1, 0)
WelcomeLabel.Text = "Welcome by @BoDcChii 😈"; WelcomeLabel.TextColor3 = Color3.fromRGB(255, 105, 180); WelcomeLabel.Font = Enum.Font.SpecialElite; WelcomeLabel.TextSize = 35
task.spawn(function() task.wait(1.5); for i = 0, 1, 0.1 do WelcomeLabel.TextTransparency = i; task.wait(0.05) end; WelcomeLabel:Destroy() end)

-- --- 2. ICON BOCCHI (KECIL & BISA DIGESER) ---
local OpenIcon = Instance.new("ImageButton")
OpenIcon.Parent = ScreenGui; OpenIcon.BackgroundColor3 = Color3.fromRGB(20, 20, 20); OpenIcon.Position = UDim2.new(0, 10, 0.5, -22); OpenIcon.Size = UDim2.new(0, 45, 0, 45)
OpenIcon.Image = "rbxassetid://12130312683"; OpenIcon.Visible = false; OpenIcon.ZIndex = 100 
local IconCorner = Instance.new("UICorner"); IconCorner.CornerRadius = UDim.new(1, 0); IconCorner.Parent = OpenIcon
local IconStroke = Instance.new("UIStroke"); IconStroke.Color = Color3.fromRGB(255, 105, 180); IconStroke.Thickness = 2; IconStroke.Parent = OpenIcon
task.delay(1.7, function() OpenIcon.Visible = true end); MakeDraggable(OpenIcon)

-- --- 3. MAIN FRAME (MENU BAR) ---
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui; MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20); MainFrame.Position = UDim2.new(0.5, -140, 0.3, 0); MainFrame.Size = UDim2.new(0, 280, 0, 250); MainFrame.Visible = false; MainFrame.ZIndex = 50; MainFrame.Active = true
local MainCorner = Instance.new("UICorner"); MainCorner.CornerRadius = UDim.new(0, 10); MainCorner.Parent = MainFrame; MakeDraggable(MainFrame)
OpenIcon.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- TOMBOL KELUAR (X)
local ExitBtn = Instance.new("TextButton")
ExitBtn.Parent = MainFrame; ExitBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50); ExitBtn.Position = UDim2.new(1, -30, 0, 5); ExitBtn.Size = UDim2.new(0, 25, 0, 25); ExitBtn.Text = "X"; ExitBtn.TextColor3 = Color3.new(1, 1, 1); ExitBtn.Font = Enum.Font.SourceSansBold; ExitBtn.ZIndex = 60
ExitBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- --- 4. SIDEBAR (HANYA 1 TAB: PLAYER) ---
local Sidebar = Instance.new("Frame")
Sidebar.Parent = MainFrame; Sidebar.Size = UDim2.new(0, 80, 1, -40); Sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
local Tab1 = Instance.new("TextButton")
Tab1.Parent = Sidebar; Tab1.Size = UDim2.new(1, 0, 0, 50); Tab1.Position = UDim2.new(0, 0, 0, 5)
Tab1.Text = "1. Player"; Tab1.BackgroundColor3 = Color3.fromRGB(45, 45, 45); Tab1.TextColor3 = Color3.new(1, 1, 1); Tab1.Font = Enum.Font.SourceSansBold; Tab1.TextSize = 12

-- --- 5. HALAMAN ISI (PLAYER CONTENT) ---
local PageContainer = Instance.new("Frame")
PageContainer.Parent = MainFrame; PageContainer.Position = UDim2.new(0, 85, 0, 40); PageContainer.Size = UDim2.new(1, -95, 1, -80); PageContainer.BackgroundTransparency = 1
local PageLayout = Instance.new("UIListLayout"); PageLayout.Parent = PageContainer; PageLayout.Padding = UDim.new(0, 8)

-- FUNGSI TOMBOL FITUR
local function AddFeature(num, text, callback)
    local active = false
    local b = Instance.new("TextButton")
    b.Parent = PageContainer; b.Size = UDim2.new(1, -5, 0, 35); b.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    b.Text = num..". "..text..": OFF"; b.TextColor3 = Color3.new(1, 1, 1); b.Font = Enum.Font.SourceSansBold; b.TextSize = 12
    local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 6); c.Parent = b
    b.MouseButton1Click:Connect(function()
        active = not active
        b.BackgroundColor3 = active and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(50, 50, 50)
        b.Text = active and num..". "..text..": ON" or num..". "..text..": OFF"
        callback(active)
    end)
end

-- ISI FITUR PLAYER
AddFeature("1", "Speed High", function(s) 
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s and 50 or 16 
end)

AddFeature("2", "Jump Power", function(s) 
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = s and 100 or 50
    game.Players.LocalPlayer.Character.Humanoid.UseJumpPower = true
end)

-- FOOTER
local Footer = Instance.new("TextLabel")
Footer.Parent = MainFrame; Footer.Position = UDim2.new(0, 0, 1, -25); Footer.Size = UDim2.new(1, 0, 0, 20); Footer.BackgroundTransparency = 1; Footer.Text = "@BoDcChii | v1.1"; Footer.TextColor3 = Color3.fromRGB(255, 105, 180); Footer.Font = Enum.Font.SourceSansBold; Footer.TextSize = 13; Footer.ZIndex = 60
