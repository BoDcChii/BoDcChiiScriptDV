-- [[ BoDcChii Project - v4.8: Perk Survivor Logic 🎸 ]] --

local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")

-- Bersihkan versi lama
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
MainFrame.Size = UDim2.new(0, 240, 0, 180)
MainFrame.Position = UDim2.new(0.5, -120, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Visible = false; MainFrame.Active = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(255, 105, 180)

local Header = Instance.new("TextLabel", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 40); Header.Text = "BoDcChii Project"; Header.TextColor3 = Color3.new(1, 1, 1)
Header.BackgroundTransparency = 1; Header.Font = Enum.Font.SourceSansBold; Header.TextSize = 18

local Line = Instance.new("Frame", MainFrame)
Line.Size = UDim2.new(0.9, 0, 0, 2); Line.Position = UDim2.new(0.05, 0, 0, 40)
Line.BackgroundColor3 = Color3.fromRGB(255, 105, 180); Line.BorderSizePixel = 0

-- --- 3. LOGIKA PERK AURA (SURVIVOR SENSE) ---
local genActive = false

local function CreateAura(obj)
    if not obj:FindFirstChild("BochiAura") then
        local bill = Instance.new("BillboardGui")
        bill.Name = "BochiAura"
        bill.Size = UDim2.new(0, 80, 0, 30)
        bill.AlwaysOnTop = true
        bill.Parent = obj
        
        local txt = Instance.new("TextLabel", bill)
        txt.Size = UDim2.new(1,0,1,0)
        txt.BackgroundTransparency = 1
        txt.Text = "⚡ GEN" -- Simbol petir biar keren
        txt.TextColor3 = Color3.fromRGB(0, 255, 255)
        txt.TextStrokeTransparency = 0
        txt.Font = Enum.Font.SourceSansBold
        txt.TextScaled = true
    end
end

task.spawn(function()
    while true do
        if genActive then
            -- MENCARI BERDASARKAN "TANDA" PERK
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Model") then
                    -- 1. Cek apakah ada ProximityPrompt (Cara interaksi survivor)
                    local prompt = v:FindFirstChildWhichIsA("ProximityPrompt", true)
                    -- 2. Cek apakah ada script/value yang mengandung kata "Gen" atau "Repair"
                    local isGen = false
                    
                    if prompt and (prompt.ObjectText:find("Gen") or prompt.ActionText:find("Repair")) then
                        isGen = true
                    end
                    
                    -- 3. Cek folder khusus lagi (Double Check)
                    if v.Name:lower():find("generator") then
                        isGen = true
                    end

                    if isGen then
                        -- Cari part terdekat di model tersebut untuk ditempeli teks
                        local p = v:FindFirstChildWhichIsA("BasePart", true)
                        if p then CreateAura(p) end
                    end
                end
            end
        else
            for _, v in pairs(workspace:GetDescendants()) do
                if v.Name == "BochiAura" then v:Destroy() end
            end
        end
        task.wait(2)
    end
end)

-- --- 4. TOMBOL TOGGLE ---
local GenBtn = Instance.new("TextButton", MainFrame)
GenBtn.Size = UDim2.new(0.9, 0, 0, 45); GenBtn.Position = UDim2.new(0.05, 0, 0, 60)
GenBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
GenBtn.Text = "Aura Perk: OFF"; GenBtn.TextColor3 = Color3.new(1, 1, 1)
GenBtn.Font = Enum.Font.SourceSansBold; Instance.new("UICorner", GenBtn)

GenBtn.MouseButton1Click:Connect(function()
    genActive = not genActive
    GenBtn.BackgroundColor3 = genActive and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(180, 50, 50)
    GenBtn.Text = genActive and "Aura Perk: ON" or "Aura Perk: OFF"
end)

-- --- 5. BUKA/TUTUP & DRAG ---
OpenButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
local Exit = Instance.new("TextButton", MainFrame)
Exit.Size = UDim2.new(0, 25, 0, 25); Exit.Position = UDim2.new(1, -30, 0, 7); Exit.Text = "X"
Exit.BackgroundColor3 = Color3.fromRGB(200, 50, 50); Instance.new("UICorner", Exit).CornerRadius = UDim.new(1, 0)
Exit.MouseButton1Click:Connect(function() MainFrame.Visible = false end)

-- SISTEM DRAG SIMPLE
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