-- [[ BoDcChii Project - v4.3: Deep Scan Edition 🎸 ]] --

local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")

-- Membersihkan UI lama agar tidak menumpuk
if CoreGui:FindFirstChild("BoDcChii_Minimalist") then
    CoreGui.BoDcChii_Minimalist:Destroy()
end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "BoDcChii_Minimalist"
ScreenGui.ResetOnSpawn = false

-- --- 1. ICON TEKS "BD" (PINK THEME) ---
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

-- --- 3. LOGIKA SISTEM PAHAM (DEEP SCAN) ---
local genActive = false

-- Fungsi membuat cahaya (Highlight)
local function CreateESP(target)
    if not target:FindFirstChild("BochiESP_Gen") then
        local highlight = Instance.new("Highlight")
        highlight.Name = "BochiESP_Gen"
        highlight.Parent = target
        highlight.FillColor = Color3.fromRGB(0, 255, 255) -- Cyan
        highlight.OutlineColor = Color3.new(1, 1, 1)
        highlight.FillTransparency = 0.4
        highlight.AlwaysOnTop = true
    end
end

-- Fungsi menghapus cahaya
local function RemoveESP()
    for _, v in pairs(game:GetDescendants()) do
        if v.Name == "BochiESP_Gen" then
            v:Destroy()
        end
    end
end

-- Looping Utama (Sistem Paham)
task.spawn(function()
    while true do
        if genActive then
            -- STRATEGI 1: Cek folder spesifik Violence District
            local mapData = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Map")
            local genFolder = mapData and mapData:FindFirstChild("Generator")
            
            if genFolder then
                -- Jika folder ditemukan, langsung scan isinya
                for _, obj in pairs(genFolder:GetChildren()) do
                    CreateESP(obj)
                end
            else
                -- STRATEGI 2: Jika folder tidak ketemu, scan seluruh Workspace (Deep Scan)
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("Model") or obj:IsA("BasePart") then
                        local name = obj.Name:lower()
                        -- Mencari kata kunci yang mungkin dipakai game
                        if name:find("generator") or name:find("gen_") or name:find("motor") then
                            CreateESP(obj)
                        end
                    end
                end
            end
        else
            RemoveESP()
        end
        task.wait(3) -- Memberi nafas agar eksekutor tidak crash
    end
end)

-- --- 4. TOMBOL TOGGLE (MERAH/HIJAU) ---
local GenBtn = Instance.new("TextButton", MainFrame)
GenBtn.Size = UDim2.new(0, 210, 0, 45)
GenBtn.Position = UDim2.new(0, 15, 0, 60)
GenBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50) -- Awal Merah
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

-- --- 5. LOGIKA BUKA/TUTUP & EXIT ---
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

-- --- 6. DRAG SYSTEM UNTUK ICON ---
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