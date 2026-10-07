# Desenvolvimento de jogos Roblox com Claude Code

Este repositório vem com um servidor MCP de Roblox Studio configurado em `.mcp.json`.
Com ele, o Claude Code consegue ler e editar a place aberta no Studio: criar e editar scripts,
inspecionar o Explorer, inserir instâncias, rodar código e testar o jogo.

> O MCP conversa com o Roblox Studio **na sua máquina** (via plugin + localhost).
> Por isso, ele precisa rodar no mesmo computador onde o Studio está aberto
> (Windows ou macOS), e não em uma sessão na nuvem.

## Opção A — servidor MCP embutido no Roblox Studio (oficial, recomendado)

1. Instale o [Claude Code](https://code.claude.com) e abra-o pelo menos uma vez.
2. No Roblox Studio, abra **Assistant Settings ⟩ MCP Servers**.
3. Em **Quick connect**, ative **Claude Code**. Se não aparecer, reinicie o Studio.
4. No terminal, rode `claude mcp list` para conferir a conexão.

Se usar esta opção, você pode remover a entrada `robloxstudio` de `.mcp.json`
para não ter dois servidores ativos ao mesmo tempo.

## Opção B — `robloxstudio-mcp` (comunidade, já configurado neste repositório)

Pré-requisito: [Node.js](https://nodejs.org) 18+ (para o `npx`).

1. Baixe o plugin do Studio (`MCPPlugin.rbxmx`) nas
   [releases do robloxstudio-mcp](https://github.com/boshyxd/robloxstudio-mcp/releases)
   e copie para a pasta de plugins do Studio:
   - Windows: `%LOCALAPPDATA%\Roblox\Plugins`
   - macOS: `~/Documents/Roblox/Plugins`
2. No Studio: **Game Settings ⟩ Security ⟩ Allow HTTP Requests** = ligado.
3. Clone este repositório e rode `claude` dentro da pasta. Aprove o servidor
   `robloxstudio` quando o Claude Code perguntar (vem do `.mcp.json`).
4. Clique no botão do plugin no Studio; ele deve mostrar **Connected**.

No Windows nativo (fora do WSL), se o `npx` falhar, troque o comando em `.mcp.json` por:

```json
"command": "cmd",
"args": ["/c", "npx", "-y", "robloxstudio-mcp@latest"]
```

Alternativa sem o `.mcp.json`:
`claude mcp add robloxstudio -- npx -y robloxstudio-mcp@latest`

## Segurança

Clientes MCP podem ler e modificar o conteúdo da place aberta. Salve/publique versões
com frequência e revise o código gerado antes de publicar o jogo.
