-- [[ BoDcChii Project - STEP 1: Manual Layout Fix 🎸 ]] --

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BoDcChii_Project_Fixed"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- --- 1. WELCOME TEXT (CEK APAKAH SCRIPT JALAN) ---
local Welcome = Instance.new("TextLabel", ScreenGui)
Welcome.Size = UDim2.new(1, 0, 0, 50)
Welcome.Position = UDim2.new(0, 0, 0.1, 0)
Welcome.Text = "LOADING @BoDcChii MENU..."
Welcome.TextColor3 = Color3.new(1, 0.5, 0.7)
Welcome.BackgroundTransparency = 1
Welcome.TextSize = 25
task.delay(2, function() Welcome:Destroy() end)

-- --- 2. ICON BOCCHI ---
local OpenIcon = Instance.new("ImageButton", ScreenGui)
OpenIcon.Size = UDim2.new(0, 45, 0, 45)
OpenIcon.Position = UDim2.new(0, 10, 0.5, 0)
OpenIcon.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
OpenIcon.Image = "rbxassetid://12130312683"
OpenIcon.ZIndex = 100
local CornerIcon = Instance.new("UICorner", OpenIcon)
CornerIcon.CornerRadius = UDim.new(1, 0)

-- --- 3. MAIN FRAME (MENU) ---
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 280, 0, 220) -- LEBAR
MainFrame.Position = UDim2.new(0.5, -140, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Visible = false
MainFrame.Active = true
local CornerMain = Instance.new("UICorner", MainFrame)

-- TOGGLE BUKA/TUTUP
OpenIcon.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- --- 4. SIDEBAR (TAB) ---
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 80, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

local TabLabel = Instance.new("TextLabel", Sidebar)
TabLabel.Size = UDim2.new(1, 0, 0, 40)
TabLabel.Text = "1. Player" -- NOMER TAB
TabLabel.TextColor3 = Color3.new(1, 1, 1)
TabLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TabLabel.Font = Enum.Font.SourceSansBold

-- --- 5. ISI MENU (TOMBOL MANUAL) ---
-- Tombol 1: SPEED
local BtnSpeed = Instance.new("TextButton", MainFrame)
BtnSpeed.Size = UDim2.new(0, 170, 0, 40)
BtnSpeed.Position = UDim2.new(0, 95, 0, 50) -- POSISI MANUAL (BIAR GAK KOSONG)
BtnSpeed.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
BtnSpeed.Text = "1. Speed High: OFF"
BtnSpeed.TextColor3 = Color3.new(1, 1, 1)
BtnSpeed.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", BtnSpeed)

local speedActive = false
BtnSpeed.MouseButton1Click:Connect(function()
    speedActive = not speedActive
    BtnSpeed.BackgroundColor3 = speedActive and Color3.fromRGB(0, 180, 100) or Color3.fromRGB(60, 60, 60)
    BtnSpeed.Text = speedActive and "1. Speed High: ON" or "1. Speed High: OFF"
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speedActive and 50 or 16
end)

-- Tombol 2: JUMP
local BtnJump = Instance.new("TextButton", MainFrame)
BtnJump.Size = UDim2.new(0, 170, 0, 40)
BtnJump.Position = UDim2.new(0, 95, 0, 100) -- POSISI DI BAWAH SPEED
BtnJump.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
BtnJump.Text = "2. Jump Power: OFF"
BtnJump.TextColor3 = Color3.new(1, 1, 1)
BtnJump.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", BtnJump)

local jumpActive = false
BtnJump.MouseButton1Click:Connect(function()
    jumpActive = not jumpActive
    BtnJump.BackgroundColor3 = jumpActive and Color3.fromRGB(0, 180, 100) or Color3.fromRGB(60, 60, 60)
    BtnJump.Text = jumpActive and "2. Jump Power: ON" or "2. Jump Power: OFF"
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = jumpActive and 100 or 50
    game.Players.LocalPlayer.Character.Humanoid.UseJumpPower = true
end)

-- --- 6. EXIT (X) ---
local Exit = Instance.new("TextButton", MainFrame)
Exit.Size = UDim2.new(0, 25, 0, 25)
Exit.Position = UDim2.new(1, -30, 0, 5)
Exit.Text = "X"
Exit.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
Exit.TextColor3 = Color3.new(1, 1, 1)
Exit.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
Instance.new("UICorner", Exit).CornerRadius = UDim.new(1, 0)

-- FOOTER
local Footer = Instance.new("TextLabel", MainFrame)
Footer.Size = UDim2.new(0, 170, 0, 20)
Footer.Position = UDim2.new(0, 95, 1, -25)
Footer.Text = "@BoDcChii | v1.1"
Footer.TextColor3 = Color3.new(1, 0.5, 0.7)
Footer.BackgroundTransparency = 1
Footer.TextSize = 12
