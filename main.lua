local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BoDcChiiGui"
ScreenGui.Parent = game.CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Warna abu gelap
MainFrame.Position = UDim2.new(0.5, -100, 0.4, -50)
MainFrame.Size = UDim2.new(0, 200, 0, 150)
MainFrame.Active = true
MainFrame.Draggable = true -- Biar bisa digeser

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Title.Text = " BoDcChii Menu"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.SourceSansBold

local TestButton = Instance.new("TextButton")
TestButton.Parent = MainFrame
TestButton.Position = UDim2.new(0.1, 0, 0.4, 0)
TestButton.Size = UDim2.new(0.8, 0, 0.3, 0)
TestButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
TestButton.Text = "Klik Saya!"
TestButton.TextColor3 = Color3.new(1, 1, 1)

TestButton.MouseButton1Click:Connect(function()
    print("Tombol berhasil ditekan!")
    TestButton.Text = "BERHASIL!"
end)