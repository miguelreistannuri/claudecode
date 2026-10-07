-- Faz a câmera seguir a bola enquanto ela voa e voltar para o personagem quando ela para.
-- Funciona sem mexer nos outros scripts: procura a bola pelo formato (esfera) ou pelo nome
-- ("Ball"/"Bola") e percebe quando ela sai voando de perto do jogador.
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

local VELOCIDADE_VOO = 20 -- studs/s: acima disso a bola começou a voar
local VELOCIDADE_PARADA = 2 -- studs/s: abaixo disso a bola está parada
local TEMPO_PARADA = 1 -- segundos com a bola parada antes de a câmera voltar
local DISTANCIA_TACADA = 25 -- a bola precisa sair de perto do jogador para ser a tacada dele
local TEMPO_MAXIMO = 20 -- segundos, no máximo, seguindo a bola
local TELEPORTE = 600 -- studs/s: mais rápido que isso é a bola sendo reposicionada, não voando
local INTERVALO = 0.1 -- segundos entre cada medição de velocidade
local TAMANHO_MAXIMO = 8 -- studs: peças maiores que isso não são a bola

-- [bola] = { posicao = Vector3, tempo = number }
local bolas = {}

local seguindo = nil
local inicioSeguir = 0
local paradaDesde = nil

local function ehBola(objeto)
	if not objeto:IsA("BasePart") or objeto.Size.Magnitude > TAMANHO_MAXIMO then
		return false
	end

	local nome = string.lower(objeto.Name)
	local esfera = objeto:IsA("Part") and objeto.Shape == Enum.PartType.Ball
	if not (esfera or string.find(nome, "ball") or string.find(nome, "bola")) then
		return false
	end

	for _, outro in Players:GetPlayers() do
		if outro.Character and objeto:IsDescendantOf(outro.Character) then
			return false
		end
	end
	return true
end

local function registrar(objeto)
	if ehBola(objeto) then
		bolas[objeto] = { posicao = objeto.Position, tempo = os.clock() }
		print("[CameraNaBola] bola encontrada:", objeto:GetFullName())
	end
end

local function voltarCamera()
	seguindo = nil
	paradaDesde = nil
	local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		workspace.CurrentCamera.CameraSubject = humanoid
	end
end

local function seguir(bola)
	seguindo = bola
	inicioSeguir = os.clock()
	paradaDesde = nil
	workspace.CurrentCamera.CameraSubject = bola
	print("[CameraNaBola] seguindo a bola:", bola:GetFullName())
end

print("[CameraNaBola] script ligado")
for _, objeto in workspace:GetDescendants() do
	registrar(objeto)
end
workspace.DescendantAdded:Connect(registrar)

player.CharacterAdded:Connect(function()
	seguindo = nil
	paradaDesde = nil
end)

local acumulado = 0
RunService.Heartbeat:Connect(function(dt)
	acumulado += dt
	if acumulado < INTERVALO then
		return
	end
	acumulado = 0

	local agora = os.clock()
	local raiz = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

	for bola, dados in bolas do
		if not bola:IsDescendantOf(workspace) then
			bolas[bola] = nil
			if bola == seguindo then
				voltarCamera()
			end
			continue
		end

		local anterior = dados.posicao
		local velocidade = (bola.Position - anterior).Magnitude / (agora - dados.tempo)
		dados.posicao = bola.Position
		dados.tempo = agora

		if velocidade > TELEPORTE then
			if bola == seguindo then
				voltarCamera()
			end
		elseif bola == seguindo then
			if velocidade < VELOCIDADE_PARADA then
				paradaDesde = paradaDesde or agora
				if agora - paradaDesde >= TEMPO_PARADA then
					voltarCamera()
				end
			else
				paradaDesde = nil
			end
			if seguindo and agora - inicioSeguir > TEMPO_MAXIMO then
				voltarCamera()
			end
		elseif
			not seguindo
			and raiz
			and velocidade > VELOCIDADE_VOO
			and (anterior - raiz.Position).Magnitude < DISTANCIA_TACADA
		then
			seguir(bola)
		end
	end
end)
