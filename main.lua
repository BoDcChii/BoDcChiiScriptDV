-- [[ BoDcChii Project - v3.2: Violence District Mpan Logic 🎸 ]] --

local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")

-- --- UI BASE ---
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "BoDcChii_MpanEdition"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 260, 0, 180)
MainFrame.Position = UDim2.new(0.5, -130, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Visible = false; MainFrame.Active = true
Instance.new("UICorner", MainFrame)
Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(255, 105, 180)

local OpenIcon = Instance.new("ImageButton", ScreenGui)
OpenIcon.Size = UDim2.new(0, 50, 0, 50); OpenIcon.Position = UDim2.new(0, 20, 0.5, -25)
OpenIcon.Image = "rbxassetid://12130312683"; OpenIcon.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", OpenIcon).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", OpenIcon).Color = Color3.fromRGB(255, 105, 180)

-- DRAG
OpenIcon.TouchMoved:Connect(function(touch)
    OpenIcon.Position = UDim2.new(0, touch.Position.X - 25, 0, touch.Position.Y - 25)
end)
OpenIcon.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- --- LOGIKA ESP VIOLENCE DISTRICT ---
local genActive, palActive = false, false

local function ApplyESP(obj, color, name)
    if not obj:FindFirstChild(name) then
        local h = Instance.new("Highlight", obj)
        h.Name = name; h.FillColor = color; h.OutlineColor = Color3.new(1, 1, 1); h.AlwaysOnTop = true
    end
end

task.spawn(function()
    while true do
        -- PATH KHUSUS VIOLENCE DISTRICT (DARI MPANHUB)
        local mapFolder = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Map")
        
        if mapFolder then
            -- SCAN GENERATOR
            if genActive then
                local genFolder = mapFolder:FindFirstChild("Generator")
                if genFolder then
                    for _, g in pairs(genFolder:GetChildren()) do
                        ApplyESP(g, Color3.fromRGB(0, 255, 255), "BochiG")
                    end
                end
            end
            
            -- SCAN PALLET
            if palActive then
                local palFolder = mapFolder:FindFirstChild("Pallet")
                if palFolder then
                    for _, p in pairs(palFolder:GetChildren()) do
                        ApplyESP(p, Color3.fromRGB(255, 255, 0), "BochiP")
                    end
                end
            end
        end
        
        -- CLEANUP JIKA OFF
        if not genActive or not palActive then
            for _, v in pairs(workspace:GetDescendants()) do
                if (not genActive and v.Name == "BochiG") or (not palActive and v.Name == "BochiP") then
                    v:Destroy()
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

-- EXIT
local Exit = Instance.new("TextButton", MainFrame)
Exit.Size = UDim2.new(0, 25, 0, 25); Exit.Position = UDim2.new(1, -30, 0, 5); Exit.Text = "X"
Exit.BackgroundColor3 = Color3.new(1, 0, 0); Exit.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)