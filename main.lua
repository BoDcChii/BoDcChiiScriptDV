-- [[ BoDcChii Project - v5.1: Force Tracker 🎸 ]] --

local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")

-- Bersihkan UI lama
if CoreGui:FindFirstChild("BoDcChii_Minimalist") then
    CoreGui.BoDcChii_Minimalist:Destroy()
end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "BoDcChii_Minimalist"
ScreenGui.ResetOnSpawn = false

-- --- 1. ICON TEKS "BD" ---
local OpenButton = Instance.new("TextButton", ScreenGui)
OpenButton.Size = UDim2.new(0, 50, 0, 50); OpenButton.Position = UDim2.new(0, 20, 0.5, -25)
OpenButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
OpenButton.Text = "BD"; OpenButton.TextColor3 = Color3.fromRGB(255, 105, 180)
OpenButton.TextSize = 24; OpenButton.Font = Enum.Font.SourceSansBold; OpenButton.ZIndex = 500
Instance.new("UICorner", OpenButton).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", OpenButton).Color = Color3.fromRGB(255, 105, 180)

-- --- 2. HALAMAN FITUR ---
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 240, 0, 180); MainFrame.Position = UDim2.new(0.5, -120, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15); MainFrame.Visible = false
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(255, 105, 180)

local Header = Instance.new("TextLabel", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 40); Header.Text = "BoDcChii Project"; Header.TextColor3 = Color3.new(1, 1, 1)
Header.BackgroundTransparency = 1; Header.Font = Enum.Font.SourceSansBold; Header.TextSize = 18

-- --- 3. LOGIKA PELAKAK PAKSA (FORCE ESP) ---
local genActive = false

local function CreateForceESP(target)
    if not target:FindFirstChild("Bochi_Tracker") then
        local bill = Instance.new("BillboardGui")
        bill.Name = "Bochi_Tracker"
        bill.Size = UDim2.new(0, 100, 0, 100)
        bill.AlwaysOnTop = true
        bill.Adornee = target
        bill.Parent = target

        -- Box Visual (Kotak Biru)
        local box = Instance.new("Frame", bill)
        box.Size = UDim2.new(0.8, 0, 0.8, 0)
        box.Position = UDim2.new(0.1, 0, 0.1, 0)
        box.BackgroundTransparency = 0.7
        box.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
        local stroke = Instance.new("UIStroke", box)
        stroke.Color = Color3.fromRGB(0, 255, 255)
        stroke.Thickness = 2

        -- Label Teks
        local label = Instance.new("TextLabel", bill)
        label.Size = UDim2.new(1, 0, 0.3, 0)
        label.Position = UDim2.new(0, 0, -0.4, 0)
        label.BackgroundTransparency = 1
        label.Text = "GENERATOR"
        label.TextColor3 = Color3.fromRGB(0, 255, 255)
        label.Font = Enum.Font.SourceSansBold
        label.TextScaled = true
        label.TextStrokeTransparency = 0
    end
end

task.spawn(function()
    while true do
        if genActive then
            -- Cari di seluruh Workspace tanpa ampun
            for _, v in pairs(workspace:GetDescendants()) do
                local isTarget = false
                
                -- Cek berdasarkan nama (Generator)
                if v.Name:lower():find("generator") then
                    isTarget = true
                end
                
                -- Cek berdasarkan isi interaksi (Repair/Fix)
                if not isTarget and v:IsA("ProximityPrompt") then
                    if v.ActionText:find("Repair") or v.ObjectText:find("Gen") then
                        isTarget = true
                        v = v.Parent -- Pasang ESP di Parent tombolnya
                    end
                end

                if isTarget and v:IsA("BasePart") or v:IsA("Model") then
                    local part = v:IsA("Model") and (v:FindFirstChild("MainPart") or v:FindFirstChildWhichIsA("BasePart", true)) or v
                    if part then CreateForceESP(part) end
                end
            end
        else
            for _, v in pairs(workspace:GetDescendants()) do
                if v.Name == "Bochi_Tracker" then v:Destroy() end
            end
        end
        task.wait(1.5) -- Scan lebih sering
    end
end)

-- --- 4. TOMBOL TOGGLE ---
local GenBtn = Instance.new("TextButton", MainFrame)
GenBtn.Size = UDim2.new(0.9, 0, 0, 45); GenBtn.Position = UDim2.new(0.05, 0, 0, 60)
GenBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
GenBtn.Text = "ESP Tracker: OFF"; GenBtn.TextColor3 = Color3.new(1, 1, 1)
GenBtn.Font = Enum.Font.SourceSansBold; Instance.new("UICorner", GenBtn)

GenBtn.MouseButton1Click:Connect(function()
    genActive = not genActive
    GenBtn.BackgroundColor3 = genActive and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(180, 50, 50)
    GenBtn.Text = genActive and "ESP Tracker: ON" or "ESP Tracker: OFF"
end)

-- --- 5. DRAG & EXIT (SINGKAT) ---
OpenButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
local Exit = Instance.new("TextButton", MainFrame)
Exit.Size = UDim2.new(0, 25, 0, 25); Exit.Position = UDim2.new(1, -30, 0, 7); Exit.Text = "X"
Exit.BackgroundColor3 = Color3.fromRGB(200, 50, 50); Instance.new("UICorner", Exit).CornerRadius = UDim.new(1, 0)
Exit.MouseButton1Click:Connect(function() MainFrame.Visible = false end)

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