# Exportar os scripts do jogo aberto no Studio para o repositório

Instruções para a sessão local do Claude (que tem o MCP do Roblox Studio).
Objetivo: copiar os scripts do jogo para o repositório **só como referência**, para que outras
sessões (inclusive a da web) consigam ler o código. Nada no Studio deve ser alterado.

1. Confirme pelo MCP qual place está aberta (`get_place_info`) e diga ao usuário o nome dela.
   Pergunte se é o jogo certo antes de continuar.
2. Liste todos os `Script`, `LocalScript` e `ModuleScript` do jogo, com o caminho completo
   (ignore os que estiverem dentro de `ServerScriptService.Server`,
   `StarterPlayer.StarterPlayerScripts.Client` e `ReplicatedStorage.Shared`, que já vêm do Rojo).
3. Para cada um, salve o código em `referencia/<caminho com / no lugar de .>/<Nome>.<tipo>.luau`,
   onde `<tipo>` é `server`, `client` ou `module`. Exemplo:
   `ServerScriptService.Loja` → `referencia/ServerScriptService/Loja.server.luau`.
4. Crie `referencia/ESTRUTURA.md` descrevendo o jogo para quem não vê o Studio:
   - árvore resumida do Explorer (pastas, modelos importantes, Tools, RemoteEvents, GUIs);
   - o que cada script faz, em uma linha;
   - onde ficam os dados do jogador (leaderstats, DataStore, atributos), a moeda usada,
     itens da loja e do inventário;
   - como a tacada e a medição de distância funcionam.
5. **Não altere nada no Studio.** A pasta `referencia/` não é sincronizada pelo Rojo.
6. Faça commit e push para `claude/great-brown-c1ndxn` e avise o usuário.
