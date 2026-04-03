-- [[ BoDcChii Project - v1.4: Ultra-Compatible 🎸 ]] --

local p = game.Players.LocalPlayer
local pg = p:FindFirstChild("PlayerGui")
if not pg then return end

-- Hapus menu lama kalau ada
if pg:FindFirstChild("BoDcChii_Menu") then pg.BoDcChii_Menu:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BoDcChii_Menu"
ScreenGui.Parent = pg
ScreenGui.ResetOnSpawn = false

-- --- 1. WELCOME TEXT (KASAR & PASTI MUNCUL) ---
local Welcome = Instance.new("TextLabel", ScreenGui)
Welcome.Size = UDim2.new(1, 0, 0, 50)
Welcome.Position = UDim2.new(0, 0, 0.2, 0)
Welcome.BackgroundColor3 = Color3.new(0, 0, 0)
Welcome.BackgroundTransparency = 0.5
Welcome.Text = "WELCOME BY @BoDcChii 😈"
Welcome.TextColor3 = Color3.new(1, 0.4, 0.7)
Welcome.TextSize = 30
Welcome.ZIndex = 1000

-- Hilangkan setelah 2 detik
task.delay(2, function() Welcome:Destroy() end)

-- --- 2. FLOATING ICON BOCCHI (DRAGGABLE) ---
local OpenIcon = Instance.new("ImageButton", ScreenGui)
OpenIcon.Size = UDim2.new(0, 45, 0, 45)
OpenIcon.Position = UDim2.new(0, 20, 0.5, 0)
OpenIcon.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
OpenIcon.Image = "rbxassetid://12130312683"
OpenIcon.ZIndex = 900
OpenIcon.Draggable = true -- PAKAI FITUR BAWAAN ROBLOX
OpenIcon.Active = true

local CornerIcon = Instance.new("UICorner", OpenIcon)
CornerIcon.CornerRadius = UDim.new(1, 0)

-- --- 3. MAIN FRAME (MENU BAR) ---
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 280, 0, 220)
MainFrame.Position = UDim2.new(0.5, -140, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(255, 105, 180)
MainFrame.Visible = false
MainFrame.ZIndex = 500
MainFrame.Draggable = true -- PAKAI FITUR BAWAAN ROBLOX
MainFrame.Active = true

-- FUNGSI KLIK ICON
OpenIcon.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- --- 4. SIDEBAR (TAB 1. PLAYER) ---
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 80, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Sidebar.ZIndex = 501

local TabLabel = Instance.new("TextLabel", Sidebar)
TabLabel.Size = UDim2.new(1, 0, 0, 40)
TabLabel.Position = UDim2.new(0, 0, 0, 0)
TabLabel.Text = "1. PLAYER"
TabLabel.TextColor3 = Color3.new(1, 1, 1)
TabLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TabLabel.ZIndex = 502

-- --- 5. TOMBOL FITUR (DI HALAMAN PLAYER) ---

-- TOMBOL SPEED
local BtnSpeed = Instance.new("TextButton", MainFrame)
BtnSpeed.Size = UDim2.new(0, 170, 0, 40)
BtnSpeed.Position = UDim2.new(0, 95, 0, 50)
BtnSpeed.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
BtnSpeed.Text = "1. SPEED: OFF"
BtnSpeed.TextColor3 = Color3.new(1, 1, 1)
BtnSpeed.ZIndex = 600
Instance.new("UICorner", BtnSpeed)

local sOn = false
BtnSpeed.MouseButton1Click:Connect(function()
    sOn = not sOn
    BtnSpeed.BackgroundColor3 = sOn and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(60, 60, 60)
    BtnSpeed.Text = sOn and "1. SPEED: ON" or "1. SPEED: OFF"
    p.Character.Humanoid.WalkSpeed = sOn and 60 or 16
end)

-- TOMBOL JUMP
local BtnJump = Instance.new("TextButton", MainFrame)
BtnJump.Size = UDim2.new(0, 170, 0, 40)
BtnJump.Position = UDim2.new(0, 95, 0, 100)
BtnJump.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
BtnJump.Text = "2. JUMP: OFF"
BtnJump.TextColor3 = Color3.new(1, 1, 1)
BtnJump.ZIndex = 600
Instance.new("UICorner", BtnJump)

local jOn = false
BtnJump.MouseButton1Click:Connect(function()
    jOn = not jOn
    BtnJump.BackgroundColor3 = jOn and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(60, 60, 60)
    BtnJump.Text = jOn and "2. JUMP: ON" or "2. JUMP: OFF"
    p.Character.Humanoid.JumpPower = jOn and 100 or 50
    p.Character.Humanoid.UseJumpPower = true
end)

-- TOMBOL EXIT (X)
local Close = Instance.new("TextButton", MainFrame)
Close.Size = UDim2.new(0, 30, 0, 30)
Close.Position = UDim2.new(1, -35, 0, 5)
Close.Text = "X"
Close.BackgroundColor3 = Color3.new(1, 0, 0)
Close.TextColor3 = Color3.new(1, 1, 1)
Close.ZIndex = 700
Close.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
Instance.new("UICorner", Close).CornerRadius = UDim.new(1, 0)

print("Script @BoDcChii v1.4 Loaded!")
