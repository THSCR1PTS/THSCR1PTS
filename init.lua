-- THSCR1PTS HUB estilo Rael Hub (preto)

local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Window = Rayfield:CreateWindow({
    Name = "THSCR1PTS HUB",
    LoadingTitle = "Carregando THSCR1PTS HUB...",
    LoadingSubtitle = "By THSCR1PTS",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "THSCR1PTS",
        FileName = "Config"
    }
})

-- Speed Hack
local speedEnabled = false
local normalSpeed = 16

-- Jump Boost
local jumpEnabled = false
local normalJump = 50

-- Noclip
local noclipEnabled = false
local noclipConn

local function setNoclip(state)
    noclipEnabled = state
    if noclipEnabled then
        noclipConn = RunService.Stepped:Connect(function()
            if LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
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

local Tab = Window:CreateTab("Principal")

Tab:CreateToggle({
    Name = "Speed Hack",
    CurrentValue = false,
    Flag = "SpeedToggle",
    Callback = function(value)
        speedEnabled = value
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = speedEnabled and 100 or normalSpeed
        end
    end
})

Tab:CreateToggle({
    Name = "Jump Boost",
    CurrentValue = false,
    Flag = "JumpToggle",
    Callback = function(value)
        jumpEnabled = value
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = jumpEnabled and 150 or normalJump
        end
    end
})

Tab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Flag = "NoclipToggle",
    Callback = function(value)
        setNoclip(value)
    end
})

Tab:CreateButton({
    Name = "Resetar Velocidade e Pulo",
    Callback = function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = normalSpeed
            LocalPlayer.Character.Humanoid.JumpPower = normalJump
        end
        setNoclip(false)
    end
})

Tab:CreateButton({
    Name = "Fechar HUB",
    Callback = function()
        if noclipConn then noclipConn:Disconnect() end
        Window:Destroy()
    end
})

