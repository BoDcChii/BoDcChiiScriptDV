-- [[ BoDcChii Project v1.1 - 4 Tabs Numbered Navigation 🎸 ]] --

local UserInputService = game:GetService("UserInputService")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BoDcChii_Final_Project"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- --- FUNGSI DRAG (SMOOTH) ---
local function MakeDraggable(obj)
    local dragging, dragInput, dragStart, startPos
    obj.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            dragging = true; dragStart = input.Position; startPos = obj.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    obj.InputChanged:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then dragInput = input end
    end)
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
task.spawn(function()
    task.wait(1.5)
    for i = 0, 1, 0.1 do WelcomeLabel.TextTransparency = i; task.wait(0.05) end
    WelcomeLabel:Destroy()
end)

-- --- 2. COMPACT ICON (45x45) ---
local OpenIcon = Instance.new("ImageButton")
OpenIcon.Parent = ScreenGui; OpenIcon.BackgroundColor3 = Color3.fromRGB(20, 20, 20); OpenIcon.Position = UDim2.new(0, 10, 0.5, -22); OpenIcon.Size = UDim2.new(0, 45, 0, 45)
OpenIcon.Image = "rbxassetid://12130312683"; OpenIcon.Visible = false; OpenIcon.ZIndex = 100 
local IconCorner = Instance.new("UICorner"); IconCorner.CornerRadius = UDim.new(1, 0); IconCorner.Parent = OpenIcon
local IconStroke = Instance.new("UIStroke"); IconStroke.Color = Color3.fromRGB(255, 105, 180); IconStroke.Thickness = 2; IconStroke.Parent = OpenIcon

task.delay(1.7, function() OpenIcon.Visible = true end)
MakeDraggable(OpenIcon)

-- --- 3. MAIN FRAME (WIDER) ---
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui; MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20); MainFrame.Position = UDim2.new(0.5, -140, 0.3, 0); MainFrame.Size = UDim2.new(0, 280, 0, 300); MainFrame.Visible = false; MainFrame.ZIndex = 50; MainFrame.Active = true
local MainCorner = Instance.new("UICorner"); MainCorner.CornerRadius = UDim.new(0, 10); MainCorner.Parent = MainFrame
MakeDraggable(MainFrame)

OpenIcon.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- --- 4. TOMBOL KELUAR ---
local ExitBtn = Instance.new("TextButton")
ExitBtn.Parent = MainFrame; ExitBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50); ExitBtn.Position = UDim2.new(1, -30, 0, 5); ExitBtn.Size = UDim2.new(0, 25, 0, 25); ExitBtn.Text = "X"; ExitBtn.TextColor3 = Color3.new(1, 1, 1); ExitBtn.Font = Enum.Font.SourceSansBold; ExitBtn.ZIndex = 60
local ExitCorner = Instance.new("UICorner"); ExitCorner.CornerRadius = UDim.new(1, 0); ExitCorner.Parent = ExitBtn
ExitBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- --- 5. SIDEBAR (75 WIDTH) ---
local Sidebar = Instance.new("Frame")
Sidebar.Parent = MainFrame; Sidebar.Size = UDim2.new(0, 80, 1, -40); Sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
local SidebarLayout = Instance.new("UIListLayout"); SidebarLayout.Parent = Sidebar; SidebarLayout.Padding = UDim.new(0, 2)

-- --- 6. PAGE CONTAINER ---
local PageContainer = Instance.new("Frame")
PageContainer.Parent = MainFrame; PageContainer.Position = UDim2.new(0, 85, 0, 40); PageContainer.Size = UDim2.new(1, -95, 1, -80); PageContainer.BackgroundTransparency = 1

local AllPages = {}
local function CreatePage(name, visible)
    local Page = Instance.new("ScrollingFrame")
    Page.Name = name; Page.Parent = PageContainer; Page.Size = UDim2.new(1, 0, 1, 0); Page.BackgroundTransparency = 1; Page.ScrollBarThickness = 2; Page.Visible = visible; Page.CanvasSize = UDim2.new(0, 0, 2, 0)
    local Layout = Instance.new("UIListLayout"); Layout.Parent = Page; Layout.Padding = UDim.new(0, 8)
    AllPages[name] = Page
    return Page
end

-- Membuat 4 Halaman Sesuai Permintaan
local Page1 = CreatePage("Player", true)
local Page2 = CreatePage("Survival", false)
local Page3 = CreatePage("Killer", false)
local Page4 = CreatePage("ESP", false)

-- --- 7. FUNGSI NAVIGASI SIDEBAR ---
local function AddTab(num, txt)
    local b = Instance.new("TextButton")
    b.Parent = Sidebar; b.Size = UDim2.new(1, 0, 0, 45)
    b.Text = num..". "..txt; b.BackgroundColor3 = Color3.fromRGB(45, 45, 45); b.TextColor3 = Color3.new(1, 1, 1); b.Font = Enum.Font.SourceSansBold; b.TextSize = 12
    
    b.MouseButton1Click:Connect(function()
        for _, p in pairs(AllPages) do p.Visible = false end
        AllPages[txt].Visible = true
    end)
end

-- Menambahkan Tab dengan Nomor Urut
AddTab("1", "Player")
AddTab("2", "Survival")
AddTab("3", "Killer")
AddTab("4", "ESP")

-- FOOTER
local Footer = Instance.new("TextLabel")
Footer.Parent = MainFrame; Footer.Position = UDim2.new(0, 0, 1, -25); Footer.Size = UDim2.new(1, 0, 0, 20); Footer.BackgroundTransparency = 1; Footer.Text = "@BoDcChii | v1.1"; Footer.TextColor3 = Color3.fromRGB(255, 105, 180); Footer.Font = Enum.Font.SourceSansBold; Footer.TextSize = 13; Footer.ZIndex = 60
