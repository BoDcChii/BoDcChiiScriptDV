-- [[ BoDcChii Project - v4.6: Visual Detection Final 🎸 ]] --

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

-- --- 3. LOGIKA VISUAL DETECTION (SESUAI PANDUANMU) ---
local genActive = false

task.spawn(function()
    while true do
        if genActive then
            for _, obj in pairs(workspace:GetDescendants()) do
                -- Hanya deteksi Part fisik
                if obj:IsA("BasePart") then
                    -- Filter objek yang besarnya masuk akal sebagai generator (> 5)
                    if obj.Size.Magnitude > 5 then
                        -- Pastikan ini bukan bagian dari tubuh Player (Humanoid)
                        if not obj.Parent:FindFirstChild("Humanoid") then
                            -- Pastikan objeknya terlihat (bukan part invisible)
                            if obj.Transparency < 0.5 then
                                -- Pasang ESP jika belum ada
                                if not obj:FindFirstChild("BochiESP_Gen") then
                                    local h = Instance.new("Highlight")
                                    h.Name = "BochiESP_Gen"
                                    h.FillColor = Color3.fromRGB(0, 255, 255) -- Cyan
                                    h.OutlineColor = Color3.new(1, 1, 1)
                                    h.FillTransparency = 0.4
                                    h.AlwaysOnTop = true
                                    h.Parent = obj
                                end
                            end
                        end
                    end
                end
            end
        else
            -- Hapus semua ESP saat OFF
            for _, v in pairs(workspace:GetDescendants()) do
                if v.Name == "BochiESP_Gen" then
                    v:Destroy()
                end
            end
        end
        task.wait(1) -- Scan cepat tiap detik
    end
end)

-- --- 4. TOMBOL TOGGLE ---
local GenBtn = Instance.new("TextButton", MainFrame)
GenBtn.Size = UDim2.new(0.9, 0, 0, 45); GenBtn.Position = UDim2.new(0.05, 0, 0, 60)
GenBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
GenBtn.Text = "ESP Generator: OFF"; GenBtn.TextColor3 = Color3.new(1, 1, 1)
GenBtn.Font = Enum.Font.SourceSansBold; Instance.new("UICorner", GenBtn)

GenBtn.MouseButton1Click:Connect(function()
    genActive = not genActive
    GenBtn.BackgroundColor3 = genActive and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(180, 50, 50)
    GenBtn.Text = genActive and "ESP Generator: ON" or "ESP Generator: OFF"
end)

-- --- 5. BUKA/TUTUP & DRAG ---
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