-- [[ BoDcChii Project - v2.7: Integrated Logic 🎸 ]] --

local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")

-- 1. NOTIFIKASI WELCOME (BIAR PASTI MUNCUL)
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "BoDcChii Project",
    Text = "Welcome by @BoDcChii 😈",
    Icon = "rbxassetid://12130312683",
    Duration = 5
})

-- --- UI BASE ---
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "BoDcChii_Final_Logic"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 260, 0, 200)
MainFrame.Position = UDim2.new(0.5, -130, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Visible = false
MainFrame.Active = true
Instance.new("UICorner", MainFrame)
local Stroke = Instance.new("UIStroke", MainFrame)
Stroke.Color = Color3.fromRGB(255, 105, 180)
Stroke.Thickness = 2

local OpenIcon = Instance.new("ImageButton", ScreenGui)
OpenIcon.Size = UDim2.new(0, 50, 0, 50)
OpenIcon.Position = UDim2.new(0, 15, 0, 15) -- Pojok kiri atas biar gak ganggu
OpenIcon.Image = "rbxassetid://12130312683"
OpenIcon.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", OpenIcon).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", OpenIcon).Color = Color3.fromRGB(255, 105, 180)

-- DRAG ICON (MOBILE FRIENDLY)
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

-- --- LAYOUT TOMBOL ---
local ButtonHolder = Instance.new("Frame", MainFrame)
ButtonHolder.Size = UDim2.new(1, -20, 1, -50)
ButtonHolder.Position = UDim2.new(0, 10, 0, 40)
ButtonHolder.BackgroundTransparency = 1
local Layout = Instance.new("UIListLayout", ButtonHolder); Layout.Padding = UDim.new(0, 10)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 30); Title.Text = "BOCHI PLAYER MENU"; Title.TextColor3 = Color3.new(1,1,1)
Title.BackgroundTransparency = 1; Title.Font = Enum.Font.SourceSansBold

-- --- LOGIKA ESP (PANDA HUB STYLE) ---
local genActive, palActive = false, false

local function ApplyESP(obj, name, color)
    if not obj:FindFirstChild(name) then
        local highlight = Instance.new("Highlight", obj)
        highlight.Name = name
        highlight.FillColor = color
        highlight.OutlineColor = Color3.new(1, 1, 1)
        highlight.AlwaysOnTop = true
    end
end

task.spawn(function()
    while true do
        if genActive or palActive then
            -- Mencari objek berdasarkan struktur Violence District
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Model") or v:IsA("BasePart") then
                    local n = v.Name:lower()
                    -- Logic Generator
                    if genActive and (n:find("generator") or n:find("gen") or v:FindFirstChild("Generator")) then
                        ApplyESP(v, "BochiGen", Color3.fromRGB(0, 255, 255))
                    end
                    -- Logic Pallet
                    if palActive and (n:find("pallet") or n:find("board") or n:find("obstacle")) then
                        ApplyESP(v, "BochiPal", Color3.fromRGB(255, 255, 0))
                    end
                end
            end
        else
            for _, v in pairs(workspace:GetDescendants()) do
                if v.Name == "BochiGen" or v.Name == "BochiPal" then v:Destroy() end
            end
        end
        task.wait(2)
    end
end)

-- --- CREATE TOGGLE (RED/GREEN) ---
local function CreateBtn(txt, callback)
    local b = Instance.new("TextButton", ButtonHolder)
    b.Size = UDim2.new(1, 0, 0, 45)
    b.BackgroundColor3 = Color3.fromRGB(180, 50, 50) -- MERAH
    b.Text = txt..": OFF"; b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.SourceSansBold; Instance.new("UICorner", b)
    
    local state = false
    b.MouseButton1Click:Connect(function()
        state = not state
        b.BackgroundColor3 = state and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(180, 50, 50)
        b.Text = state and txt..": ON" or txt..": OFF"
        callback(state)
    end)
end

CreateBtn("1. ESP Generator", function(s) genActive = s end)
CreateBtn("2. ESP Pallet", function(s) palActive = s end)

-- EXIT
local Exit = Instance.new("TextButton", MainFrame)
Exit.Size = UDim2.new(0, 25, 0, 25); Exit.Position = UDim2.new(1, -30, 0, 5); Exit.Text = "X"
Exit.BackgroundColor3 = Color3.new(1, 0, 0); Exit.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)