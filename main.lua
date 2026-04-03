-- [[ BoDcChii Project - v2.8: Final Strike Edition 🎸 ]] --

local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")

-- 1. WELCOME NOTIFICATION
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "BoDcChii System",
    Text = "Version 2.8 Loaded! 😈",
    Duration = 5
})

-- --- UI BASE ---
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "BoDcChii_Final"

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

-- DRAG SYSTEM (MOBILE)
OpenIcon.TouchMoved:Connect(function(touch)
    OpenIcon.Position = UDim2.new(0, touch.Position.X - 25, 0, touch.Position.Y - 25)
end)
OpenIcon.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- --- LOGIKA ESP BERDASARKAN PROXIMITY (E) ---
local genActive, palActive = false, false

local function CreateHighlight(obj, color, name)
    if not obj:FindFirstChild(name) then
        local h = Instance.new("Highlight", obj)
        h.Name = name
        h.FillColor = color
        h.OutlineColor = Color3.new(1, 1, 1)
        h.AlwaysOnTop = true
    end
end

task.spawn(function()
    while true do
        if genActive or palActive then
            -- Scan semua ProximityPrompt (Tombol E)
            for _, prompt in pairs(game:GetDescendants()) do
                if prompt:IsA("ProximityPrompt") then
                    local parent = prompt.Parent
                    if parent and (parent:IsA("Model") or parent:IsA("BasePart")) then
                        local pName = parent.Name:lower()
                        local promptText = prompt.ObjectText:lower()
                        
                        -- DETEKSI GENERATOR (Berdasarkan Nama atau Teks di Tombol E)
                        if genActive and (pName:find("gen") or promptText:find("gen") or promptText:find("repair")) then
                            CreateHighlight(parent, Color3.fromRGB(0, 255, 255), "BochiGen")
                        end
                        
                        -- DETEKSI PALLET (Berdasarkan Nama atau Teks di Tombol E)
                        if palActive and (pName:find("pallet") or pName:find("obstacle") or promptText:find("pallet")) then
                            CreateHighlight(parent, Color3.fromRGB(255, 255, 0), "BochiPal")
                        end
                    end
                end
            end
        else
            -- Cleanup
            for _, v in pairs(game:GetDescendants()) do
                if v.Name == "BochiGen" or v.Name == "BochiPal" then v:Destroy() end
            end
        end
        task.wait(3)
    end
end)

-- --- BUTTON HOLDER ---
local Holder = Instance.new("Frame", MainFrame)
Holder.Size = UDim2.new(1, -20, 1, -20); Holder.Position = UDim2.new(0, 10, 0, 10); Holder.BackgroundTransparency = 1
local Layout = Instance.new("UIListLayout", Holder); Layout.Padding = UDim.new(0, 10)

local function CreateToggle(text, callback)
    local b = Instance.new("TextButton", Holder)
    b.Size = UDim2.new(1, 0, 0, 45); b.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    b.Text = text..": OFF"; b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.SourceSansBold; Instance.new("UICorner", b)
    
    local state = false
    b.MouseButton1Click:Connect(function()
        state = not state
        b.BackgroundColor3 = state and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(180, 50, 50)
        b.Text = state and text..": ON" or text..": OFF"
        callback(state)
    end)
end

CreateToggle("1. ESP Generator", function(s) genActive = s end)
CreateToggle("2. ESP Pallet", function(s) palActive = s end)

-- EXIT (X)
local Exit = Instance.new("TextButton", MainFrame)
Exit.Size = UDim2.new(0, 25, 0, 25); Exit.Position = UDim2.new(1, -30, 0, 5); Exit.Text = "X"
Exit.BackgroundColor3 = Color3.new(1, 0, 0); Exit.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)