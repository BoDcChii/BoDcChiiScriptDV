-- [[ BoDcChii Project v0.7 - Draggable Bocchi & Menu 🎸 ]] --

local UserInputService = game:GetService("UserInputService")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BoDcChii_Final_Draggable"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- --- 1. FUNGSI DRAGGABLE (BIAR HALUS) ---
local function MakeDraggable(frame)
	local dragging, dragInput, dragStart, startPos
	local function update(input)
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)
	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then update(input) end
	end)
end

-- --- 2. WELCOME SCREEN ---
local WelcomeLabel = Instance.new("TextLabel")
WelcomeLabel.Parent = ScreenGui; WelcomeLabel.BackgroundTransparency = 1; WelcomeLabel.Size = UDim2.new(1, 0, 1, 0)
WelcomeLabel.Text = "Welcome by @BoDcChii 😈"; WelcomeLabel.TextColor3 = Color3.fromRGB(255, 105, 180); WelcomeLabel.Font = Enum.Font.SpecialElite; WelcomeLabel.TextSize = 35; WelcomeLabel.ZIndex = 100

task.spawn(function()
	task.wait(1.5)
	for i = 0, 1, 0.1 do WelcomeLabel.TextTransparency = i; task.wait(0.05) end
	WelcomeLabel:Destroy()
end)

-- --- 3. FLOATING ICON (BOCCHI) ---
local OpenIcon = Instance.new("ImageButton")
OpenIcon.Parent = ScreenGui; OpenIcon.BackgroundColor3 = Color3.fromRGB(20, 20, 20); OpenIcon.Position = UDim2.new(0, 20, 0.4, 0); OpenIcon.Size = UDim2.new(0, 60, 0, 60); OpenIcon.Image = "rbxassetid://12130312683"; OpenIcon.Visible = false; OpenIcon.ZIndex = 50
local IconCorner = Instance.new("UICorner"); IconCorner.CornerRadius = UDim.new(1, 0); IconCorner.Parent = OpenIcon
local IconStroke = Instance.new("UIStroke"); IconStroke.Color = Color3.fromRGB(255, 105, 180); IconStroke.Thickness = 3; IconStroke.Parent = OpenIcon

task.delay(1.7, function() OpenIcon.Visible = true end)
MakeDraggable(OpenIcon) -- AKTIFKAN DRAG UNTUK ICON

-- --- 4. MAIN FRAME (MENU BAR) ---
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui; MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20); MainFrame.Position = UDim2.new(0.5, -140, 0.3, 0); MainFrame.Size = UDim2.new(0, 280, 0, 300); MainFrame.Visible = false; MainFrame.ZIndex = 5
local MainCorner = Instance.new("UICorner"); MainCorner.CornerRadius = UDim.new(0, 10); MainCorner.Parent = MainFrame

MakeDraggable(MainFrame) -- AKTIFKAN DRAG UNTUK MENU BAR

-- Toggle Buka/Tutup
OpenIcon.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- --- 5. TOMBOL KELUAR (X) ---
local ExitBtn = Instance.new("TextButton")
ExitBtn.Parent = MainFrame; ExitBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50); ExitBtn.Position = UDim2.new(1, -30, 0, 5); ExitBtn.Size = UDim2.new(0, 25, 0, 25); ExitBtn.Text = "X"; ExitBtn.TextColor3 = Color3.new(1, 1, 1); ExitBtn.Font = Enum.Font.SourceSansBold; ExitBtn.ZIndex = 10
local ExitCorner = Instance.new("UICorner"); ExitCorner.CornerRadius = UDim.new(1, 0); ExitCorner.Parent = ExitBtn
ExitBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- --- 6. SIDEBAR & PAGES (PERSIAPAN FITUR) ---
local Sidebar = Instance.new("Frame")
Sidebar.Parent = MainFrame; Sidebar.Size = UDim2.new(0, 70, 1, -40); Sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
local PageContainer = Instance.new("Frame")
PageContainer.Parent = MainFrame; PageContainer.Position = UDim2.new(0, 75, 0, 40); PageContainer.Size = UDim2.new(1, -85, 1, -80); PageContainer.BackgroundTransparency = 1

local function CreatePage(name, visible)
	local Page = Instance.new("ScrollingFrame")
	Page.Name = name; Page.Parent = PageContainer; Page.Size = UDim2.new(1, 0, 1, 0); Page.BackgroundTransparency = 1; Page.ScrollBarThickness = 2; Page.Visible = visible; Page.CanvasSize = UDim2.new(0, 0, 2, 0)
	local Layout = Instance.new("UIListLayout"); Layout.Parent = Page; Layout.Padding = UDim.new(0, 8); return Page
end

local SurPage = CreatePage("SUR", true); local KlrPage = CreatePage("KLR", false); local EspPage = CreatePage("ESP", false)

-- WATERMARK
local Footer = Instance.new("TextLabel")
Footer.Parent = MainFrame; Footer.Position = UDim2.new(0, 0, 1, -25); Footer.Size = UDim2.new(1, 0, 0, 20); Footer.BackgroundTransparency = 1; Footer.Text = "@BoDcChii | v0.1"; Footer.TextColor3 = Color3.fromRGB(255, 105, 180); Footer.Font = Enum.Font.SourceSansBold; Footer.TextSize = 13; Footer.ZIndex = 10

-- TAB NAVIGASI
local function AddTab(pos, txt, p)
	local b = Instance.new("TextButton")
	b.Parent = Sidebar; b.Position = pos; b.Size = UDim2.new(1, 0, 0, 50); b.Text = txt; b.BackgroundColor3 = Color3.fromRGB(45, 45, 45); b.TextColor3 = Color3.new(1, 1, 1); b.Font = Enum.Font.SourceSansBold
	b.MouseButton1Click:Connect(function() SurPage.Visible = false; KlrPage.Visible = false; EspPage.Visible = false; p.Visible = true end)
end
AddTab(UDim2.new(0,0,0,5), "SUR", SurPage); AddTab(UDim2.new(0,0,0,60), "KLR", KlrPage); AddTab(UDim2.new(0,0,0,115), "ESP", EspPage)