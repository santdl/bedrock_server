# Servidor Minecraft Bedrock (Docker)

Stack: servidor Bedrock (`itzg`), túnel playit.gg (contorna o CGNAT) e backup
automático em `.mcworld` (`kaiede/minecraft-bedrock-backup`).

```powershell
docker compose up -d          # sobe tudo
docker compose logs -f mc-bedrock
```

## Mundos

Todos os mundos vivem no volume `bedrock_server_bedrock-data`, cada um em
`/data/worlds/<nome>`. O mundo ativo é o que estiver em `LEVEL_NAME` no
`docker-compose.yml` — **o nome precisa bater exatamente com o nome da pasta**.

Disponíveis hoje:

| Mundo                 | Observação                          |
|-----------------------|-------------------------------------|
| `Bedrock level`       | mundo original da família           |
| `One Block Adventure` | traz os add-ons BP_OB/RP_OB embutidos |
| `Medieval Honor City` | mapa importado                      |

> ⚠️ Se `LEVEL_NAME` apontar para uma pasta que não existe, o servidor **não**
> dá erro: ele gera um mundo novo do zero com aquele nome, com seed aleatória e
> as configurações atuais de `GAMEMODE`/`DIFFICULTY`. É assim que se cria um
> mundo novo aqui — e também como se perde o mundo certo por um erro de
> digitação. Confira a lista de pastas antes de trocar.

### Criar um mundo novo (gerado pelo servidor)

Basta pôr um nome inédito em `LEVEL_NAME` e recriar o container:

```powershell
docker compose up -d --force-recreate mc-bedrock
docker compose logs -f mc-bedrock      # a geracao leva ~1 min no primeiro boot
```

Acrescente o mundo em `backups/config.yml` e reinicie o backup — **depois** que
a pasta existir em `/data/worlds`, porque o caminho é lido no momento do backup:

```powershell
docker run --rm -v bedrock_server_bedrock-data:/data alpine ls /data/worlds
docker compose restart mc-backup
docker compose logs --tail 50 mc-backup
```

Se mais tarde chegar um `.mcworld` com esse mesmo nome, apague antes a pasta
gerada (ou importe com outro nome) — o unzip por cima mistura os dois mundos.

### Listar os mundos que estão no volume

```powershell
docker run --rm -v bedrock_server_bedrock-data:/data alpine ls -la /data/worlds
```

### Alternar entre mundos

1. Edite `LEVEL_NAME` no `docker-compose.yml`.
2. Recrie só o servidor:

```powershell
docker compose up -d --force-recreate mc-bedrock
```

O mundo anterior continua intacto no volume; voltar é só reverter o `LEVEL_NAME`.

### Importar um mundo novo (.mcworld)

Um `.mcworld` é um zip. Importar = descompactar dentro de `/data/worlds/` com o
nome de pasta que você vai usar no `LEVEL_NAME`.

```powershell
# 1. Pare o servidor (evita escrita concorrente no volume)
docker compose stop mc-bedrock

# 2. Descompacte o .mcworld no volume. Ajuste as duas aspas com o nome do mundo.
docker run --rm `
  -v bedrock_server_bedrock-data:/data `
  -v "${PWD}:/import" `
  alpine sh -c "mkdir -p '/data/worlds/Mapa Novo' && `
    unzip -o '/import/Mapa Novo.mcworld' -d '/data/worlds/Mapa Novo' && `
    chown -R 1000:1000 '/data/worlds/Mapa Novo'"

# 3. Confira que o level.dat ficou na raiz da pasta (e não num subdiretório)
docker run --rm -v bedrock_server_bedrock-data:/data alpine ls -la "/data/worlds/Mapa Novo"

# 4. Aponte LEVEL_NAME para o mundo novo no docker-compose.yml e suba
docker compose up -d --force-recreate mc-bedrock
docker compose logs -f mc-bedrock
```

O `chown -R 1000:1000` é obrigatório: o servidor roda como uid 1000 e não
consegue salvar num mundo que ficou pertencendo ao root.

Depois de importar, **acrescente o mundo em `backups/config.yml`** e reinicie o
backup, senão o mundo novo nunca entra na rotina:

```powershell
docker compose restart mc-backup
```

### Mapas da Marketplace

Mapas pagos da Marketplace são protegidos por DRM e normalmente não rodam num
servidor dedicado — mesmo exportando pelo cliente, os packs vêm criptografados e
o servidor recusa carregar. Só entram aqui mapas distribuídos como `.mcworld`
livre (o caso do One Block Adventure e do Medieval Honor City).

## Backups

Vão para `./backups`, a cada 6h e no logout do último jogador (`backups/config.yml`).
São `.mcworld` prontos para importar em qualquer cliente Bedrock.

A lista `worlds:` do `backups/config.yml` inclui **todos** os mundos do volume,
ativos ou não — assim trocar o `LEVEL_NAME` não deixa o backup rodando no mundo
errado. Todo mundo novo (gerado ou importado) precisa ser somado a essa lista à
mão; o arquivo fica fora do git (`backups/` é ignorado), então ele não vem junto
num clone novo.

O retention está em `trim`: diários por 3 dias, depois 14 dias de histórico,
mínimo de 3 cópias por mundo.

## Versão do servidor

`VERSION` no `docker-compose.yml` está fixada. O Bedrock exige o mesmo protocolo
entre cliente e servidor: se o app do celular atualizar, suba esse número junto.

## playit.gg

`PLAYIT_SECRET_KEY` vem do `.env` (veja `.env.example`).

### "Não conecta de fora" é quase sempre o relógio

O protocolo de controle do playit valida timestamps e degrada acima de **10
segundos** de desvio. Com o relógio do Windows atrasado, o túnel entra em laço
de reconexão: a LAN continua funcionando, mas quem está fora de casa recebe
erro de `initialconnection` no cliente Bedrock. Já aconteceu duas vezes
(16,8 s em 01/09/2026, 28,0 s em 17/09/2026).

Diagnóstico, nesta ordem:

```powershell
docker compose logs --tail 20 playit    # procure "local timestamp if over 10 seconds off"
w32tm /stripchart /computer:time.windows.com /samples:3 /dataonly
```

Conserto, num PowerShell **como Administrador** (sem elevação o `w32tm` devolve
`Acesso negado. (0x80070005)`):

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\fix-time-sync.ps1
docker compose restart playit
```

O script faz o resync, deixa o `w32time` em automático, encurta o intervalo de
sincronização para 15 min e libera `MaxPos/NegPhaseCorrection` — sem isso o
Windows **ignora em silêncio** desvios grandes, que é o motivo de o problema
voltar.
