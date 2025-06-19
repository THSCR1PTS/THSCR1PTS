-- THSCR1PTS HUB COMPLETO - Aimbots variados + funções ajustáveis e sujas (sem autofarm e fling)
-- Visual preto estilo Rael Hub, GUI nativa Roblox

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- CONFIG PADRÃO
local defaultSpeed = 16
local defaultJump = 50
local defaultGravity = workspace.Gravity
local defaultSpinSpeed = 30
local defaultKillRadius = 15

-- Variáveis globais
local currentSpeed = defaultSpeed
local currentJump = defaultJump
local currentGravity = defaultGravity
local currentSpinSpeed = defaultSpinSpeed
local currentKillRadius = defaultKillRadius

-- Flags ON/OFF
local speedOn = false
local jumpOn = false
local gravityOn = false
local noclipOn = false
local infJumpOn = false
local antiRagdollOn = false
local spinbotOn = false
local killAuraOn = false
local rageAimbotOn = false
local silentAimOn = false
local regularAimbotOn = false
local triggerbotOn = false
local espOn = false
local wallhackOn = false
local nightModeOn = false

-- Helper functions
local function getHumanoid()
    if LocalPlayer.Character then
        return LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    end
    return nil
end

local function getClosestEnemy(maxDistance)
    local closestDist = maxDistance or math.huge
    local target = nil
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character.HumanoidRootPart.Position
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChildOfClass("Humanoid") and plr.Character.Humanoid.Health > 0 then
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

local function isVisible(target)
    if not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then return false end
    local origin = workspace.CurrentCamera.CFrame.Position
    local direction = (target.Character.HumanoidRootPart.Position - origin).Unit * 500
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {LocalPlayer.Character}
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    local raycastResult = workspace:Raycast(origin, direction, raycastParams)
    if raycastResult and raycastResult.Instance then
        if raycastResult.Instance:IsDescendantOf(target.Character) then
            return true
        end
    end
    return false
end

-- Criar ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "THSCR1PTS_HUB"
ScreenGui.Parent = game:GetService("CoreGui")

-- Botão abrir HUB
local OpenBtn = Instance.new("TextButton", ScreenGui)
OpenBtn.Size = UDim2.new(0, 160, 0, 40)
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
Main.Size = UDim2.new(0, 500, 0, 560)
Main.Position = UDim2.new(0.5, -250, 0.5, -280)
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
TabsFrame.Size = UDim2.new(1, -20, 0, 50)
TabsFrame.Position = UDim2.new(0, 10, 0, 55)
TabsFrame.BackgroundTransparency = 1

local UIListLayout = Instance.new("UIListLayout", TabsFrame)
UIListLayout.FillDirection = Enum.FillDirection.Horizontal
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)

local ContentFrame = Instance.new("Frame", Main)
ContentFrame.Size = UDim2.new(1, -20, 1, -120)
ContentFrame.Position = UDim2.new(0, 10, 0, 110)
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

-- === PLAYER TAB FUNÇÕES === --

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

AddToggleButton(PlayerTab, "Infinite Jump", function(state)
    infJumpOn = state
end)

UserInputService.JumpRequest:Connect(function()
    if infJumpOn then
        local hum = getHumanoid()
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

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

-- === SUJO TAB FUNÇÕES === --

local spinConnection = nil
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

-- Rage Aimbot básico (gira personagem instantâneo)
AddToggleButton(SujoTab, "Rage Aimbot", function(state)
    rageAimbotOn = state
end)

RunService.Heartbeat:Connect(function()
    if rageAimbotOn and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local target = getClosestEnemy(300)
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = LocalPlayer.Character.HumanoidRootPart
            local targetPos = target.Character.HumanoidRootPart.Position
            hrp.CFrame = CFrame.new(hrp.Position, targetPos)
        end
    end
end)

-- Silent Aim (manipula o mouse para mirar automaticamente - muito
