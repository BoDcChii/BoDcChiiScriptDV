-- [[ BoDcChii Project - v2.6: Ghost Edition 🎸 ]] --

local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")

-- 1. WELCOME NOTIFICATION (PENGGANTI LABEL YANG HILANG)
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "BoDcChii Script",
    Text = "Welcome by @BoDcChii 😈",
    Duration = 5
})
print("BoDcChii Script v2.6 Loaded!")

-- --- UI BASE ---
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "BoDcChii_Ghost"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 280, 0, 200)
MainFrame.Position = UDim2.new(0.5, -140, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.Visible = false
MainFrame.Active = true
Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(255, 105, 180)

local OpenIcon = Instance.new("ImageButton", ScreenGui)
OpenIcon.Size = UDim2.new(0, 45, 0, 45)
OpenIcon.Position = UDim2.new(0, 10, 0.5, 0)
OpenIcon.Image = "rbxassetid://12130312683"
OpenIcon.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
Instance.new("UICorner", OpenIcon).CornerRadius = UDim.new(1, 0)

-- FUNGSI DRAG (SEDERHANA)
OpenIcon.TouchMoved:Connect(function(touch)
    OpenIcon.Position = UDim2.new(0, touch.Position.X - 22, 0, touch.Position.Y - 22)
end)
OpenIcon.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- --- BUTTONS ---
local ButtonHolder = Instance.new("Frame", MainFrame)
ButtonHolder.Size = UDim2.new(1, -20, 1, -20)
ButtonHolder.Position = UDim2.new(0, 10, 0, 10)
ButtonHolder.BackgroundTransparency = 1
local Layout = Instance.new("UIListLayout", ButtonHolder); Layout.Padding = UDim.new(0, 10)

-- --- LOGIKA ESP SAKTI ---
local genActive, palActive = false, false

local function CreateGhostESP(obj, color, name)
    if not obj:FindFirstChild(name) then
        local box = Instance.new("SelectionBox", obj)
        box.Name = name
        box.Adornee = obj
        box.Color3 = color
        box.LineThickness = 0.05
        box.AlwaysOnTop = true
        box.SurfaceTransparency = 0.8
    end
end

task.spawn(function()
    while true do
        if genActive or palActive then
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Model") or v:IsA("BasePart") then
                    local n = v.Name:lower()
                    -- Generator
                    if genActive and (n:find("gen") or n:find("motor") or n:find("machine")) then
                        CreateGhostESP(v, Color3.fromRGB(0, 255, 255), "GhostGen")
                    end
                    -- Pallet
                    if palActive and (n:find("pallet") or n:find("board") or n:find("wood")) then
                        CreateGhostESP(v, Color3.fromRGB(255, 255, 0), "GhostPal")
                    end
                end
            end
        else
            for _, v in pairs(workspace:GetDescendants()) do
                if v.Name == "GhostGen" or v.Name == "GhostPal" then v:Destroy() end
            end
        end
        task.wait(2)
    end
end)

-- --- CREATE TOGGLE ---
local function Toggle(txt, callback)
    local b = Instance.new("TextButton", ButtonHolder)
    b.Size = UDim2.new(1, 0, 0, 45)
    b.BackgroundColor3 = Color3.fromRGB(180, 50, 50) -- MERAH
    b.Text = txt..": OFF"
    b.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", b)
    
    local s = false
    b.MouseButton1Click:Connect(function()
        s = not s
        b.BackgroundColor3 = s and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(180, 50, 50)
        b.Text = s and txt..": ON" or txt..": OFF"
        callback(s)
    end)
end

Toggle("1. ESP Generator", function(s) genActive = s end)
Toggle("2. ESP Pallet", function(s) palActive = s end)

-- EXIT (X)
local Exit = Instance.new("TextButton", MainFrame)
Exit.Size = UDim2.new(0, 25, 0, 25); Exit.Position = UDim2.new(1, -30, 0, 5); Exit.Text = "X"
Exit.BackgroundColor3 = Color3.new(1, 0, 0); Exit.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)