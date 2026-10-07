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
