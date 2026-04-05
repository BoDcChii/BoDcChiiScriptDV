-- [[ BoDcChii Project - v4.9: THE LOCKED MASTER 🎸 ]] --
-- Update: Fixed ESP Generator (Deep Search) + Locked Features

local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")

-- --- 0. ANTI-REDUNDANT ---
if CoreGui:FindFirstChild("BoDcChii_Minimalist") then CoreGui.BoDcChii_Minimalist:Destroy() end
if CoreGui:FindFirstChild("BoDcChii_Welcome") then CoreGui.BoDcChii_Welcome:Destroy() end

-- --- 1. WELCOME NOTIFICATION (2 DETIK) ---
local function ShowWelcome()
    local WelcomeGui = Instance.new("ScreenGui", CoreGui)
    WelcomeGui.Name = "BoDcChii_Welcome"
    local WelcomeFrame = Instance.new("Frame", WelcomeGui)
    WelcomeFrame.Size = UDim2.new(0, 220, 0, 45)
    WelcomeFrame.Position = UDim2.new(0.5, -110, 0.1, 0)
    WelcomeFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Instance.new("UICorner", WelcomeFrame).CornerRadius = UDim.new(0, 10)
    local Stroke = Instance.new("UIStroke", WelcomeFrame)
    Stroke.Color = Color3.fromRGB(255, 105, 180); Stroke.Thickness = 2
    
    local WelcomeLabel = Instance.new("TextLabel", WelcomeFrame)
    WelcomeLabel.Size = UDim2.new(1, 0, 1, 0); WelcomeLabel.BackgroundTransparency = 1
    WelcomeLabel.Text = "Welcome To BoDcChii Project"; WelcomeLabel.TextColor3 = Color3.new(1, 1, 1)
    WelcomeLabel.TextSize = 14; WelcomeLabel.Font = Enum.Font.SourceSansBold
    
    task.delay(2, function() WelcomeGui:Destroy() end)
end
pcall(ShowWelcome)

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "BoDcChii_Minimalist"; ScreenGui.ResetOnSpawn = false

-- --- FUNGSI DRAG ---
local function EnableDrag(gui)
    local dragging, dragStart, startPos
    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = gui.Position
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UIS.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end end)
end

-- --- 2. ICON "BD" ---
local OpenButton = Instance.new("TextButton", ScreenGui)
OpenButton.Size = UDim2.new(0, 50, 0, 50); OpenButton.Position = UDim2.new(0, 20, 0.5, -25)
OpenButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30); OpenButton.Text = "BD" 
OpenButton.TextColor3 = Color3.fromRGB(255, 105, 180); OpenButton.TextSize = 24
OpenButton.Font = Enum.Font.SourceSansBold; OpenButton.ZIndex = 500
Instance.new("UICorner", OpenButton).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", OpenButton).Color = Color3.fromRGB(255, 105, 180)
EnableDrag(OpenButton)

-- --- 3. MAIN FRAME ---
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 240, 0, 240); MainFrame.Position = UDim2.new(0.5, -120, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15); MainFrame.Visible = false; MainFrame.Active = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(255, 105, 180)
EnableDrag(MainFrame)

local Header = Instance.new("TextLabel", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 35); Header.Text = "BoDcChii Project"; Header.TextColor3 = Color3.fromRGB(255, 105, 180)
Header.BackgroundTransparency = 1; Header.Font = Enum.Font.SourceSansBold; Header.TextSize = 18

local ScrollFrame = Instance.new("ScrollingFrame", MainFrame)
ScrollFrame.Size = UDim2.new(1, -10, 1, -45); ScrollFrame.Position = UDim2.new(0, 5, 0, 40)
ScrollFrame.BackgroundTransparency = 1; ScrollFrame.ScrollBarThickness = 3
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 105, 180); ScrollFrame.BorderSizePixel = 0
local UIList = Instance.new("UIListLayout", ScrollFrame)
UIList.SortOrder = Enum.SortOrder.LayoutOrder; UIList.Padding = UDim.new(0, 5); UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function CreateBtn(parent, text)
    local btn = Instance.new("TextButton", parent); btn.Size = UDim2.new(0.95, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25); btn.Text = text .. ": OFF"; btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold; btn.TextSize = 11; Instance.new("UICorner", btn)
    local s = Instance.new("UIStroke", btn); s.Color = Color3.fromRGB(200, 50, 50)
    return btn
end

local function CreateCat(text)
    local btn = Instance.new("TextButton", ScrollFrame); btn.Size = UDim2.new(0.95, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30); btn.Text = "[ " .. text .. " ]  +"; btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold; btn.TextSize = 13; Instance.new("UICorner", btn)
    return btn
end

local function CreateFrame(size)
    local f = Instance.new("Frame", ScrollFrame); f.Size = UDim2.new(0.95, 0, 0, size)
    f.BackgroundTransparency = 1; f.Visible = false
    local l = Instance.new("UIListLayout", f); l.Padding = UDim.new(0, 5)
    return f
end

-- --- 4. CATEGORIES & FEATURES ---
local Cat1 = CreateCat("PLAYER ESP")
local Frame1 = CreateFrame(80)
local _SurvOn, _KillOn = false, false
local SurvBtn = CreateBtn(Frame1, "ESP SURVIVAL")
local KillBtn = CreateBtn(Frame1, "ESP KILLER")

local Cat2 = CreateCat("SURVIVAL SKILLS")
local Frame2 = CreateFrame(80)
local _GenOn, _NoSkillGen = false, false
local GenBtn = CreateBtn(Frame2, "ESP GENERATOR")
local SkillBtn = CreateBtn(Frame2, "NO SKILL CHECK GENERATOR")

local Cat3 = CreateCat("SMOOTH MAPS")
local Frame3 = CreateFrame(80)
local _FullBright, _NoFog = false, false
local BrightBtn = CreateBtn(Frame3, "FULL BRIGHT")
local FogBtn = CreateBtn(Frame3, "NO FOG / MIST")

local function Refresh() ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, UIList.AbsoluteContentSize.Y + 15) end
Cat1.MouseButton1Click:Connect(function() Frame1.Visible = not Frame1.Visible Cat1.Text = Frame1.Visible and "[ PLAYER ESP ]  -" or "[ PLAYER ESP ]  +" Refresh() end)
Cat2.MouseButton1Click:Connect(function() Frame2.Visible = not Frame2.Visible Cat2.Text = Frame2.Visible and "[ SURVIVAL SKILLS ]  -" or "[ SURVIVAL SKILLS ]  +" Refresh() end)
Cat3.MouseButton1Click:Connect(function() Frame3.Visible = not Frame3.Visible Cat3.Text = Frame3.Visible and "[ SMOOTH MAPS ]  -" or "[ SMOOTH MAPS ]  +" Refresh() end)

-- --- 5. LOGIKA FITUR ---
local function Toggle(btn, state, txt)
    btn.Text = txt .. (state and ": ON" or ": OFF")
    btn.UIStroke.Color = state and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
end

SurvBtn.MouseButton1Click:Connect(function() _SurvOn = not _SurvOn Toggle(SurvBtn, _SurvOn, "ESP SURVIVAL") end)
KillBtn.MouseButton1Click:Connect(function() _KillOn = not _KillOn Toggle(KillBtn, _KillOn, "ESP KILLER") end)
GenBtn.MouseButton1Click:Connect(function() _GenOn = not _GenOn Toggle(GenBtn, _GenOn, "ESP GENERATOR") end)
SkillBtn.MouseButton1Click:Connect(function() _NoSkillGen = not _NoSkillGen Toggle(SkillBtn, _NoSkillGen, "NO SKILL CHECK GENERATOR") end)
BrightBtn.MouseButton1Click:Connect(function() _FullBright = not _FullBright Toggle(BrightBtn, _FullBright, "FULL BRIGHT") end)
FogBtn.MouseButton1Click:Connect(function() _NoFog = not _NoFog Toggle(FogBtn, _NoFog, "NO FOG / MIST") end)

RunService.Heartbeat:Connect(function()
    if _FullBright then Lighting.Ambient = Color3.new(1, 1, 1); Lighting.ClockTime = 12 end
    if _NoFog then Lighting.FogEnd = 999999 end
    
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= Players.LocalPlayer and p.Character then
            local hl = p.Character:FindFirstChild("BDEsp") or Instance.new("Highlight", p.Character)
            hl.Name = "BDEsp"
            local isK = (p.Team and p.Team.Name:lower():find("kill")) or (p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.MaxHealth > 100)
            hl.Enabled = (isK and _KillOn) or (not isK and _SurvOn)
            hl.FillColor = isK and Color3.new(1, 0, 0) or Color3.new(0, 1, 0)
        end
    end

    -- --- FIX KHUSUS ESP GENERATOR ---
    if _GenOn then
        for _, v in pairs(game.Workspace:GetDescendants()) do
            if (v.Name:find("Gen") or v.Name:find("Generator")) and (v:IsA("Model") or v:IsA("BasePart")) then
                local h = v:FindFirstChild("GenEsp")
                if not h then
                    h = Instance.new("Highlight")
                    h.Name = "GenEsp"
                    h.Parent = v
                    h.FillColor = Color3.fromRGB(255, 255, 0)
                    h.OutlineColor = Color3.new(1, 1, 1)
                    h.FillTransparency = 0.5
                end
                h.Enabled = true
            end
        end
    else
        for _, v in pairs(game.Workspace:GetDescendants()) do
            local h = v:FindFirstChild("GenEsp")
            if h then h.Enabled = false end
        end
    end
end)

local mt = getrawmetatable(game)
if mt then
    local old = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if _NoSkillGen and (method == "FireServer" or method == "InvokeServer") then
            local n = tostring(self):lower()
            if n:find("fail") or n:find("skillcheck") or n:find("explode") then return nil end
        end
        return old(self, ...)
    end)
    setreadonly(mt, true)
end

OpenButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)