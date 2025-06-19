-- THSCR1PTS HUB para Xeno executor - GUI preta estilo Rael Hub

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "THSCR1PTS_HUB"
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 400)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Title.Text = "THSCR1PTS HUB - By THSCR1PTS"
Title.TextColor3 = Color3.fromRGB(230, 230, 230)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -45, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.new(1,1,1)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextScaled = true
CloseButton.Parent = MainFrame

CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

local OpenButton = Instance.new("TextButton")
OpenButton.Size = UDim2.new(0, 120, 0, 40)
OpenButton.Position = UDim2.new(0, 10, 0, 10)
OpenButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
OpenButton.TextColor3 = Color3.fromRGB(230, 230, 230)
OpenButton.Text = "Abrir HUB"
OpenButton.Font = Enum.Font.GothamBold
OpenButton.TextScaled = true
OpenButton.Parent = ScreenGui

OpenButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
end)

-- Funções do Hub

local plr = LocalPlayer

-- Speed Hack toggle
local speedEnabled = false
local normalSpeed = 16

local SpeedButton = Instance.new("TextButton")
SpeedButton.Size = UDim2.new(0, 150, 0, 40)
SpeedButton.Position = UDim2.new(0, 100, 0, 60)
SpeedButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SpeedButton.TextColor3 = Color3.fromRGB(200, 200, 200)
SpeedButton.Text = "Speed Hack: OFF"
SpeedButton.Font = Enum.Font.Gotham
SpeedButton.TextScaled = true
SpeedButton.Parent = MainFrame

SpeedButton.MouseButton1Click:Connect(function()
    speedEnabled = not speedEnabled
    if speedEnabled then
        if plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
            plr.Character.Humanoid.WalkSpeed = 100
        end
        SpeedButton.Text = "Speed Hack: ON"
        SpeedButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    else
        if plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
            plr.Character.Humanoid.WalkSpeed = normalSpeed
        end
        SpeedButton.Text = "Speed Hack: OFF"
        SpeedButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end
end)

-- Jump Boost toggle
local jumpEnabled = false
local normalJump = 50

local JumpButton = Instance.new("TextButton")
JumpButton.Size = UDim2.new(0, 150, 0, 40)
JumpButton.Position = UDim2.new(0, 100, 0, 110)
JumpButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
JumpButton.TextColor3 = Color3.fromRGB(200, 200, 200)
JumpButton.Text = "Jump Boost: OFF"
JumpButton.Font = Enum.Font.Gotham
JumpButton.TextScaled = true
JumpButton.Parent = MainFrame

JumpButton.MouseButton1Click:Connect(function()
    jumpEnabled = not jumpEnabled
    if jumpEnabled then
        if plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
            plr.Character.Humanoid.JumpPower = 150
        end
        JumpButton.Text = "Jump Boost: ON"
        JumpButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    else
        if plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
            plr.Character.Humanoid.JumpPower = normalJump
        end
        JumpButton.Text = "Jump Boost: OFF"
        JumpButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end
end)

-- Noclip toggle
local noclipEnabled = false
local noclipConn

local function setNoclip(state)
    noclipEnabled = state
    if noclipEnabled then
        noclipConn = RunService.Stepped:Connect(function()
            if plr.Character then
                for _, part in pairs(plr.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if noclipConn then
            noclipConn:Disconnect()
            noclipConn = nil
        end
    end
end

local NoclipButton = Instance.new("TextButton")
NoclipButton.Size = UDim2.new(0, 150, 0, 40)
NoclipButton.Position = UDim2.new(0, 100, 0, 160)
NoclipButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
NoclipButton.TextColor3 = Color3.fromRGB(200, 200, 200)
NoclipButton.Text = "Noclip: OFF"
NoclipButton.Font = Enum.Font.Gotham
NoclipButton.TextScaled = true
NoclipButton.Parent = MainFrame

NoclipButton.MouseButton1Click:Connect(function()
    setNoclip(not noclipEnabled)
    if noclipEnabled then
        NoclipButton.Text = "Noclip: ON"
        NoclipButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    else
        NoclipButton.Text = "Noclip: OFF"
        NoclipButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end
end)

-- Fechar botão para limpar tudo
local CloseAllButton = Instance.new("TextButton")
CloseAllButton.Size = UDim2.new(0, 150, 0, 40)
CloseAllButton.Position = UDim2.new(0, 100, 0, 210)
CloseAllButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseAllButton.TextColor3 = Color3.new(1, 1, 1)
CloseAllButton.Text = "Fechar HUB"
CloseAllButton.Font = Enum.Font.GothamBold
CloseAllButton.TextScaled = true
CloseAllButton.Parent = MainFrame

CloseAllButton.MouseButton1Click:Connect(function()
    -- Reset velocidade e pulo
    if plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
        plr.Character.Humanoid.WalkSpeed = normalSpeed
        plr.Character.Humanoid.JumpPower = normalJump
    end
    -- Desliga noclip
    setNoclip(false)
    MainFrame.Visible = false
end)

