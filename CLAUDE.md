# Projeto Roblox (Rojo)

Jogo de Roblox cujo código fica neste repositório e é sincronizado com o Roblox Studio pelo Rojo
(`default.project.json`). O dono do projeto é iniciante: explique em português, passo a passo.

- `src/server` → ServerScriptService.Server (scripts de servidor: `Nome.server.luau`)
- `src/client` → StarterPlayer.StarterPlayerScripts.Client (scripts locais: `Nome.client.luau`)
- `src/shared` → ReplicatedStorage.Shared (ModuleScripts: `Nome.luau`)
- Código em Luau, indentação com tabs.
- O Rojo sincroniza só scripts. Peças, mapas e UI feitos no Studio não ficam aqui; quando
  precisar de objetos, crie-os por script ou explique ao usuário como criá-los no Studio.
- Depois de cada mudança, lembrar o usuário de fazer **Pull** no GitHub Desktop.

## O jogo (golfe)

Campo de tacadas: o jogador usa um taco (Tool, ex.: "Taco mole") e clica para bater na bola; a
distância aparece na tela e em cima da bola, com placas de 100 m, 200 m... no campo.
Já existem no Studio (fora do Rojo): loja, inventário, leaderstats **Recorde** (maior distância)
e **$** (dinheiro). Não crie outro leaderstats nem outra moeda: use os existentes.
O código atual do jogo ficará em `referencia/` (exportado pela sessão local, ver `EXPORTAR-JOGO.md`).
Leia `referencia/ESTRUTURA.md` antes de mudar algo no jogo.
