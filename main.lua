local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BoDcChii_Main"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

local OpenIcon = Instance.new("TextButton")
OpenIcon.Parent = ScreenGui
OpenIcon.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
OpenIcon.Position = UDim2.new(0, 10, 0.4, 0)
OpenIcon.Size = UDim2.new(0, 45, 0, 45)
OpenIcon.Text = "BD"
OpenIcon.TextColor3 = Color3.new(1, 1, 1)
OpenIcon.Font = Enum.Font.SourceSansBold
OpenIcon.TextSize = 18
OpenIcon.Draggable = true

local IconCorner = Instance.new("UICorner")
IconCorner.CornerRadius = UDim.new(1, 0) -- Ikon jadi Bulat
IconCorner.Parent = OpenIcon

local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.5, -90, 0.3, 0)
MainFrame.Size = UDim2.new(0, 180, 0, 200)
MainFrame.Visible = false
MainFrame.ClipsDescendants = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

OpenIcon.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

local Sidebar = Instance.new("Frame")
Sidebar.Parent = MainFrame
Sidebar.Size = UDim2.new(0, 45, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

local PageContainer = Instance.new("Frame")
PageContainer.Parent = MainFrame
PageContainer.Position = UDim2.new(0, 50, 0, 0)
PageContainer.Size = UDim2.new(1, -50, 1, 0)
PageContainer.BackgroundTransparency = 1

local PlayerPage = Instance.new("ScrollingFrame")
PlayerPage.Parent = PageContainer
PlayerPage.Size = UDim2.new(1, -5, 1, -10)
PlayerPage.BackgroundTransparency = 1
PlayerPage.ScrollBarThickness = 2
PlayerPage.Visible = true

local PlayerList = Instance.new("UIListLayout")
PlayerList.Parent = PlayerPage
PlayerList.Padding = UDim.new(0, 5)

local EspPage = Instance.new("ScrollingFrame")
EspPage.Parent = PageContainer
EspPage.Size = UDim2.new(1, -5, 1, -10)
EspPage.BackgroundTransparency = 1
EspPage.ScrollBarThickness = 2
EspPage.Visible = false

local BrightBtn = Instance.new("TextButton")
BrightBtn.Parent = PlayerPage
BrightBtn.Size = UDim2.new(1, -5, 0, 35)
BrightBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
BrightBtn.Text = "Full Bright"
BrightBtn.TextColor3 = Color3.new(1, 1, 1)
BrightBtn.Font = Enum.Font.SourceSans

BrightBtn.MouseButton1Click:Connect(function()
    game:GetService("Lighting").Brightness = 2
    game:GetService("Lighting").GlobalShadows = false
    game:GetService("Lighting").FogEnd = 99999
    BrightBtn.Text = "Bright: ON"
    BrightBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
end)

local TabPLY = Instance.new("TextButton")
TabPLY.Parent = Sidebar
TabPLY.Size = UDim2.new(1, 0, 0, 40)
TabPLY.Text = "PLY"
TabPLY.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TabPLY.TextColor3 = Color3.new(1, 1, 1)

local TabESP = Instance.new("TextButton")
TabESP.Parent = Sidebar
TabESP.Position = UDim2.new(0, 0, 0, 45)
TabESP.Size = UDim2.new(1, 0, 0, 40)
TabESP.Text = "ESP"
TabESP.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TabESP.TextColor3 = Color3.new(1, 1, 1)

TabPLY.MouseButton1Click:Connect(function()
    PlayerPage.Visible = true
    EspPage.Visible = false
    TabPLY.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    TabESP.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
end)

TabESP.MouseButton1Click:Connect(function()
    PlayerPage.Visible = false
    EspPage.Visible = true
    TabESP.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    TabPLY.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
end)