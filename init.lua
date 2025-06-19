-- THSCR1PTS HUB COMPLETO - GUI nativa estilo Rael Hub com funções ajustáveis e sujas (sem autofarm e fling)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Config padrões
local defaultSpeed = 16
local defaultJump = 50
local defaultGravity = workspace.Gravity
local defaultSpinSpeed = 30
local defaultKillRadius = 15

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

-- Frame principal
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 480, 0, 550)
Main.Position = UDim2.new(0.5, -240, 0.5, -275)
Main.BackgroundColor3 = Color3.fromRGB(15,15,15)
Main.BorderSizePixel = 0
Main.Visible = false
Main.ClipsDescendants = true
Main.Active = true
Main.Draggable = true

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundColor3 = Color3.fromRGB(10,10,10)
Title.Text = "THSCR1PTS HUB"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true
Title.BorderSizePixel = 0

local CloseBtn = Instance.new("TextButton", Main)
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -50, 0, 5)
CloseBtn.Text = "X"
CloseBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
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

-- Container abas
local TabsFrame = Instance.new("Frame", Main)
TabsFrame.Size = UDim2.new(1, -20, 0, 45)
TabsFrame.Position = UDim2.new(0, 10, 0, 55)
TabsFrame.BackgroundTransparency = 1

local UIListLayout = Instance.new("UIListLayout", TabsFrame)
UIListLayout.FillDirection = Enum.FillDirection.Horizontal
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)

local ContentFrame = Instance.new("Frame", Main)
ContentFrame.Size = UDim2.new(1, -20, 1, -110)
ContentFrame.Position = UDim2.new(0, 10, 0, 105)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ClipsDescendants = true

-- Função para criar abas
local Tabs = {}
local SelectedTab = nil
local function CreateTab(name)
    local TabBtn = Instance.new("TextButton", TabsFrame)
    TabBtn.Size = UDim2.new(0, 110, 1, 0)
    TabBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
    TabBtn.Text = name
    TabBtn.TextColor3 = Color3.new(1,1,1)
    TabBtn.Font = Enum.Font.GothamBold
    TabBtn.TextScaled = true
    TabBtn.BorderSizePixel = 0
    TabBtn.AutoButtonColor = false
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
            SelectedTab.Button.BackgroundColor3 = Color3.fromRGB(30,30,30)
        end
        SelectedTab = Tab
        SelectedTab.Content.Visible = true
        SelectedTab.Button.BackgroundColor3 = Color3.fromRGB(60,60,60)
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
        btn.BackgroundColor3 = enabled and Color3.fromRGB(0,150,0) or Color3.fromRGB(35,35,35)
    end)
    table.insert(tab.Buttons, btn)
    return btn
end

-- Função para criar botões simples
local function AddButton(tab, text, callback)
    local btn = Instance.new("TextButton", tab.Content)
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.Gotham
    btn.TextScaled = true
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.MouseButton1Click:Connect(callback)
    table.insert(tab.Buttons, btn)
    return btn
end

-- Função para criar sliders
local function AddSlider(tab, text, minVal, maxVal, defaultVal, callback)
    local container = Instance.new("Frame", tab.Content)
    container.Size = UDim2.new(1, 0, 0, 60)
    container.BackgroundTransparency = 1

    local label = Instance.new("TextLabel", container)
    label.Size = UDim2.new(0.5, 0, 0, 20)
    label.Position = UDim2.new(0, 5, 0, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1,1,1)
    label.Font = Enum.Font.Gotham
    label.TextScaled = true
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Text = text .. ": " .. tostring(defaultVal)

    local sliderFrame = Instance.new("Frame", container)
    sliderFrame.Size = UDim2.new(0.95, -10, 0, 20)
    sliderFrame.Position = UDim2.new(0, 5, 0, 30)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(35,35,35)
    sliderFrame.BorderSizePixel = 0

    local sliderButton = Instance.new("TextButton", sliderFrame)
    sliderButton.Size = UDim2.new((defaultVal - minVal)/(maxVal - minVal), 0, 1, 0)
    sliderButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    sliderButton.BorderSizePixel = 0
    sliderButton.AutoButtonColor = false
    sliderButton.Text = ""

    local dragging = false

    local function updateValue(inputPos)
        local relativeX = math.clamp(inputPos.X - sliderFrame.AbsolutePosition.X, 0, sliderFrame.AbsoluteSize.X)
        local percent = relativeX / sliderFrame.AbsoluteSize.X
        local value = math.floor(minVal + (maxVal - minVal) * percent)
        sliderButton.Size = UDim2.new(percent, 0, 1, 0)
        label.Text = text .. ": " .. value
        callback(value)
    end

    sliderButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)

    sliderButton.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateValue(input.Position)
        end
    end)

    return container
end

-- PLAYER TAB FUNÇÕES

local function getHumanoid()
    if LocalPlayer.Character then
        return LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    end
    return nil
end

local currentSpeed = defaultSpeed
local speedOn = false
AddToggleButton(PlayerTab, "Speed Hack", function(state)
    speedOn = state
    local hum = getHumanoid()
    if hum then
        hum.WalkSpeed = speedOn and currentSpeed or defaultSpeed
    end
end)

AddSlider(PlayerTab, "Speed", 16, 300, defaultSpeed, function(val)
    currentSpeed = val
    if speedOn then
        local hum = getHumanoid()
        if hum then hum.WalkSpeed = val end
    end
end)

local currentJump = defaultJump
local jumpOn = false
AddToggleButton(PlayerTab, "Super Jump", function(state)
    jumpOn = state
    local hum = getHumanoid()
    if hum then
        hum.JumpPower = jumpOn and currentJump or defaultJump
    end
end)

AddSlider(PlayerTab, "Jump Power", 50, 500, defaultJump, function(val)
    currentJump = val
    if jumpOn then
        local hum = getHumanoid()
        if hum then hum.JumpPower = val end
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

local currentGravity = defaultGravity
local gravityOn = false
AddToggleButton(PlayerTab, "Gravity Toggle", function(state)
    gravityOn = state
    workspace.Gravity = gravityOn and currentGravity or defaultGravity
end)

AddSlider(PlayerTab, "Gravity", 0, 500, defaultGravity, function(val)
    currentGravity = val
    if gravityOn then
        workspace.Gravity = val
    end
end)

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

-- SUJO TAB FUNÇÕES

local spinbotOn = false
local spinConnection = nil
local currentSpinSpeed = defaultSpinSpeed

AddToggleButton(SujoTab, "Spinbot", function(state)
    spinbotOn = state
    if spinbotOn then
        spinConnection = RunService.Heartbeat:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(currentSpinSpeed), 0)
            end
        end)
    else
        if spinConnection then spinConnection:Disconnect() spinConnection=nil end
    end
end)

AddSlider(SujoTab, "Spinbot Speed", 10, 500, defaultSpinSpeed, function(val)
    currentSpinSpeed = val
end)

local killAuraOn = false
local currentKillRadius = defaultKillRadius

AddToggleButton(SujoTab, "Kill Aura", function(state)
    killAuraOn = state
end)

AddSlider(SujoTab, "Kill Aura Radius", 5, 100, defaultKillRadius, function(val)
    currentKillRadius = val
end)

RunService.Heartbeat:Connect(function()
    if killAuraOn then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character:FindFirstChild("HumanoidRootPart") then
                local dist = (LocalPlayer.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude
                if dist <= currentKillRadius then
                    local hum = plr.Character.Humanoid
                    if hum and hum.Health > 0 then
                        hum.Health = 0
                    end
                end
            end
        end
    end
end)

-- Rage Aimbot básico
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
            hrp.CFrame = CFrame.new(hrp.Position, targetPos)
        end
    end
end)

-- TELEPORT TAB FUNÇÕES

local function TeleportTo(position)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(position)
    end
end

AddButton(TeleportTab, "Teleport Casa", function()
    TeleportTo(Vector3.new(250, 4, 200))
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

-- VISUAL TAB FUNÇÕES

local espOn = false
local espBoxes = {}

AddToggleButton(VisualTab, "ESP Jogadores", function(state)
    espOn = state
    for _, box in pairs(espBoxes) do
        box:Destroy()
    end
    espBoxes = {}

    if espOn then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
                local box = Instance.new("BillboardGui", plr.Character.Head)
                box.Size = UDim2.new(0, 100, 0, 50)
                box.Adornee = plr.Character.Head
                box.AlwaysOnTop = true

                local frame = Instance.new("Frame", box)
                frame.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                frame.BorderColor3 = Color3.new(0, 0, 0)
                frame.Size = UDim2.new(1, 0, 1, 0)
                frame.BackgroundTransparency = 0.5
                table.insert(espBoxes, box)
            end
        end
    end
end)

AddToggleButton(VisualTab, "Wall Hack", function(state)
    -- Wallhack básico: muda a transparência dos players para ver pelas paredes
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            for _, part in pairs(plr.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.LocalTransparencyModifier = state and 0.4 or 0
                end
            end
        end
    end
end)

AddToggleButton(VisualTab, "Night Mode", function(state)
    workspace.Lighting.ClockTime = state and 0 or 14
    workspace.Lighting.Brightness = state and 1 or 2
end)

-- Aba inicial selecionada
Tabs[1].Button.BackgroundColor3 = Color3.fromRGB(60,60,60)
Tabs[1].Content.Visible = true
SelectedTab = Tabs[1]

print("THSCR1PTS HUB COMPLETO carregado!")

