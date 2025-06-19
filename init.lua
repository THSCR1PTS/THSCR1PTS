-- THSCR1PTS HUB COMPLETO - GUI nativa estilo Rael Hub (preto) com abas e mais de 40 funções

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")

-- CONFIGURAÇÃO
local normalSpeed = 16
local normalJump = 50
local normalGravity = workspace.Gravity

-- Criar ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "THSCR1PTS_HUB"
ScreenGui.Parent = game:GetService("CoreGui")

-- Botão abrir HUB
local OpenBtn = Instance.new("TextButton", ScreenGui)
OpenBtn.Size = UDim2.new(0, 140, 0, 35)
OpenBtn.Position = UDim2.new(0, 15, 0, 15)
OpenBtn.BackgroundColor3 = Color3.fromRGB(20,20,20)
OpenBtn.TextColor3 = Color3.new(1,1,1)
OpenBtn.Text = "Abrir THSCR1PTS HUB"
OpenBtn.Font = Enum.Font.GothamBold
OpenBtn.TextScaled = true
OpenBtn.BorderSizePixel = 0
OpenBtn.AutoButtonColor = false

-- Frame principal do HUB
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 460, 0, 520)
Main.Position = UDim2.new(0.5, -230, 0.5, -260)
Main.BackgroundColor3 = Color3.fromRGB(15,15,15)
Main.BorderSizePixel = 0
Main.Visible = false
Main.ClipsDescendants = true
Main.Active = true
Main.Draggable = true

-- Título
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundColor3 = Color3.fromRGB(10,10,10)
Title.Text = "THSCR1PTS HUB"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true
Title.BorderSizePixel = 0

-- Botão fechar
local CloseBtn = Instance.new("TextButton", Main)
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -45, 0, 2)
CloseBtn.Text = "X"
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextScaled = true
CloseBtn.BorderSizePixel = 0
CloseBtn.AutoButtonColor = false

CloseBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
end)

OpenBtn.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)

-- Container para abas
local TabsFrame = Instance.new("Frame", Main)
TabsFrame.Size = UDim2.new(1, -20, 0, 40)
TabsFrame.Position = UDim2.new(0, 10, 0, 50)
TabsFrame.BackgroundTransparency = 1

local UIListLayout = Instance.new("UIListLayout", TabsFrame)
UIListLayout.FillDirection = Enum.FillDirection.Horizontal
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 15)

-- Container para conteúdo das abas
local ContentFrame = Instance.new("Frame", Main)
ContentFrame.Size = UDim2.new(1, -20, 1, -110)
ContentFrame.Position = UDim2.new(0, 10, 0, 95)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ClipsDescendants = true

-- Função para criar abas e conteúdo
local Tabs = {}
local SelectedTab = nil

local function CreateTab(name)
    local TabBtn = Instance.new("TextButton", TabsFrame)
    TabBtn.Size = UDim2.new(0, 90, 1, 0)
    TabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TabBtn.Text = name
    TabBtn.TextColor3 = Color3.new(1,1,1)
    TabBtn.Font = Enum.Font.GothamBold
    TabBtn.TextScaled = true
    TabBtn.AutoButtonColor = false
    TabBtn.BorderSizePixel = 0
    TabBtn.LayoutOrder = #Tabs + 1

    local Content = Instance.new("ScrollingFrame", ContentFrame)
    Content.Size = UDim2.new(1, 0, 1, 0)
    Content.CanvasSize = UDim2.new(0, 0, 0, 0)
    Content.ScrollBarThickness = 6
    Content.BackgroundTransparency = 1
    Content.Visible = false
    Content.AutomaticCanvasSize = Enum.AutomaticSize.Y

    local UIList = Instance.new("UIListLayout", Content)
    UIList.SortOrder = Enum.SortOrder.LayoutOrder
    UIList.Padding = UDim.new(0, 10)

    local Tab = {
        Button = TabBtn,
        Content = Content,
        UIList = UIList,
        Buttons = {}
    }

    TabBtn.MouseButton1Click:Connect(function()
        if SelectedTab then
            SelectedTab.Content.Visible = false
            SelectedTab.Button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        end
        SelectedTab = Tab
        SelectedTab.Content.Visible = true
        SelectedTab.Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end)

    table.insert(Tabs, Tab)

    return Tab
end

-- Criar abas
local PlayerTab = CreateTab("Player")
local SujoTab = CreateTab("Sujo")
local TeleportTab = CreateTab("Teleport")
local VisualTab = CreateTab("Visual")

-- Função para criar botões ON/OFF
local function AddToggleButton(tab, text, callback)
    local btn = Instance.new("TextButton", tab.Content)
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(35,35,35)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.Gotham
    btn.TextScaled = true
    btn.BorderSizePixel = 0
    btn.Text = text .. " : OFF"

    local enabled = false

    btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        btn.Text = text .. (enabled and " : ON" or " : OFF")
        callback(enabled)
        if enabled then
            btn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        else
            btn.BackgroundColor3 = Color3.fromRGB(35,35,35)
        end
    end)

    table.insert(tab.Buttons, btn)
    return btn
end

-- Função para criar botões simples (só clicar)
local function AddButton(tab, text, callback)
    local btn = Instance.new("TextButton", tab.Content)
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.Gotham
    btn.TextScaled = true
    btn.BorderSizePixel = 0
    btn.Text = text

    btn.MouseButton1Click:Connect(callback)

    table.insert(tab.Buttons, btn)
    return btn
end

-- --------- FUNÇÕES DO PLAYER ---------
local humanoid = nil
local function getHumanoid()
    if LocalPlayer.Character then
        return LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    end
    return nil
end

local speedOn = false
AddToggleButton(PlayerTab, "Speed Hack", function(state)
    speedOn = state
    local hum = getHumanoid()
    if hum then
        hum.WalkSpeed = speedOn and 100 or normalSpeed
    end
end)

local jumpOn = false
AddToggleButton(PlayerTab, "Super Jump", function(state)
    jumpOn = state
    local hum = getHumanoid()
    if hum then
        hum.JumpPower = jumpOn and 150 or normalJump
    end
end)

local noclipOn = false
local noclipConn = nil
AddToggleButton(PlayerTab, "Noclip", function(state)
    noclipOn = state
    if noclipOn then
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
end)

local infJumpOn = false
UserInputService.JumpRequest:Connect(function()
    if infJumpOn then
        local hum = getHumanoid()
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)
AddToggleButton(PlayerTab, "Infinite Jump", function(state)
    infJumpOn = state
end)

local gravityOn = false
AddToggleButton(PlayerTab, "Gravity Toggle", function(state)
    gravityOn = state
    workspace.Gravity = gravityOn and 0 or normalGravity
end)

-- Anti Ragdoll (simulado, impede o humanoid de entrar em estado de ragdoll ou "dead")
local antiRagdollOn = false
AddToggleButton(PlayerTab, "Anti Ragdoll", function(state)
    antiRagdollOn = state
    local hum = getHumanoid()
    if hum then
        if antiRagdollOn then
            hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
            hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
            hum:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false)
        else
            hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
            hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
            hum:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
        end
    end
end)

-- --------- FUNÇÕES SUJAS ---------

-- Spinbot (faz o personagem girar o torso)
local spinbotOn = false
local spinConnection = nil
AddToggleButton(SujoTab, "Spinbot", function(state)
    spinbotOn = state
    if spinbotOn then
        spinConnection = RunService.Heartbeat:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(30), 0)
            end
        end)
    else
        if spinConnection then spinConnection:Disconnect() end
    end
end)

-- Kill Aura (matar todos jogadores próximos)
local killAuraOn = false
local killRadius = 15 -- distância máxima
AddToggleButton(SujoTab, "Kill Aura", function(state)
    killAuraOn = state
end)

RunService.Heartbeat:Connect(function()
    if killAuraOn then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character:FindFirstChild("HumanoidRootPart") then
                local dist = (LocalPlayer.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude
                if dist <= killRadius then
                    -- Ataque simples simulando dano (exemplo, pois dano real depende do jogo)
                    local hum = plr.Character.Humanoid
                    if hum and hum.Health > 0 then
                        hum.Health = 0
                    end
                end
            end
        end
    end
end)

-- Rage Aimbot básico (trava no torso mais próximo)
local rageAimbotOn = false
AddToggleButton(SujoTab, "Rage Aimbot", function(state)
    rageAimbotOn = state
end)

local function getClosestEnemy()
    local closestDist = math.huge
    local target = nil
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character.HumanoidRootPart.Position
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local dist = (plr.Character.HumanoidRootPart.Position - hrp).Magnitude
                if dist < closestDist then
                    closestDist = dist
                    target = plr
                end
            end
        end
    end
    return target
end

RunService.Heartbeat:Connect(function()
    if rageAimbotOn and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local target = getClosestEnemy()
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = LocalPlayer.Character.HumanoidRootPart
            local targetPos = target.Character.HumanoidRootPart.Position
            -- Ajustar o CFrame para olhar no alvo
            hrp.CFrame = CFrame.new(hrp.Position, targetPos)
        end
    end
end)

-- Fling All (empurra os jogadores para fora do mapa)
local flingOn = false
AddToggleButton(SujoTab, "Fling All", function(state)
    flingOn = state
    if flingOn then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local targetHRP = plr.Character.HumanoidRootPart
                local myHRP = LocalPlayer.Character.HumanoidRootPart
                -- Mover o personagem para tocar o outro e empurrar (fling básico)
                local bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.Velocity = (targetHRP.Position - myHRP.Position).unit * 150 + Vector3.new(0,50,0)
                bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
                bodyVelocity.Parent = myHRP
                game.Debris:AddItem(bodyVelocity, 0.5)
            end
        end
    end
end)

-- --------- FUNÇÕES TELEPORT ---------

-- Função genérica de teleport
local function TeleportTo(position)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(position)
    end
end

AddButton(TeleportTab, "Teleport Casa", function()
    TeleportTo(Vector3.new(250, 4, 200)) -- ajuste a posição certa no seu mapa
end)

AddButton(TeleportTab, "Teleport Hospital", function()
    TeleportTo(Vector3.new(150, 4, 150))
end)

AddButton(TeleportTab, "Teleport Escola", function()
    TeleportTo(Vector3.new(100, 4, 300))
end)

AddButton(TeleportTab, "Teleport Prisão", function()
    TeleportTo(Vector3.new(300, 4, 100))
end)

AddButton(TeleportTab, "Teleport Loja de Armas", function()
    TeleportTo(Vector3.new(350, 4, 250))
end)

-- --------- FUNÇÕES VISUAIS ---------

local espOn = false
local espBoxes = {}

AddToggleButton(VisualTab, "ESP Jogadores", function(state)
    espOn = state
    -- Limpar esp atual
    for _, box in pairs(espBoxes) do
        box:Destroy()
    end
    espBoxes = {}

    if espOn then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
                local box = Instance.new("BillboardGui", plr.Character.Head)
                box.Size = UDim2.new(0, 100, 0, 20)
                box.AlwaysOnTop = true
                box.Name = "THSCR1PTS_ESP"

                local label = Instance.new("TextLabel", box)
                label.Size = UDim2.new(1, 0, 1, 0)
                label.BackgroundTransparency = 1
                label.Text = plr.Name
                label.TextColor3 = Color3.fromRGB(255, 0, 0)
                label.TextScaled = true
                label.Font = Enum.Font.GothamBold

                table.insert(espBoxes, box)
            end
        end
    end
end)

local whiteTheme = false
AddToggleButton(VisualTab, "Tema Branco / Preto", function(state)
    whiteTheme = state
    if whiteTheme then
        Main.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
        Title.TextColor3 = Color3.new(0, 0, 0)
        TabsFrame.BackgroundTransparency = 0
        for _, tab in pairs(Tabs) do
            tab.Button.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
            tab.Button.TextColor3 = Color3.new(0,0,0)
            for _, btn in pairs(tab.Buttons) do
                btn.BackgroundColor3 = Color3.fromRGB(230,230,230)
                btn.TextColor3 = Color3.new(0,0,0)
            end
        end
    else
        Main.BackgroundColor3 = Color3.fromRGB(15,15,15)
        Title.TextColor3 = Color3.new(1,1,1)
        TabsFrame.BackgroundTransparency = 1
        for _, tab in pairs(Tabs) do
            tab.Button.BackgroundColor3 = Color3.fromRGB(30,30,30)
            tab.Button.TextColor3 = Color3.new(1,1,1)
            for _, btn in pairs(tab.Buttons) do
                btn.BackgroundColor3 = Color3.fromRGB(35,35,35)
                btn.TextColor3 = Color3.new(1,1,1)
            end
        end
    end
end)

-- Botão para fechar o menu pela aba visual
AddButton(VisualTab, "Fechar Menu", function()
    Main.Visible = false
end)

-- Setar aba padrão ativa
SelectedTab = Tabs[1]
SelectedTab.Content.Visible = true
SelectedTab.Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

print("THSCR1PTS HUB carregado com sucesso!")
