-- [[ BoDcChii Project - v4.2: BD Edition 🎸 ]] --

local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")

-- Bersihkan versi sebelumnya
if CoreGui:FindFirstChild("BoDcChii_Minimalist") then
    CoreGui.BoDcChii_Minimalist:Destroy()
end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "BoDcChii_Minimalist"
ScreenGui.ResetOnSpawn = false

-- --- 1. ICON TEKS "BD" ---
local OpenButton = Instance.new("TextButton", ScreenGui)
OpenButton.Size = UDim2.new(0, 50, 0, 50)
OpenButton.Position = UDim2.new(0, 20, 0.5, -25)
OpenButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
OpenButton.Text = "BD" 
OpenButton.TextColor3 = Color3.fromRGB(255, 105, 180)
OpenButton.TextSize = 24
OpenButton.Font = Enum.Font.SourceSansBold
OpenButton.ZIndex = 500

local IconCorner = Instance.new("UICorner", OpenButton)
IconCorner.CornerRadius = UDim.new(0, 12)
local IconStroke = Instance.new("UIStroke", OpenButton)
IconStroke.Color = Color3.fromRGB(255, 105, 180)
IconStroke.Thickness = 2

-- --- 2. HALAMAN FITUR ---
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 240, 0, 180)
MainFrame.Position = UDim2.new(0.5, -120, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Visible = false
MainFrame.Active = true

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
local FrameStroke = Instance.new("UIStroke", MainFrame)
FrameStroke.Color = Color3.fromRGB(255, 105, 180)
FrameStroke.Thickness = 2

local Header = Instance.new("TextLabel", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 40)
Header.Text = "BoDcChii Project"
Header.TextColor3 = Color3.new(1, 1, 1)
Header.BackgroundTransparency = 1
Header.Font = Enum.Font.SourceSansBold
Header.TextSize = 18

local Line = Instance.new("Frame", MainFrame)
Line.Size = UDim2.new(0.9, 0, 0, 2)
Line.Position = UDim2.new(0.05, 0, 0, 40)
Line.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
Line.BorderSizePixel = 0

-- --- 3. LOGIKA ESP GENERATOR ---
local genActive = false

local function ApplyGenESP(obj)
    if not obj:FindFirstChild("BochiTag") then
        local h = Instance.new("Highlight", obj)
        h.Name = "BochiTag"
        h.FillColor = Color3.fromRGB(0, 255, 255) -- Warna Cyan
        h.AlwaysOnTop = true
    end
end

task.spawn(function()
    while true do
        if genActive then
            -- Jalur folder khusus Violence District
            local map = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Map")
            local genFolder = map and map:FindFirstChild("Generator")
            
            if genFolder then
                for _, g in pairs(genFolder:GetChildren()) do
                    ApplyGenESP(g)
                end
            end
        else
            -- Hapus ESP jika OFF
            for _, v in pairs(workspace:GetDescendants()) do
                if v.Name == "BochiTag" then v:Destroy() end
            end
        end
        task.wait(2)
    end
end)

-- --- 4. TOMBOL ESP GENERATOR (MERAH/HIJAU) ---
local GenBtn = Instance.new("TextButton", MainFrame)
GenBtn.Size = UDim2.new(0.9, 0, 0, 45)
GenBtn.Position = UDim2.new(0.05, 0, 0, 55)
GenBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50) -- Default Merah
GenBtn.Text = "ESP Generator: OFF"
GenBtn.TextColor3 = Color3.new(1, 1, 1)
GenBtn.Font = Enum.Font.SourceSansBold
GenBtn.TextSize = 14
Instance.new("UICorner", GenBtn)

GenBtn.MouseButton1Click:Connect(function()
    genActive = not genActive
    if genActive then
        GenBtn.BackgroundColor3 = Color3.fromRGB(50, 180, 50) -- Hijau
        GenBtn.Text = "ESP Generator: ON"
    else
        GenBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50) -- Merah
        GenBtn.Text = "ESP Generator: OFF"
    end
end)

-- --- 5. SISTEM BUKA/TUTUP & EXIT ---
OpenButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

local Exit = Instance.new("TextButton", MainFrame)
Exit.Size = UDim2.new(0, 25, 0, 25)
Exit.Position = UDim2.new(1, -30, 0, 7)
Exit.Text = "X"
Exit.TextColor3 = Color3.new(1, 1, 1)
Exit.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
Instance.new("UICorner", Exit).CornerRadius = UDim.new(1, 0)
Exit.MouseButton1Click:Connect(function() MainFrame.Visible = false end)

-- --- 6. DRAG SYSTEM ---
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