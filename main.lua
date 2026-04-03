-- [[ BoDcChii Project - v3.3: Fixed Click & Drag 🎸 ]] --

local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")

-- --- UI BASE ---
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "BoDcChii_Final_v33"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 260, 0, 180)
MainFrame.Position = UDim2.new(0.5, -130, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.ZIndex = 100 -- Pastikan di depan
Instance.new("UICorner", MainFrame)
Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(255, 105, 180)

local OpenIcon = Instance.new("ImageButton", ScreenGui)
OpenIcon.Size = UDim2.new(0, 55, 0, 55)
OpenIcon.Position = UDim2.new(0, 20, 0.5, -27)
OpenIcon.Image = "rbxassetid://12130312683"
OpenIcon.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
OpenIcon.ZIndex = 105
Instance.new("UICorner", OpenIcon).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", OpenIcon).Color = Color3.fromRGB(255, 105, 180)

-- --- FUNGSI DRAG & CLICK SEPARATED ---
local dragging = false
local dragInput, dragStart, startPos
local moved = false -- Untuk cek apakah icon digeser atau cuma diklik

OpenIcon.InputBegan:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
        dragging = true
        moved = false -- Reset status gerak
        dragStart = input.Position
        startPos = OpenIcon.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        if delta.Magnitude > 5 then -- Jika geser lebih dari 5 pixel
            moved = true
            OpenIcon.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end
end)

UIS.InputEnded:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
        if dragging and not moved then
            -- JIKA TIDAK BERGERAK (CUMA DIKLIK), BUKA MENU
            MainFrame.Visible = not MainFrame.Visible
        end
        dragging = false
    end
end)

-- --- LOGIKA ESP VIOLENCE DISTRICT (MPAN PATH) ---
local genActive, palActive = false, false

task.spawn(function()
    while true do
        local mapFolder = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Map")
        
        if mapFolder then
            -- SCAN GENERATOR
            local genFolder = mapFolder:FindFirstChild("Generator")
            if genFolder then
                for _, g in pairs(genFolder:GetChildren()) do
                    if genActive then
                        if not g:FindFirstChild("BochiG") then
                            local h = Instance.new("Highlight", g)
                            h.Name = "BochiG"; h.FillColor = Color3.fromRGB(0, 255, 255); h.AlwaysOnTop = true
                        end
                    else
                        if g:FindFirstChild("BochiG") then g.BochiG:Destroy() end
                    end
                end
            end
            
            -- SCAN PALLET
            local palFolder = mapFolder:FindFirstChild("Pallet")
            if palFolder then
                for _, p in pairs(palFolder:GetChildren()) do
                    if palActive then
                        if not p:FindFirstChild("BochiP") then
                            local h = Instance.new("Highlight", p)
                            h.Name = "BochiP"; h.FillColor = Color3.fromRGB(255, 255, 0); h.AlwaysOnTop = true
                        end
                    else
                        if p:FindFirstChild("BochiP") then p.BochiP:Destroy() end
                    end
                end
            end
        end
        task.wait(2)
    end
end)

-- --- BUTTONS ---
local Holder = Instance.new("Frame", MainFrame)
Holder.Size = UDim2.new(1, -20, 1, -20); Holder.Position = UDim2.new(0, 10, 0, 10); Holder.BackgroundTransparency = 1
local Layout = Instance.new("UIListLayout", Holder); Layout.Padding = UDim.new(0, 10)

local function CreateBtn(txt, callback)
    local b = Instance.new("TextButton", Holder)
    b.Size = UDim2.new(1, 0, 0, 45); b.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    b.Text = txt..": OFF"; b.TextColor3 = Color3.new(1, 1, 1); b.Font = Enum.Font.SourceSansBold
    Instance.new("UICorner", b)
    local s = false
    b.MouseButton1Click:Connect(function()
        s = not s
        b.BackgroundColor3 = s and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(180, 50, 50)
        b.Text = s and txt..": ON" or txt..": OFF"
        callback(s)
    end)
end

CreateBtn("1. ESP Generator", function(s) genActive = s end)
CreateBtn("2. ESP Pallet", function(s) palActive = s end)

-- EXIT (X)
local Exit = Instance.new("TextButton", MainFrame)
Exit.Size = UDim2.new(0, 25, 0, 25); Exit.Position = UDim2.new(1, -30, 0, 5); Exit.Text = "X"
Exit.BackgroundColor3 = Color3.new(1, 0, 0); Exit.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)