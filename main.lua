-- [[ BoDcChii Project v1.2 - Full Features Loaded 🎸 ]] --

local UserInputService = game:GetService("UserInputService")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BoDcChii_Final_Full"
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

-- --- 1. WELCOME SCREEN ---
local WelcomeLabel = Instance.new("TextLabel")
WelcomeLabel.Parent = ScreenGui; WelcomeLabel.BackgroundTransparency = 1; WelcomeLabel.Size = UDim2.new(1, 0, 1, 0)
WelcomeLabel.Text = "Welcome by @BoDcChii 😈"; WelcomeLabel.TextColor3 = Color3.fromRGB(255, 105, 180); WelcomeLabel.Font = Enum.Font.SpecialElite; WelcomeLabel.TextSize = 35
task.spawn(function() task.wait(1.5); for i = 0, 1, 0.1 do WelcomeLabel.TextTransparency = i; task.wait(0.05) end; WelcomeLabel:Destroy() end)

-- --- 2. ICON & MAIN FRAME ---
local OpenIcon = Instance.new("ImageButton")
OpenIcon.Parent = ScreenGui; OpenIcon.BackgroundColor3 = Color3.fromRGB(20, 20, 20); OpenIcon.Position = UDim2.new(0, 10, 0.5, -22); OpenIcon.Size = UDim2.new(0, 45, 0, 45)
OpenIcon.Image = "rbxassetid://12130312683"; OpenIcon.Visible = false; OpenIcon.ZIndex = 100 
local IconCorner = Instance.new("UICorner"); IconCorner.CornerRadius = UDim.new(1, 0); IconCorner.Parent = OpenIcon
local IconStroke = Instance.new("UIStroke"); IconStroke.Color = Color3.fromRGB(255, 105, 180); IconStroke.Thickness = 2; IconStroke.Parent = OpenIcon
task.delay(1.7, function() OpenIcon.Visible = true end); MakeDraggable(OpenIcon)

local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui; MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20); MainFrame.Position = UDim2.new(0.5, -140, 0.3, 0); MainFrame.Size = UDim2.new(0, 280, 0, 300); MainFrame.Visible = false; MainFrame.ZIndex = 50; MainFrame.Active = true
local MainCorner = Instance.new("UICorner"); MainCorner.CornerRadius = UDim.new(0, 10); MainCorner.Parent = MainFrame; MakeDraggable(MainFrame)
OpenIcon.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

local ExitBtn = Instance.new("TextButton")
ExitBtn.Parent = MainFrame; ExitBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50); ExitBtn.Position = UDim2.new(1, -30, 0, 5); ExitBtn.Size = UDim2.new(0, 25, 0, 25); ExitBtn.Text = "X"; ExitBtn.TextColor3 = Color3.new(1, 1, 1); ExitBtn.Font = Enum.Font.SourceSansBold; ExitBtn.ZIndex = 60
ExitBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- --- 3. SIDEBAR & PAGES ---
local Sidebar = Instance.new("Frame")
Sidebar.Parent = MainFrame; Sidebar.Size = UDim2.new(0, 80, 1, -40); Sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
local PageContainer = Instance.new("Frame")
PageContainer.Parent = MainFrame; PageContainer.Position = UDim2.new(0, 85, 0, 40); PageContainer.Size = UDim2.new(1, -95, 1, -80); PageContainer.BackgroundTransparency = 1

local AllPages = {}
local function CreatePage(name, visible)
    local Page = Instance.new("ScrollingFrame")
    Page.Name = name; Page.Parent = PageContainer; Page.Size = UDim2.new(1, 0, 1, 0); Page.BackgroundTransparency = 1; Page.ScrollBarThickness = 2; Page.Visible = visible; Page.CanvasSize = UDim2.new(0, 0, 1.5, 0)
    local Layout = Instance.new("UIListLayout"); Layout.Parent = Page; Layout.Padding = UDim.new(0, 8); AllPages[name] = Page; return Page
end

local Page1 = CreatePage("Player", true); local Page2 = CreatePage("Survival", false); local Page3 = CreatePage("Killer", false); local Page4 = CreatePage("ESP", false)

-- --- 4. TOGGLE FUNCTION WITH NUMBER ---
local function AddToggle(parent, num, text, callback)
    local active = false
    local b = Instance.new("TextButton")
    b.Parent = parent; b.Size = UDim2.new(1, -5, 0, 35); b.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    b.Text = num..". "..text..": OFF"; b.TextColor3 = Color3.new(1, 1, 1); b.Font = Enum.Font.SourceSansBold; b.TextSize = 12
    local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 6); c.Parent = b
    b.MouseButton1Click:Connect(function()
        active = not active
        b.BackgroundColor3 = active and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(50, 50, 50)
        b.Text = active and num..". "..text..": ON" or num..". "..text..": OFF"
        callback(active)
    end)
end

-- --- 5. CORE FUNCTIONS (ESP LOGIC) ---
local function ESP_Player(state, role, color)
    _G[role.."_ESP"] = state
    task.spawn(function()
        while _G[role.."_ESP"] do
            task.wait(1)
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= game.Players.LocalPlayer and p.Character then
                    local isK = p.Character:FindFirstChild("Knife") or (p.Team and p.Team.Name:lower():find("killer"))
                    if (role == "Killer" and isK) or (role == "Surv" and not isK) then
                        local hi = p.Character:FindFirstChild("BD_ESP") or Instance.new("Highlight", p.Character)
                        hi.Name = "BD_ESP"; hi.FillColor = color; hi.AlwaysOnTop = true
                    end
                end
            end
        end
        for _, p in pairs(game.Players:GetPlayers()) do if p.Character and p.Character:FindFirstChild("BD_ESP") then p.Character.BD_ESP:Destroy() end end
    end)
end

-- --- 6. FILLING THE PAGES ---

-- PAGE 1: PLAYER
AddToggle(Page1, "1", "Walkspeed (High)", function(s) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s and 50 or 16 end)
AddToggle(Page1, "2", "Infinite Jump", function(s) _G.InfJump = s end)
game:GetService("UserInputService").JumpRequest:Connect(function() if _G.InfJump then game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping") end end)

-- PAGE 2: SURVIVAL
AddToggle(Page2, "1", "ESP Killer (Red)", function(s) ESP_Player(s, "Killer", Color3.new(1,0,0)) end)

-- PAGE 3: KILLER
AddToggle(Page3, "1", "ESP Survivor (Green)", function(s) ESP_Player(s, "Surv", Color3.new(0,1,0)) end)

-- PAGE 4: ESP
AddToggle(Page4, "1", "Full Bright", function(s) game.Lighting.Brightness = s and 2 or 1; game.Lighting.ClockTime = s and 12 or 0 end)
AddToggle(Page4, "2", "ESP Object", function(s) -- Logic Object ESP placeholder
    print("ESP Object Toggled: "..tostring(s))
end)

-- NAVIGASI SIDEBAR
local function AddTab(num, txt)
    local b = Instance.new("TextButton"); b.Parent = Sidebar; b.Size = UDim2.new(1, 0, 0, 45)
    b.Text = num..". "..txt; b.BackgroundColor3 = Color3.fromRGB(45, 45, 45); b.TextColor3 = Color3.new(1, 1, 1); b.Font = Enum.Font.SourceSansBold; b.TextSize = 11
    b.MouseButton1Click:Connect(function() for _, p in pairs(AllPages) do p.Visible = false end; AllPages[txt].Visible = true end)
end
AddTab("1", "Player"); AddTab("2", "Survival"); AddTab("3", "Killer"); AddTab("4", "ESP")

-- FOOTER
local Footer = Instance.new("TextLabel"); Footer.Parent = MainFrame; Footer.Position = UDim2.new(0, 0, 1, -25); Footer.Size = UDim2.new(1, 0, 0, 20); Footer.BackgroundTransparency = 1; Footer.Text = "@BoDcChii | v1.2"; Footer.TextColor3 = Color3.fromRGB(255, 105, 180); Footer.Font = Enum.Font.SourceSansBold; Footer.TextSize = 13; Footer.ZIndex = 60
