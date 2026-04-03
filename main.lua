-- [[ BoDcChii Project - v5.2: Snapline World-to-Screen 🎸 ]] --

local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

-- Bersihkan UI
if CoreGui:FindFirstChild("BoDcChii_Minimalist") then
    CoreGui.BoDcChii_Minimalist:Destroy()
end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "BoDcChii_Minimalist"
ScreenGui.ResetOnSpawn = false

-- --- 1. ICON "BD" ---
local OpenButton = Instance.new("TextButton", ScreenGui)
OpenButton.Size = UDim2.new(0, 50, 0, 50); OpenButton.Position = UDim2.new(0, 20, 0.5, -25)
OpenButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30); OpenButton.Text = "BD"
OpenButton.TextColor3 = Color3.fromRGB(255, 105, 180); OpenButton.TextSize = 24
OpenButton.Font = Enum.Font.SourceSansBold; Instance.new("UICorner", OpenButton)

-- --- 2. MENU ---
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 240, 0, 180); MainFrame.Position = UDim2.new(0.5, -120, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15); MainFrame.Visible = false
Instance.new("UICorner", MainFrame); Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(255, 105, 180)

-- --- 3. LOGIKA WORLD-TO-SCREEN SNAPLINES ---
local genActive = false
local targets = {}

-- Fungsi nyari generator (Scanning Logic)
local function UpdateTargets()
    targets = {}
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("ProximityPrompt") and (v.ObjectText:find("Gen") or v.ActionText:find("Repair")) then
            local p = v.Parent:IsA("BasePart") and v.Parent or v.Parent:FindFirstChildWhichIsA("BasePart", true)
            if p then table.insert(targets, p) end
        end
    end
end

-- Rendering Loop (Visual Logic)
RunService.RenderStepped:Connect(function()
    -- Bersihkan garis lama tiap frame
    for _, v in pairs(ScreenGui:GetChildren()) do
        if v.Name == "BD_Line" then v:Destroy() end
    end

    if genActive then
        for _, target in pairs(targets) do
            if target and target.Parent then
                local screenPos, onScreen = Camera:WorldToViewportPoint(target.Position)
                
                if onScreen then
                    -- Buat Garis (Snapline)
                    local line = Instance.new("Frame", ScreenGui)
                    line.Name = "BD_Line"
                    line.BackgroundColor3 = Color3.fromRGB(0, 255, 255) -- Cyan
                    line.BorderSizePixel = 0
                    line.AnchorPoint = Vector2.new(0.5, 0.5)
                    
                    -- Tarik garis dari bawah tengah layar ke target
                    local startPos = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                    local endPos = Vector2.new(screenPos.X, screenPos.Y)
                    local distance = (startPos - endPos).Magnitude
                    
                    line.Size = UDim2.new(0, 2, 0, distance)
                    line.Position = UDim2.new(0, (startPos.X + endPos.X) / 2, 0, (startPos.Y + endPos.Y) / 2)
                    line.Rotation = math.deg(math.atan2(endPos.Y - startPos.Y, endPos.X - startPos.X)) - 90
                end
            end
        end
    end
end)

-- Update daftar target tiap 3 detik biar gak berat
task.spawn(function()
    while true do
        if genActive then UpdateTargets() end
        task.wait(3)
    end
end)

-- --- 4. TOMBOL TOGGLE ---
local GenBtn = Instance.new("TextButton", MainFrame)
GenBtn.Size = UDim2.new(0.9, 0, 0, 45); GenBtn.Position = UDim2.new(0.05, 0, 0, 60)
GenBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
GenBtn.Text = "Snapline ESP: OFF"; GenBtn.TextColor3 = Color3.new(1, 1, 1)
GenBtn.Font = Enum.Font.SourceSansBold; Instance.new("UICorner", GenBtn)

GenBtn.MouseButton1Click:Connect(function()
    genActive = not genActive
    GenBtn.BackgroundColor3 = genActive and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(180, 50, 50)
    GenBtn.Text = genActive and "Snapline ESP: ON" or "Snapline ESP: OFF"
end)

-- --- 5. DRAG & EXIT ---
OpenButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
local dragging, dragStart, startPos
OpenButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true; dragStart = input.Position; startPos = OpenButton.Position
    end
end)
UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - dragStart
        OpenButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UIS.InputEnded:Connect(function(input) dragging = false end)