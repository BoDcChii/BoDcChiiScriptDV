-- [[ BoDcChii Project - STEP 1: Force-Front Buttons 🎸 ]] --

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BoDcChii_Final_Test"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- --- 1. FLOATING ICON BOCCHI ---
local OpenIcon = Instance.new("ImageButton", ScreenGui)
OpenIcon.Size = UDim2.new(0, 45, 0, 45)
OpenIcon.Position = UDim2.new(0, 10, 0.5, 0)
OpenIcon.BackgroundColor3 = Color3.fromRGB(255, 105, 180) -- PINK BIAR KELIHATAN
OpenIcon.Image = "rbxassetid://12130312683"
OpenIcon.ZIndex = 500 -- SANGAT TINGGI

-- --- 2. MAIN FRAME (MENU) ---
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 280, 0, 220)
MainFrame.Position = UDim2.new(0.5, -140, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(255, 105, 180) -- GARIS PINK
MainFrame.Visible = false
MainFrame.ZIndex = 100 -- DI BAWAH TOMBOL

-- TOGGLE ICON
OpenIcon.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- --- 3. SIDEBAR (TAB PLAYER) ---
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

-- --- 4. TOMBOL FITUR (DI PAKSA KE DEPAN) ---

-- TOMBOL SPEED
local BtnSpeed = Instance.new("TextButton", MainFrame)
BtnSpeed.Size = UDim2.new(0, 180, 0, 45)
BtnSpeed.Position = UDim2.new(0, 90, 0, 50) -- POSISI DI SEBELAH SIDEBAR
BtnSpeed.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
BtnSpeed.Text = "1. SPEED: OFF"
BtnSpeed.TextColor3 = Color3.new(1, 1, 1)
BtnSpeed.TextSize = 14
BtnSpeed.ZIndex = 200 -- HARUS DI ATAS MAINFRAME
Instance.new("UICorner", BtnSpeed)

local speedOn = false
BtnSpeed.MouseButton1Click:Connect(function()
    speedOn = not speedOn
    BtnSpeed.BackgroundColor3 = speedOn and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(45, 45, 45)
    BtnSpeed.Text = speedOn and "1. SPEED: ON" or "1. SPEED: OFF"
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speedOn and 60 or 16
end)

-- TOMBOL JUMP
local BtnJump = Instance.new("TextButton", MainFrame)
BtnJump.Size = UDim2.new(0, 180, 0, 45)
BtnJump.Position = UDim2.new(0, 90, 0, 105) -- DI BAWAH TOMBOL SPEED
BtnJump.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
BtnJump.Text = "2. JUMP: OFF"
BtnJump.TextColor3 = Color3.new(1, 1, 1)
BtnJump.TextSize = 14
BtnJump.ZIndex = 200 -- HARUS DI ATAS MAINFRAME
Instance.new("UICorner", BtnJump)

local jumpOn = false
BtnJump.MouseButton1Click:Connect(function()
    jumpOn = not jumpOn
    BtnJump.BackgroundColor3 = jumpOn and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(45, 45, 45)
    BtnJump.Text = jumpOn and "2. JUMP: ON" or "2. JUMP: OFF"
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = jumpOn and 100 or 50
    game.Players.LocalPlayer.Character.Humanoid.UseJumpPower = true
end)

-- --- 5. TOMBOL CLOSE (X) ---
local Exit = Instance.new("TextButton", MainFrame)
Exit.Size = UDim2.new(0, 30, 0, 30)
Exit.Position = UDim2.new(1, -35, 0, 5)
Exit.Text = "X"
Exit.BackgroundColor3 = Color3.new(1, 0, 0)
Exit.ZIndex = 300
Exit.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
Instance.new("UICorner", Exit).CornerRadius = UDim.new(1, 0)

print("Script @BoDcChii Loaded - Cek Menu!")
