-- THSCR1PTS HUB Simples - Menu GUI preto, sem bibliotecas externas

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Criar ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "THSCR1PTS_HUB"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

-- Frame principal
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 400)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Title.Text = "THSCR1PTS HUB"
Title.TextColor3 = Color3.fromRGB(230, 230, 230)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

-- Botão fechar
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

-- Botão abrir
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

-- Variáveis do jogador
local plr = LocalPlayer
local normalSpeed = 16
local normalJump = 50

-- Função para mudar velocidade
local speedEnabled = false
local function toggleSpeed()
    speedEnabled = not speedEnabled
    if speedEnabled then
        if plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
            plr.Character.Humanoid.WalkSpeed = 100
        end
        SpeedButton.Text = "Speed: ON"
        SpeedButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    else
        if plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
            plr.Character.Humanoid.WalkSpeed = normalSpeed
        end
        SpeedButton.Text = "Speed: OFF"
        SpeedButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end
end

-- Botão Speed
local SpeedButton = Instance.new("TextButton")
SpeedButton.Size = UDim2.new(0, 150, 0, 40)
SpeedButton.Position = UDim2.new(0, 100, 0, 60)
SpeedButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SpeedButton.TextColor3 = Color3.fromRGB(200, 200, 200)
SpeedButton.Text = "Speed: OFF"
SpeedButton.Font = Enum.Font.Gotham
SpeedButton.TextScaled = true
SpeedButton.Parent = MainFrame

SpeedButton.MouseButton1Click:Connect(toggleSpeed)

-- Função para mudar pulo
local jumpEnabled = false
local function toggleJump()
    jumpEnabled = not jumpEnabled
    if jumpEnabled then
        if plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
            plr.Character.Humanoid.JumpPower = 150
        end
        JumpButton.Text = "Jump: ON"
        JumpButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    else
        if plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
            plr.Character.Humanoid.JumpPower = normalJump
        end
        JumpButton.Text = "Jump: OFF"
        JumpButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end
end

-- Botão Jump
local JumpButton = Instance.new("TextButton")
JumpButton.Size = UDim2.new(0, 150, 0, 40)
JumpButton.Position = UDim2.new(0, 100, 0, 110)
JumpButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
JumpButton.TextColor3 = Color3.fromRGB(200, 200, 200)
JumpButton.Text = "Jump: OFF"
JumpButton.Font = Enum.Font.Gotham
JumpButton.TextScaled = true
JumpButton.Parent = MainFrame

JumpButton.MouseButton1Click:Connect(toggleJump)

-- Noclip
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

-- Botão Noclip
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
