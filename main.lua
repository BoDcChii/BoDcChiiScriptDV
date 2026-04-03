-- [[ BoDcChii Project - v4.9: Cyan Aura Final Visual 🎸 ]] --

local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")

-- Bersihkan versi lama agar visual tidak menumpuk
if CoreGui:FindFirstChild("BoDcChii_Minimalist") then
    CoreGui.BoDcChii_Minimalist:Destroy()
end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "BoDcChii_Minimalist"
ScreenGui.ResetOnSpawn = false

-- --- 1. ICON TEKS "BD" (TETAP MERAH MUDA) ---
local OpenButton = Instance.new("TextButton", ScreenGui)
OpenButton.Size = UDim2.new(0, 50, 0, 50)
OpenButton.Position = UDim2.new(0, 20, 0.5, -25)
OpenButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
OpenButton.Text = "BD"; OpenButton.TextColor3 = Color3.fromRGB(255, 105, 180) -- Pink
OpenButton.TextSize = 24; OpenButton.Font = Enum.Font.SourceSansBold
OpenButton.ZIndex = 500
Instance.new("UICorner", OpenButton).CornerRadius = UDim.new(0, 12)
local IconStroke = Instance.new("UIStroke", OpenButton)
IconStroke.Color = Color3.fromRGB(255, 105, 180); IconStroke.Thickness = 2

-- --- 2. HALAMAN FITUR (KOSONG) ---
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 240, 0, 180)
MainFrame.Position = UDim2.new(0.5, -120, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Visible = false; MainFrame.Active = true

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
local FrameStroke = Instance.new("UIStroke", MainFrame)
FrameStroke.Color = Color3.fromRGB(255, 105, 180); FrameStroke.Thickness = 2

local Header = Instance.new("TextLabel", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 40); Header.Text = "BoDcChii Project"; Header.TextColor3 = Color3.new(1, 1, 1)
Header.BackgroundTransparency = 1; Header.Font = Enum.Font.SourceSansBold; Header.TextSize = 18

local Line = Instance.new("Frame", MainFrame)
Line.Size = UDim2.new(0.9, 0, 0, 2); Line.Position = UDim2.new(0.05, 0, 0, 40)
Line.BackgroundColor3 = Color3.fromRGB(255, 105, 180); Line.BorderSizePixel = 0

-- --- 3. LOGIKA CAHAYA AURA (VISUAL UPDATE) ---
local genActive = false

-- Fungsi membuat Cahaya Cyan Solid
local function ApplyAura(obj)
    if not obj:FindFirstChild("BochiCyan_Aura") then
        local highlight = Instance.new("Highlight")
        highlight.Name = "BochiCyan_Aura"
        highlight.Parent = obj
        highlight.FillColor = Color3.fromRGB(0, 255, 255) -- Cyan
        highlight.OutlineColor = Color3.new(1, 1, 1) -- Garis Putih
        highlight.FillTransparency = 0.4 -- Agak tebal agar terlihat seperti aura
        highlight.OutlineTransparency = 0 -- Garis luar terlihat jelas
        highlight.AlwaysOnTop = true -- Menembus Tembok (Wajib)
    end
end

-- Looping Utama (Menggunakan Logika Perk v4.8)
task.spawn(function()
    while true do
        if genActive then
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Model") then
                    -- Cek ada ProximityPrompt (Cara interaksi survivor)
                    local prompt = v:FindFirstChildWhichIsA("ProximityPrompt", true)
                    
                    if prompt and (prompt.ObjectText:find("Gen") or prompt.ActionText:find("Repair")) then
                        -- JIKA MEMENUHI SYARAT, KASIH CAHAYA CYAN
                        ApplyAura(v)
                    end
                end
            end
        else
            -- Hapus Cahaya saat OFF
            for _, v in pairs(workspace:GetDescendants()) do
                if v.Name == "BochiCyan_Aura" then v:Destroy() end
            end
        end
        task.wait(2) -- Scan berkala
    end
end)

-- --- 4. TOMBOL TOGGLE ---
local GenBtn = Instance.new("TextButton", MainFrame)
GenBtn.Size = UDim2.new(0.9, 0, 0, 45); GenBtn.Position = UDim2.new(0.05, 0, 0, 60)
GenBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50) -- Default Merah
GenBtn.Text = "Cyan Aura: OFF"; GenBtn.TextColor3 = Color3.new(1, 1, 1)
GenBtn.Font = Enum.Font.SourceSansBold; GenBtn.TextSize = 14; Instance.new("UICorner", GenBtn)

GenBtn.MouseButton1Click:Connect(function()
    genActive = not genActive
    GenBtn.BackgroundColor3 = genActive and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(180, 50, 50)
    GenBtn.Text = genActive and "Cyan Aura: ON" or "Cyan Aura: OFF"
end)

-- --- 5. LOGIKA BUKA/TUTUP & EXIT ---
OpenButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
local Exit = Instance.new("TextButton", MainFrame)
Exit.Size = UDim2.new(0, 25, 0, 25); Exit.Position = UDim2.new(1, -30, 0, 7); Exit.Text = "X"
Exit.BackgroundColor3 = Color3.fromRGB(200, 50, 50); Instance.new("UICorner", Exit).CornerRadius = UDIm.new(1, 0)
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