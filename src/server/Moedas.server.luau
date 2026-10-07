-- Cria o placar "Moedas" para cada jogador que entra no jogo.
local Players = game:GetService("Players")

local Config = require(game:GetService("ReplicatedStorage").Shared.Config)

Players.PlayerAdded:Connect(function(player)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	local moedas = Instance.new("IntValue")
	moedas.Name = "Moedas"
	moedas.Value = Config.MoedasIniciais
	moedas.Parent = leaderstats
end)
