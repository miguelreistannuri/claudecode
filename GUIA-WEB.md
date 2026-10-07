# Usando o Claude pela web + GitHub Desktop + Rojo

Neste jeito de trabalhar, você **não instala o Claude no computador**. O caminho é este:

```
Você pede no Claude (web)  →  o Claude escreve os scripts e envia ao GitHub
        →  você clica "Pull" no GitHub Desktop  →  o Rojo coloca os scripts no Roblox Studio
```

**Rojo** é um programa gratuito, muito usado por desenvolvedores de Roblox, que copia os scripts de uma
pasta do seu computador para dentro do Studio, automaticamente.

> ⚠️ **Limite deste jeito:** o Claude da web **não vê** o seu Studio. Ele escreve **scripts**, mas não
> consegue mexer em peças, mapas ou interfaces que você montou à mão, nem testar o jogo para você.
> Se precisar disso, use o guia principal (`README.md`), com o Claude instalado no computador.

A configuração (Passos 1 a 4) é feita **uma vez só**. Depois, o dia a dia é o Passo 5.

---

## Passo 1 — Baixar o projeto com o GitHub Desktop

1. Abra o **GitHub Desktop**.
2. Clique em **File ⟩ Clone repository** (Arquivo ⟩ Clonar repositório).
3. Na aba **GitHub.com**, escolha **miguelreistannuri/claudecode**.
4. Em **Local path**, veja onde a pasta vai ficar (pode deixar como está) e clique em **Clone**.
5. No topo, clique em **Current branch** e escolha **claude/great-brown-c1ndxn**
   (é onde o Claude está salvando o trabalho).

---

## Passo 2 — Baixar o Rojo

1. Abra **https://github.com/rojo-rbx/rojo/releases/latest**.
2. Desça até **Assets** e baixe o arquivo do seu sistema:
   - **Windows:** o que tem `windows` no nome (termina em `.zip`).
   - **Mac:** o que tem `macos` no nome.
3. Abra o `.zip` e **copie o arquivo `rojo.exe`** (no Mac, `rojo`) **para dentro da pasta do projeto**
   (a pasta do Passo 1). Dica: no GitHub Desktop, **Repository ⟩ Show in Explorer** abre essa pasta.

Não se preocupe: esse arquivo não vai para o GitHub (o projeto já está configurado para ignorá-lo).

---

## Passo 3 — Instalar o plugin do Rojo no Studio

1. No GitHub Desktop, clique em **Repository ⟩ Open in Command Prompt**
   (no Mac: **Open in Terminal**). Abre uma janela preta, já dentro da pasta do projeto.
2. Digite e aperte **Enter**:
   ```
   rojo plugin install
   ```
   - Se aparecer "não é reconhecido", digite `.\rojo plugin install`.
   - No Mac, digite `./rojo plugin install`. Se o Mac bloquear o programa, abra
     **Ajustes do Sistema ⟩ Privacidade e Segurança** e clique em **Abrir mesmo assim**.
3. Se o Studio estiver aberto, feche e abra de novo.

---

## Passo 4 — Ligar o Rojo e conectar ao Studio

1. Na mesma janela preta, digite:
   ```
   rojo serve
   ```
   (ou `.\rojo serve` / `./rojo serve`, como no passo anterior).
   Vai aparecer uma mensagem dizendo que ele está rodando. **Deixe essa janela aberta** enquanto
   estiver trabalhando. Para desligar, feche a janela.
2. No Roblox Studio, abra o seu jogo (ou crie um novo a partir de **Baseplate**).
3. Na aba **Plugins**, clique em **Rojo** e depois em **Connect**.
4. Pronto! No **Explorer**, em **ServerScriptService**, deve aparecer a pasta **Server** com o
   script **Moedas**. Aperte **Play**: o placar **Moedas** aparece no canto da tela. ✅

---

## Passo 5 — O dia a dia

1. Abra o GitHub Desktop, o Studio, e deixe o `rojo serve` rodando (Passo 4).
   No Studio: **Plugins ⟩ Rojo ⟩ Connect**.
2. Peça o que quiser ao Claude na web, por exemplo:
   *"Faça as moedas aumentarem 1 a cada 10 segundos para cada jogador."*
3. Quando o Claude disser que enviou (fez "push"), vá ao GitHub Desktop e clique em
   **Fetch origin** e depois em **Pull origin**.
4. O Rojo atualiza o Studio sozinho em segundos. Aperte **Play** para testar.

Encontrou um erro no jogo? Copie a mensagem vermelha da janela **Output** do Studio
(**View ⟩ Output** se não estiver aparecendo) e cole para o Claude.

---

## Como o projeto está organizado

| Pasta no projeto | Onde aparece no Studio | Para quê |
|---|---|---|
| `src/server` | ServerScriptService ⟩ Server | Scripts do servidor (regras do jogo, moedas, dados) |
| `src/client` | StarterPlayer ⟩ StarterPlayerScripts ⟩ Client | Scripts do jogador (câmera, teclas, efeitos) |
| `src/shared` | ReplicatedStorage ⟩ Shared | Módulos usados pelos dois lados (configurações) |

## Cuidados

- **Não edite no Studio os scripts que vêm do Rojo.** Na próxima atualização, o Rojo apaga a edição.
  Peça a mudança ao Claude.
- Peças, mapas e interfaces que você monta à mão no Studio **não** vão para o GitHub.
  Salve o jogo normalmente no Studio (**File ⟩ Save to Roblox**).
