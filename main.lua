-- [[ BoDcChii Project - v2.9: Back to Basics 🎸 ]] --

local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")

-- --- UI BASE ---
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "BoDcChii_Final_v29"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 260, 0, 180)
MainFrame.Position = UDim2.new(0.5, -130, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Visible = false
MainFrame.Active = true
Instance.new("UICorner", MainFrame)
Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(255, 105, 180)

local OpenIcon = Instance.new("ImageButton", ScreenGui)
OpenIcon.Size = UDim2.new(0, 50, 0, 50)
OpenIcon.Position = UDim2.new(0, 20, 0.5, -25)
OpenIcon.Image = "rbxassetid://12130312683"
OpenIcon.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", OpenIcon).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", OpenIcon).Color = Color3.fromRGB(255, 105, 180)

-- DRAG SYSTEM
local dragging, dragStart, startPos
OpenIcon.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true; dragStart = input.Position; startPos = OpenIcon.Position
    end
end)
UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - dragStart
        OpenIcon.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UIS.InputEnded:Connect(function(input) dragging = false end)

OpenIcon.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- --- LOGIKA ESP (VERSI AWAL YANG BISA) ---
local genActive, palActive = false, false

task.spawn(function()
    while true do
        if genActive or palActive then
            -- Scan semua objek di Workspace
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if v:IsA("Model") or v:IsA("BasePart") then
                    local name = v.Name:lower()
                    
                    -- Deteksi Generator (Logic Awal)
                    if genActive and (name:find("generator") or name:find("gen")) then
                        if not v:FindFirstChild("Bochi_ESP") then
                            local h = Instance.new("Highlight", v)
                            h.Name = "Bochi_ESP"
                            h.FillColor = Color3.fromRGB(0, 255, 255) -- Cyan
                            h.AlwaysOnTop = true
                        end
                    end
                    
                    -- Deteksi Pallet (Logic Awal)
                    if palActive and (name:find("pallet") or name:find("palet")) then
                        if not v:FindFirstChild("Bochi_ESP_Pal") then
                            local h = Instance.new("Highlight", v)
                            h.Name = "Bochi_ESP_Pal"
                            h.FillColor = Color3.fromRGB(255, 255, 0) -- Kuning
                            h.AlwaysOnTop = true
                        end
                    end
                end
            end
        else
            -- Cleanup Instan
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if v.Name == "Bochi_ESP" or v.Name == "Bochi_ESP_Pal" then v:Destroy() end
            end
        end
        task.wait(2) -- Jeda biar gak lag
    end
end)

-- --- BUTTON HOLDER ---
local Holder = Instance.new("Frame", MainFrame)
Holder.Size = UDim2.new(1, -20, 1, -20); Holder.Position = UDim2.new(0, 10, 0, 10); Holder.BackgroundTransparency = 1
local Layout = Instance.new("UIListLayout", Holder); Layout.Padding = UDim.new(0, 10)

local function CreateToggle(text, callback)
    local b = Instance.new("TextButton", Holder)
    b.Size = UDim2.new(1, 0, 0, 45); b.BackgroundColor3 = Color3.fromRGB(180, 50, 50) -- MERAH
    b.Text = text..": OFF"; b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.SourceSansBold; Instance.new("UICorner", b)
    
    local state = false
    b.MouseButton1Click:Connect(function()
        state = not state
        b.BackgroundColor3 = state and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(180, 50, 50) -- HIJAU/MERAH
        b.Text = state and text..": ON" or text..": OFF"
        callback(state)
    end)
end

CreateToggle("1. ESP Generator", function(s) genActive = s end)
CreateToggle("2. ESP Pallet", function(s) palActive = s end)

-- EXIT
local Exit = Instance.new("TextButton", MainFrame)
Exit.Size = UDim2.new(0, 25, 0, 25); Exit.Position = UDim2.new(1, -30, 0, 5); Exit.Text = "X"
Exit.BackgroundColor3 = Color3.new(1, 0, 0); Exit.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)