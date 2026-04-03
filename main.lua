-- [[ Update Tombol Icon Bocchi ]] --

local OpenIcon = Instance.new("ImageButton")
OpenIcon.Parent = ScreenGui
OpenIcon.BackgroundColor3 = Color3.fromRGB(255, 192, 203) -- Warna Pink Khas Bocchi
OpenIcon.Position = UDim2.new(0, 15, 0.4, 0)
OpenIcon.Size = UDim2.new(0, 60, 0, 60) -- Sedikit lebih besar biar Bocchi kelihatan

-- PAKAI ID BOCCHI DISINI
OpenIcon.Image = "rbxassetid://12130312683" 

OpenIcon.Draggable = true
local IconCorner = Instance.new("UICorner")
IconCorner.CornerRadius = UDim.new(1, 0) -- Bulat sempurna
IconCorner.Parent = OpenIcon

-- Tambahkan Garis Pinggir Pink Menyala
local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(255, 105, 180)
UIStroke.Thickness = 3
UIStroke.Parent = OpenIcon