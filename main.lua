-- [[ BoDcChii Project v0.1 - Welcome & Toggle Edition 🎸 ]] --

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BoDcChii_Final_Project"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- --- 1. WELCOME SCREEN (TAMPILAN AWAL) ---
local WelcomeLabel = Instance.new("TextLabel")
WelcomeLabel.Parent = ScreenGui
WelcomeLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
WelcomeLabel.BackgroundTransparency = 1
WelcomeLabel.Position = UDim2.new(0, 0, 0, 0)
WelcomeLabel.Size = UDim2.new(1, 0, 1, 0)
WelcomeLabel.Text = "Welcome by @BoDcChii 😈"
WelcomeLabel.TextColor3 = Color3.fromRGB(255, 105, 180) -- Pink Bocchi
WelcomeLabel.Font = Enum.Font.SpecialElite
WelcomeLabel.TextSize = 40
WelcomeLabel.ZIndex = 100
WelcomeLabel.Visible = true

-- Fungsi Animasi Welcome
task.spawn(function()
    -- Muncul 1.5 detik
    task.wait(1.5)
    -- Animasi Menghilang (Fade Out)
    for i = 0, 1, 0.1 do
        WelcomeLabel.TextTransparency = i
        task.wait(0.05)
    end
    WelcomeLabel.Visible = false
    WelcomeLabel:Destroy()
end)

-- --- 2. FLOATING ICON (BOCCHI ICON) ---
local OpenIcon = Instance.new("ImageButton")
OpenIcon.Parent = ScreenGui
OpenIcon.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
OpenIcon.Position = UDim2.new(0, 15, 0.4, 0)
OpenIcon.Size = UDim2.new(0, 55, 0, 55)
OpenIcon.Image = "rbxassetid://12130312683" -- Bocchi Glitch
OpenIcon.Visible = false -- Sembunyi dulu sampai Welcome selesai
OpenIcon.ZIndex = 50

-- Tunggu Welcome selesai baru munculkan Icon
task.delay(1.7, function()
    OpenIcon.Visible = true
end)

local IconCorner = Instance.new("UICorner")
IconCorner.CornerRadius = UDim.new(1, 0)
IconCorner.Parent = OpenIcon

local IconStroke = Instance.new("UIStroke")
IconStroke.Color = Color3.fromRGB(255, 105, 180)
IconStroke.Thickness = 3
IconStroke.Parent = OpenIcon

-- --- 3. MAIN FRAME (DILEBARKAN & NOMOR) ---
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Position = UDim2.new(0.5, -140, 0.3, 0)
MainFrame.Size = UDim2.new(0, 280, 0, 300) -- Wide Layout
MainFrame.Visible = false -- Mulai dari tertutup
MainFrame.ZIndex = 5

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

-- --- FUNGSI TOGGLE (KLIK ICON BUKA/TUTUP) ---
OpenIcon.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- --- 4. TOMBOL SILANG (X) UNTUK HAPUS SCRIPT ---
local ExitBtn = Instance.new("TextButton")
ExitBtn.Parent = MainFrame
ExitBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
ExitBtn.Position = UDim2.new(1, -30, 0, 5)
ExitBtn.Size = UDim2.new(0, 25, 0, 25)
ExitBtn.Text = "X"
ExitBtn.TextColor3 = Color3.new(1, 1, 1)
ExitBtn.Font = Enum.Font.SourceSansBold
ExitBtn.ZIndex = 10
local ExitCorner = Instance.new("UICorner")
ExitCorner.CornerRadius = UDim.new(1, 0)
ExitCorner.Parent = ExitBtn

ExitBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- --- 5. WATERMARK @BoDcChii ---
local Footer = Instance.new("TextLabel")
Footer.Parent = MainFrame
Footer.Position = UDim2.new(0, 0, 1, -25)
Footer.Size = UDim2.new(1, 0, 0, 20)
Footer.BackgroundTransparency = 1
Footer.Text = "@BoDcChii Edition | v0.1"
Footer.TextColor3 = Color3.fromRGB(255, 105, 180)
Footer.Font = Enum.Font.SourceSansBold
Footer.TextSize = 13
Footer.ZIndex = 10

-- (Tempat Sidebar dan Tab akan kita isi di Langkah 3)