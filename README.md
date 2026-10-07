# Criando jogos de Roblox com o Claude — passo a passo

Este guia conecta o **Claude Code** ao **Roblox Studio**. Depois disso, você pode pedir em português
coisas como "crie um checkpoint que salva o progresso do jogador", e o Claude cria os scripts e os
objetos direto no seu jogo aberto no Studio.

A peça que faz essa ponte se chama **MCP**. Vamos instalar tudo em 5 passos.
Faça na ordem, **no mesmo computador onde você usa o Roblox Studio**.

> 💡 **O que é o "terminal"?** É uma janela onde você digita comandos em vez de clicar.
> Vários passos pedem para você colar um comando nela.
> - **Windows:** clique no botão Iniciar, digite `PowerShell` e abra o **Windows PowerShell**.
> - **Mac:** aperte `Cmd + Espaço`, digite `Terminal` e aperte Enter.
>
> Para colar um comando: copie daqui, clique na janela do terminal, cole
> (`Ctrl + V` no Windows, `Cmd + V` no Mac) e aperte **Enter**.

---

## Passo 1 — Instalar o Node.js

O Node.js é um programa gratuito que o MCP precisa para funcionar. Você só instala uma vez.

1. Abra o site **https://nodejs.org**.
2. Clique no botão grande de download escrito **LTS** (é a versão estável recomendada).
   O site já detecta se você usa Windows ou Mac.
3. Abra o arquivo baixado:
   - **Windows:** arquivo `.msi`. Vá clicando em **Next**, aceite os termos, e no fim **Install**
     e **Finish**. Pode deixar todas as opções como vieram.
   - **Mac:** arquivo `.pkg`. Vá clicando em **Continuar** e **Instalar** (ele pede a senha do Mac).
4. **Feche e abra de novo** o terminal (ele só "enxerga" o Node.js depois de reaberto).
5. Confira se deu certo digitando no terminal:
   ```
   node -v
   ```
   Se aparecer algo como `v22.11.0`, funcionou. ✅
   Se aparecer "não é reconhecido" ou "command not found", reinicie o computador e tente de novo.

---

## Passo 2 — Instalar o Claude Code

O Claude Code é o Claude que roda no seu computador e consegue mexer em programas como o Studio.
Você precisa de uma conta Claude com plano **Pro** ou **Max**.

**Windows**

1. Primeiro instale o **Git** (o Claude Code precisa dele no Windows):
   abra **https://git-scm.com/downloads/win**, baixe o instalador, e clique **Next** em tudo
   até **Install** e **Finish**.
2. Feche e abra de novo o PowerShell, e cole:
   ```
   irm https://claude.ai/install.ps1 | iex
   ```

**Mac**

1. No Terminal, cole:
   ```
   curl -fsSL https://claude.ai/install.sh | bash
   ```

**Depois (Windows e Mac)**

3. Feche e abra o terminal de novo e digite:
   ```
   claude
   ```
4. Na primeira vez, ele abre o navegador para você entrar com sua conta Claude. Faça o login
   e volte para o terminal. Para sair do Claude Code, digite `/exit`.

---

## Passo 3 — Conectar o MCP do Roblox ao Claude Code

Isso é um único comando. Copie o do seu sistema e cole no terminal:

**Windows**
```
claude mcp add --scope user robloxstudio -- cmd /c npx -y @chrrxs/robloxstudio-mcp@latest --auto-install-plugin
```

**Mac**
```
claude mcp add --scope user robloxstudio -- npx -y @chrrxs/robloxstudio-mcp@latest --auto-install-plugin
```

O que esse comando faz: registra o MCP do Roblox no Claude Code para **todos** os seus projetos
(`--scope user`) e, na primeira vez que rodar, instala sozinho o plugin dentro do Roblox Studio
(`--auto-install-plugin`).

Confira com:
```
claude mcp list
```
Deve aparecer uma linha com `robloxstudio`.

---

## Passo 4 — Preparar o Roblox Studio

1. **Feche o Roblox Studio por completo** e abra de novo (para ele carregar o plugin novo).
2. Abra o jogo (place) em que quer trabalhar, ou crie um novo a partir de **Baseplate**.
3. Libere a comunicação do plugin:
   - Na aba **Home** (Início), clique em **Game Settings** (Configurações do jogo).
   - Vá em **Security** (Segurança).
   - Ative **Allow HTTP Requests** (Permitir solicitações HTTP) e clique em **Save**.
   - Se essa opção estiver cinza, primeiro salve o jogo na sua conta:
     **File ⟩ Publish to Roblox** (Arquivo ⟩ Publicar no Roblox) e tente de novo.
4. Clique na aba **Plugins**. Deve haver um botão do MCP; clique nele.
   Quando aparecer **Connected** (Conectado), está tudo pronto. ✅

---

## Passo 5 — Testar

Com o Studio aberto e o plugin **Connected**:

1. No terminal, digite `claude` e aperte Enter.
2. Escreva um pedido simples, por exemplo:
   ```
   Crie uma peça vermelha de 10x1x10 flutuando no Workspace, acima do spawn.
   ```
3. O Claude vai pedir permissão para usar as ferramentas do Roblox. Aceite.
4. Olhe o Studio: a peça deve aparecer. 🎉

Outros pedidos para experimentar:
- "Crie um sistema de moedas: peças douradas que somem quando o jogador encosta e somam pontos no placar."
- "Faça um obby simples com 5 plataformas e um checkpoint em cada uma."
- "Inicie um playtest e me diga se aparecer algum erro no Output."

---

## Deu problema?

| Sintoma | O que fazer |
|---|---|
| `node` ou `npx` "não é reconhecido" | Feche e abra o terminal. Se continuar, reinicie o PC. |
| `claude` "não é reconhecido" | Feche e abra o terminal. No Windows, confira se o Git foi instalado (Passo 2). |
| O botão do plugin não aparece no Studio | Rode `claude` uma vez (isso instala o plugin), depois feche e abra o Studio. |
| Plugin não fica **Connected** | Confira o **Allow HTTP Requests** (Passo 4) e se o `claude` está aberto no terminal. |
| Quer recomeçar a configuração | `claude mcp remove robloxstudio --scope user` e repita o Passo 3. |

## Cuidados

- O Claude pode **alterar e apagar** coisas no jogo aberto. Salve com frequência
  (**File ⟩ Save to Roblox**). Pelo histórico de versões dá para voltar atrás.
- Teste o jogo (botão **Play**) antes de publicar as mudanças para os jogadores.
- Quer que ele só **olhe** sem mexer? Troque `@chrrxs/robloxstudio-mcp` por
  `@chrrxs/robloxstudio-mcp-inspector` no comando do Passo 3.

## Alternativa: MCP oficial embutido no Studio

O próprio Roblox Studio tem um MCP oficial. Se preferir ele em vez dos Passos 3 e 4:
no Studio, abra **Assistant Settings ⟩ MCP Servers ⟩ Quick connect** e ative **Claude Code**
(o Claude Code do Passo 2 precisa estar instalado). Use só **um** dos dois, não ambos.

## Sobre o arquivo `.mcp.json` deste repositório

Ele faz o mesmo que o Passo 3, mas só quando você abre o `claude` dentro desta pasta.
Se você já fez o Passo 3, não precisa dele. No Windows, ele precisa usar `cmd /c` no
início, como no comando do Passo 3.
