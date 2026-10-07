# Configuração automática pela sessão local do Claude

Este arquivo tem dois usos:

1. **Para você:** como abrir a sessão local e o que colar nela (logo abaixo).
2. **Para o Claude local:** as instruções completas que ele deve seguir (seção "Instruções para o Claude").

---

## Para você: como começar

1. Abra o Claude Code no seu computador:
   - **Aplicativo Claude (desktop):** abra a aba **Code**, clique para escolher uma pasta e escolha a
     pasta do projeto. Se você clonou com o GitHub Desktop, ela costuma ficar em
     `Documentos\GitHub\claudecode` (para conferir: **Repository ⟩ Show in Explorer** no GitHub Desktop).
   - **Ou pelo terminal:** abra a pasta do projeto no terminal e digite `claude`.
2. Garanta que está na branch `claude/great-brown-c1ndxn` (no GitHub Desktop, em **Current branch**).
   Se o arquivo `SETUP-LOCAL.md` existir na pasta, está certo.
3. Cole esta mensagem na sessão:

   ```
   Leia o arquivo SETUP-LOCAL.md e siga a seção "Instruções para o Claude" do começo ao fim.
   ```

4. O Claude vai pedir permissão para rodar comandos. Leia o que ele explica e aprove.
   Quando ele pedir para você clicar em algo no Roblox Studio, faça e responda "feito".
5. Em um momento ele vai pedir para você **reiniciar a sessão** (necessário para ativar o MCP).
   Faça isso e cole a mensagem do item 3 de novo. Ele continua de onde parou.

---

## Instruções para o Claude

Você está ajudando um iniciante a configurar um ambiente de desenvolvimento de jogos Roblox no
computador dele. Fale **sempre em português**, de forma simples e didática. Explique em uma frase
o que cada comando faz antes de rodá-lo. Quando o usuário precisar clicar em algo, diga exatamente
onde (menu, aba, botão), um passo por vez, e espere ele confirmar.

### Objetivo

No final, o ambiente terá:

- **Rojo**: sincroniza os scripts da pasta `src/` com o Roblox Studio (o código fica versionado no Git).
- **MCP do Roblox Studio** (`@chrrxs/robloxstudio-mcp`): permite a você, Claude, ver e mexer no
  Studio (Explorer, propriedades, peças, playtests, logs, screenshots).

Divisão de trabalho que deve ser respeitada depois da configuração:

- **Scripts** → edite os arquivos em `src/` (o Rojo leva ao Studio). **Nunca** edite pelo MCP um script
  que veio do Rojo: a próxima sincronização apaga a edição.
- **Peças, mapas, UI, propriedades, testes e logs** → use o MCP.

### Passo 0 — Retomada

Se esta é uma sessão reiniciada, verifique o que já está pronto (comandos e arquivos abaixo) e
pule as etapas concluídas. Diga ao usuário em que etapa vocês estão.

### Passo 1 — Diagnóstico

1. Descubra o sistema operacional (Windows ou macOS) e o shell em uso.
2. Verifique: `git --version`, `node -v`, `npx -v`, `claude --version`.
3. Confirme que a pasta atual é o repositório `miguelreistannuri/claudecode` (`git remote -v`) na
   branch `claude/great-brown-c1ndxn` (`git branch --show-current`).
   - Se não for o repositório: pergunte se o usuário já clonou com o GitHub Desktop e onde.
     Se não clonou, clone com
     `git clone -b claude/great-brown-c1ndxn https://github.com/miguelreistannuri/claudecode`
     e peça para o usuário reabrir a sessão nessa pasta.
   - Se for o repositório em outra branch: rode `git fetch origin` e
     `git checkout claude/great-brown-c1ndxn`.
4. Mostre um resumo curto: o que já está instalado e o que falta.

### Passo 2 — Instalar o que falta

- **Node.js (versão LTS, 18 ou maior):**
  - Windows: `winget install -e --id OpenJS.NodeJS.LTS`
  - macOS: se `brew` existir, `brew install node`; senão, oriente o usuário a baixar o botão
    **LTS** em https://nodejs.org e instalar (Continuar ⟩ Instalar).
- **Git** (só se faltar): Windows `winget install -e --id Git.Git`; macOS `xcode-select --install`.
- Depois de instalar algo, o terminal atual pode não enxergar o programa novo. Se `node -v` continuar
  falhando, peça ao usuário para reiniciar a sessão e retome pelo Passo 0.

### Passo 3 — Configurar o MCP do Roblox Studio

O repositório já tem `.mcp.json` com o servidor `robloxstudio`, usando `npx` direto.

- **macOS:** o `.mcp.json` funciona como está. Nada a fazer aqui.
- **Windows:** `npx` precisa de `cmd /c`. **Não altere o `.mcp.json`** (ele é compartilhado).
  Crie uma configuração local, que tem prioridade sobre a do projeto:
  ```
  claude mcp add --scope local robloxstudio -- cmd /c npx -y @chrrxs/robloxstudio-mcp@latest --auto-install-plugin
  ```
- Rode `npx -y @chrrxs/robloxstudio-mcp@latest --install-plugin` para instalar o plugin do MCP no Studio
  agora (no Windows, prefixe com `cmd /c` se necessário).
- Confira com `claude mcp list`.

### Passo 4 — Instalar o Rojo

1. Descubra a versão mais recente em https://github.com/rojo-rbx/rojo/releases/latest
   (a 7.7.1 era a mais recente em outubro de 2026) e baixe o `.zip` certo para o sistema
   (`windows-x86_64`; no Mac, `macos-aarch64` para Apple Silicon ou `macos-x86_64` para Intel —
   confira com `uname -m`).
2. Extraia o executável (`rojo.exe` ou `rojo`) para a **raiz do repositório**. Ele já está no
   `.gitignore`. No macOS, rode `chmod +x rojo` e, se o sistema bloquear, `xattr -d com.apple.quarantine rojo`.
3. Rode `./rojo --version` (Windows: `.\rojo.exe --version`) para confirmar.
4. Instale o plugin do Rojo no Studio: `./rojo plugin install` (Windows: `.\rojo.exe plugin install`).

### Passo 5 — Reiniciar a sessão

O MCP só fica disponível numa sessão nova. Explique isso ao usuário e peça:

1. Feche o Roblox Studio por completo, se estiver aberto.
2. Reinicie esta sessão do Claude (no terminal: `/exit` e depois `claude`; no aplicativo: abra uma
   nova sessão na mesma pasta) e cole de novo:
   `Leia o arquivo SETUP-LOCAL.md e siga a seção "Instruções para o Claude" do começo ao fim.`
3. Na nova sessão, aprove o servidor `robloxstudio` quando for perguntado.

### Passo 6 — Preparar o Roblox Studio (o usuário clica, você orienta)

1. Abra o Roblox Studio e abra o jogo (ou crie um novo a partir de **Baseplate**).
2. Se for um jogo novo, publique: **File ⟩ Publish to Roblox** (Arquivo ⟩ Publicar no Roblox).
3. **Home ⟩ Game Settings ⟩ Security ⟩ Allow HTTP Requests** = ligado ⟩ **Save**.
4. Na aba **Plugins**, o botão do MCP deve mostrar **Connected**.

### Passo 7 — Ligar o Rojo

1. Rode `rojo serve` **em segundo plano** (é um servidor que fica rodando) a partir da raiz do
   repositório. Avise o usuário que ele precisa ficar ligado enquanto trabalham.
2. Peça ao usuário: **Plugins ⟩ Rojo ⟩ Connect** no Studio.

### Passo 8 — Testar tudo

1. Pelo MCP, confirme que existe `StarterPlayer.StarterPlayerScripts.Client.BoasVindas` (veio do Rojo).
2. Pelo MCP, crie uma peça de teste chamada `TesteClaude` no Workspace e peça ao usuário para vê-la.
3. Inicie um playtest solo pelo MCP, confira nos logs que não há erros e que apareceu
   "Bem-vindo, ...". Pare o playtest.
4. Apague a peça `TesteClaude`.
5. Se algo falhar, diagnostique e explique em linguagem simples.

### Passo 9 — Finalizar

1. Adicione ao `CLAUDE.md` uma seção **"Sessões locais"** com: como ligar o ambiente a cada dia
   (abrir o Studio, `rojo serve`, Rojo Connect, MCP Connected) e a divisão de trabalho Rojo × MCP.
2. Faça commit e push (`git push origin claude/great-brown-c1ndxn`) só dessas mudanças de documentação.
   Nunca faça commit do executável do Rojo.
3. Dê ao usuário um resumo curto do que foi feito e uma lista de 3 a 5 ideias de pedidos para começar
   o jogo (por exemplo: "crie moedas coletáveis espalhadas pelo mapa").

### Regras gerais

- Não instale nada fora do que está listado aqui sem perguntar.
- Se um comando pedir senha de administrador ou abrir uma janela de instalação, avise o usuário antes.
- Se algo der errado, não repita o mesmo comando várias vezes: explique o erro e proponha a correção.
