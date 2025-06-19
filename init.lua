local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function setSpeed(speed)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = speed
    end
end

setSpeed(100) -- Aumenta a velocidade do personagem para 100
print("THSCR1PTS HUB funcionando! Velocidade aumentada.")
