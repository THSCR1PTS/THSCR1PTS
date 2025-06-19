-- THSCR1PTS HUB - super completo estilo Rael Hub (preto)
-- Criado por THSCR1PTS

local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Window = Rayfield:CreateWindow({
    Name = "THSCR1PTS HUB",
    LoadingTitle = "Carregando THSCR1PTS HUB...",
    LoadingSubtitle = "Brookhaven Hub com funções reais",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "THSCR1PTS",
        FileName = "Config"
    },
    Discord = { Enabled = false },
    KeySystem = false
})

-- Função Teleporte
local function teleportTo(pos)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
    end
end

-- Noclip toggle
local noclip = false
local noclipConn
local function setNoclip(state)
    noclip = state
    if noclip then
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

-- ESP tables
local espBoxes = {}
local espNames = {}
local espLines = {}

local function clearESP()
    for _, box in pairs(espBoxes) do
        box:Destroy()
    end
    for _, nameTag in pairs(espNames) do
        nameTag:Destroy()
    end
    for _, line in pairs(espLines) do
        line:Destroy()
    end
    espBoxes = {}
    espNames = {}
    espLines = {}
end

local function createESP()
    clearESP()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild("Head") then
            -- Box ESP
            local box = Instance.new("BillboardGui", plr.Character.HumanoidRootPart)
            box.Name = "THSCR1PTS_ESP_BOX"
            box.Size = UDim2.new(4, 0, 6, 0)
            box.AlwaysOnTop = true
            local frame = Instance.new("Frame", box)
            frame.BackgroundColor3 = Color3.new(1, 0, 0)
            frame.BackgroundTransparency = 0.6
            frame.Size = UDim2.new(1, 0, 1, 0)
            frame.BorderSizePixel = 0
            espBoxes[plr] = box

            -- Name ESP
            local nameGui = Instance.new("BillboardGui", plr.Character.Head)
            nameGui.Name = "THSCR1PTS_ESP_NAME"
            nameGui.Size = UDim2.new(4, 0, 2, 0)
            nameGui.AlwaysOnTop = true
            local txt = Instance.new("TextLabel", nameGui)
            txt.Text = plr.Name
            txt.TextColor3 = Color3.new(1, 0, 0)
            txt.BackgroundTransparency = 1
            txt.Size = UDim2.new(1, 0, 1, 0)
            txt.TextScaled = true
            espNames[plr] = nameGui

            -- Line ESP
            local line = Drawing.new("Line")
            line.Color = Color3.new(1, 0, 0)
            line.Thickness = 1
            line.Transparency = 1
            espLines[plr] = line
        end
    end
end

local espEnabled = false
local espUpdateConnection

local function updateESP()
    if not espEnabled then return end
    local camera = workspace.CurrentCamera
    for plr, line in pairs(espLines) do
        if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local hrpPos, onScreen = camera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)
            local lpHead = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")
            if lpHead then
                local lpPos, lpOnScreen = camera:WorldToViewportPoint(lpHead.Position)
                if onScreen and lpOnScreen then
                    line.From = Vector2.new(lpPos.X, lpPos.Y)
                    line.To = Vector2.new(hrpPos.X, hrpPos.Y)
                    line.Visible = true
                else
                    line.Visible = false
                end
            end
        else
            line.Visible = false
        end
    end
end

-- Aba Geral
local TabGeral = Window:CreateTab("⚙️ Geral")

TabGeral:CreateToggle({
    Name = "Speed Hack",
    CurrentValue = false,
    Callback = function(v)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = v and 100 or 16
        end
    end
})

TabGeral:CreateToggle({
    Name = "Jump Boost",
    CurrentValue = false,
    Callback = function(v)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = v and 150 or 50
        end
    end
})

TabGeral:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Callback = function(v)
        setNoclip(v)
    end
})

TabGeral:CreateToggle({
    Name = "Invisível",
    CurrentValue = false,
    Callback = function(v)
        if LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = v and 1 or 0
                end
            end
        end
    end
})

-- Aba Visual
local TabVisual = Window:CreateTab("👁️ Visual")

TabVisual:CreateToggle({
    Name = "ESP (Caixas e Nomes)",
    CurrentValue = false,
    Callback = function(v)
        espEnabled = v
        if v then
            createESP()
            espUpdateConnection = RunService.RenderStepped:Connect(updateESP)
        else
            clearESP()
            if espUpdateConnection then
                espUpdateConnection:Disconnect()
                espUpdateConnection = nil
            end
        end
    end
})

-- Aba Teleporte
local TabTP = Window:CreateTab("🧭 Teleportes")

TabTP:CreateDropdown({
    Name = "Ir para:",
    Options = {"Spawn", "Hospital", "School", "Bank", "Car Shop"},
    CurrentOption = "Spawn",
    Callback = function(op)
        local locs = {
            Spawn = Vector3.new(-33, 8, 120),
            Hospital = Vector3.new(-250, 8, 158),
            School = Vector3.new(170, 8, -50),
            Bank = Vector3.new(-100, 8, 100),
            ["Car Shop"] = Vector3.new(240, 8, 230)
        }
        teleportTo(locs[op])
    end
})

-- Aba Troll
local TabTroll = Window:CreateTab("😈 Troll")

TabTroll:CreateButton({
    Name = "Fling All",
    Callback = function()
        for _,plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local bv = Instance.new("BodyVelocity")
                bv.MaxForce = Vector3.new(1e5,1e5,1e5)
                bv.Velocity = Vector3.new(9999,9999,9999)
                bv.Parent = plr.Character.HumanoidRootPart
                game.Debris:AddItem(bv, 0.3)
            end
        end
    end
})

TabTroll:CreateButton({
    Name = "Crash Server",
    Callback = function()
        for _,plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                for i=1,5 do
                    local bv = Instance.new("BodyVelocity")
                    bv.MaxForce = Vector3.new(1e6,1e6,1e6)
                    bv.Velocity = Vector3.new(math.random(-1000,1000),math.random(-1000,1000),math.random(-1000,1000))
                    bv.Parent = plr.Character.HumanoidRootPart
                    game.Debris:AddItem(bv, 0.1)
                end
            end
        end
    end
})

TabTroll:CreateToggle({
    Name = "Loop Dance",
    CurrentValue = false,
    Callback = function(v)
        local char = LocalPlayer.Character
        if not char then return end
        local anim
        if v then
            anim = Instance.new("Animation")
            anim.AnimationId = "rbxassetid://3189773368"
            local track = char.Humanoid:LoadAnimation(anim)
            track:Play()
            track.Looped = true
            TabTroll._loopDanceTrack = track
        else
            if TabTroll._loopDanceTrack then
                TabTroll._loopDanceTrack:Stop()
                TabTroll._loopDanceTrack = nil
            end
        end
    end
})

-- Aba Configurações
local TabConfig = Window:CreateTab("⚙️ Configurações")

TabConfig:CreateButton({
    Name = "Fechar HUB",
    Callback = function()
        if noclipConn then noclipConn:Disconnect() end
        if espUpdateConnection then espUpdateConnection:Disconnect() end
        clearESP()
        Window:Destroy()
    end
})

-- Tema toggle
local isBlackTheme = true
local function toggleTheme()
    isBlackTheme = not isBlackTheme
    if isBlackTheme then
        Window:SetTheme({
            MainBackground = Color3.fromRGB(20,20,20),
            Accent = Color3.fromRGB(30,30,30),
            Outline = Color3.fromRGB(40,40,40),
            FontColor = Color3.fromRGB(230,230,230),
        })
    else
        Window:SetTheme({
            MainBackground = Color3.fromRGB(240,240,240),
            Accent = Color3.fromRGB(255,255,255),
            Outline = Color3.fromRGB(200,200,200),
            FontColor = Color3.fromRGB(20,20,20),
        })
    end
end

TabConfig:CreateButton({
    Name = "Alternar Tema Preto/Branco",
    Callback = toggleTheme
})

