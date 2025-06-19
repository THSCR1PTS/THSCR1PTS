-- Teste simples com Rayfield
local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()
end)

if not success then
    warn("Erro ao carregar Rayfield. Seu executor talvez bloqueie loadstring ou HTTPGet.")
    return
end

local Window = Rayfield:CreateWindow({
    Name = "THSCR1PTS HUB TEST",
    LoadingTitle = "Testando Rayfield...",
    LoadingSubtitle = "By THSCR1PTS",
    ConfigurationSaving = {
        Enabled = false
    }
})

local Tab = Window:CreateTab("Principal", nil)

Tab:CreateButton({
    Name = "Botão de Teste",
    Callback = function()
        print("Funcionou Rayfield no seu executor!")
    end
})

