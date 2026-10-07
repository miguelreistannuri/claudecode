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

## Opção B — `@chrrxs/robloxstudio-mcp` (comunidade, já configurado neste repositório)

Fork mantido do `robloxstudio-mcp`, com mais ferramentas: rodar Luau no modo edição e em
playtests (servidor/cliente), iniciar/parar playtests solo e multiplayer, ler logs, capturas
de tela, profiler, buscar e inserir assets da Creator Store, e consultar a documentação da API.

Pré-requisito: [Node.js](https://nodejs.org) 18+ (para o `npx`).

1. No Studio: **Game Settings ⟩ Security ⟩ Allow HTTP Requests** = ligado.
2. Clone este repositório e rode `claude` dentro da pasta. Aprove o servidor
   `robloxstudio` quando o Claude Code perguntar (vem do `.mcp.json`).
   A flag `--auto-install-plugin` instala o plugin do Studio automaticamente.
3. Feche e reabra o Roblox Studio. Quando o plugin mostrar **Connected**, está pronto.

Para instalar só o plugin manualmente: `npx -y @chrrxs/robloxstudio-mcp@latest --install-plugin`.

No Windows nativo (fora do WSL), se o `npx` falhar, troque o comando em `.mcp.json` por:

```json
"command": "cmd",
"args": ["/c", "npx", "-y", "@chrrxs/robloxstudio-mcp@latest", "--auto-install-plugin"]
```

Alternativa sem o `.mcp.json` (vale para todos os seus projetos com `--scope user`):
`claude mcp add robloxstudio -- npx -y @chrrxs/robloxstudio-mcp@latest --auto-install-plugin`

Quer só leitura (sem editar a place)? Use o pacote `@chrrxs/robloxstudio-mcp-inspector`.

## Segurança

Clientes MCP podem ler e modificar o conteúdo da place aberta. Salve/publique versões
com frequência e revise o código gerado antes de publicar o jogo.
