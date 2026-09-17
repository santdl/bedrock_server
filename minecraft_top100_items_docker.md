# Guia de Itens e Comandos Minecraft Bedrock (Docker BDS)

Este documento contém os comandos em Docker para disponibilizar os 100 itens mais úteis, divididos por categoria, diretamente para todos os jogadores no servidor Bedrock.

---

## 🛠️ Como Executar os Comandos
Todos os comandos utilizam a estrutura `send-command` compatível com o container Docker (`mc-bedrock`):

```bash
docker exec -i mc-bedrock send-command "give @a <item_id> <quantidade> [data_value]"
```

Usuarios Joaquim191065 | Miguel174454 

---

## 1. Equipamentos e Combate (1–15)
| # | Item | Comando Docker |
|---|---|---|
| 1 | Élitro (Asas) | `docker exec -i mc-bedrock send-command "give @a elytra 1"` |
| 2 | Foguetes de Impulso (64x) | `docker exec -i mc-bedrock send-command "give @a firework_rocket 64"` |
| 3 | Tótem da Imortalidade | `docker exec -i mc-bedrock send-command "give @a totem_of_undying 1"` |
| 4 | Capacete de Netherita | `docker exec -i mc-bedrock send-command "give @a netherite_helmet 1"` |
| 5 | Peitoral de Netherita | `docker exec -i mc-bedrock send-command "give @a netherite_chestplate 1"` |
| 6 | Calça de Netherita | `docker exec -i mc-bedrock send-command "give @a netherite_leggings 1"` |
| 7 | Botas de Netherita | `docker exec -i mc-bedrock send-command "give @a netherite_boots 1"` |
| 8 | Espada de Netherita | `docker exec -i mc-bedrock send-command "give @a netherite_sword 1"` |
| 9 | Picareta de Netherita | `docker exec -i mc-bedrock send-command "give @a netherite_pickaxe 1"` |
| 10 | Machado de Netherita | `docker exec -i mc-bedrock send-command "give @a netherite_axe 1"` |
| 11 | Pá de Netherita | `docker exec -i mc-bedrock send-command "give @a netherite_shovel 1"` |
| 12 | Tridente | `docker exec -i mc-bedrock send-command "give @a trident 1"` |
| 13 | Arco | `docker exec -i mc-bedrock send-command "give @a bow 1"` |
| 14 | Ballesta / Besta | `docker exec -i mc-bedrock send-command "give @a crossbow 1"` |
| 15 | Escudo | `docker exec -i mc-bedrock send-command "give @a shield 1"` |

---

## 2. Utilidades, Mochilas e Armazenamento (16–30)
| # | Item | Comando Docker |
|---|---|---|
| 16 | Caixa de Shulker Padrão | `docker exec -i mc-bedrock send-command "give @a shulker_box 1"` |
| 17 | Caixa de Shulker Azul | `docker exec -i mc-bedrock send-command "give @a blue_shulker_box 1"` |
| 18 | Caixa de Shulker Vermelha | `docker exec -i mc-bedrock send-command "give @a red_shulker_box 1"` |
| 19 | Baú do Fim (Ender Chest) | `docker exec -i mc-bedrock send-command "give @a ender_chest 1"` |
| 20 | Baú Padrão (64x) | `docker exec -i mc-bedrock send-command "give @a chest 64"` |
| 21 | Pérola do End (16x) | `docker exec -i mc-bedrock send-command "give @a ender_pearl 16"` |
| 22 | Olho do End (16x) | `docker exec -i mc-bedrock send-command "give @a eye_of_ender 16"` |
| 23 | Luneta (Spyglass) | `docker exec -i mc-bedrock send-command "give @a spyglass 1"` |
| 24 | Relógio | `docker exec -i mc-bedrock send-command "give @a clock 1"` |
| 25 | Bússola | `docker exec -i mc-bedrock send-command "give @a compass 1"` |
| 26 | Bússola de Recuperação | `docker exec -i mc-bedrock send-command "give @a recovery_compass 1"` |
| 27 | Laço (16x) | `docker exec -i mc-bedrock send-command "give @a lead 16"` |
| 28 | Etiqueta (64x) | `docker exec -i mc-bedrock send-command "give @a name_tag 64"` |
| 29 | Tesoura | `docker exec -i mc-bedrock send-command "give @a shears 1"` |
| 30 | Isqueiro | `docker exec -i mc-bedrock send-command "give @a flint_and_steel 1"` |

---

## 3. Comida e Efeitos Especiais (31–40)
| # | Item | Comando Docker |
|---|---|---|
| 31 | Maçã Dourada Encantada (64x) | `docker exec -i mc-bedrock send-command "give @a enchanted_golden_apple 64"` |
| 32 | Maçã Dourada Comum (64x) | `docker exec -i mc-bedrock send-command "give @a golden_apple 64"` |
| 33 | Cenoura Dourada (64x) | `docker exec -i mc-bedrock send-command "give @a golden_carrot 64"` |
| 34 | Bife Assado (64x) | `docker exec -i mc-bedrock send-command "give @a cooked_beef 64"` |
| 35 | Costela de Porco Assada (64x) | `docker exec -i mc-bedrock send-command "give @a cooked_porkchop 64"` |
| 36 | Frango Assado (64x) | `docker exec -i mc-bedrock send-command "give @a cooked_chicken 64"` |
| 37 | Fruta do Coro (64x) | `docker exec -i mc-bedrock send-command "give @a chorus_fruit 64"` |
| 38 | Frasco de Experiência (64x) | `docker exec -i mc-bedrock send-command "give @a experience_bottle 64"` |
| 39 | Garrafa de Mel (16x) | `docker exec -i mc-bedrock send-command "give @a honey_bottle 16"` |
| 40 | Balde de Leite | `docker exec -i mc-bedrock send-command "give @a milk_bucket 1"` |

---

## 4. Blocos Especiais e Utilitários (41–55)
| # | Item | Comando Docker |
|---|---|---|
| 41 | Bloco de Comandos | `docker exec -i mc-bedrock send-command "give @a command_block 1"` |
| 42 | Farol (Beacon) | `docker exec -i mc-bedrock send-command "give @a beacon 1"` |
| 43 | Suporte de Armaduras (16x) | `docker exec -i mc-bedrock send-command "give @a armor_stand 16"` |
| 44 | Moldura Brilhante (64x) | `docker exec -i mc-bedrock send-command "give @a glow_item_frame 64"` |
| 45 | Bigorna (Anvil) | `docker exec -i mc-bedrock send-command "give @a anvil 1"` |
| 46 | Bancada de Trabalho | `docker exec -i mc-bedrock send-command "give @a crafting_table 1"` |
| 47 | Fornalha Potente | `docker exec -i mc-bedrock send-command "give @a blast_furnace 1"` |
| 48 | Defumador (Smoker) | `docker exec -i mc-bedrock send-command "give @a smoker 1"` |
| 49 | Cortador de Pedra | `docker exec -i mc-bedrock send-command "give @a stonecutter 1"` |
| 50 | Barril (64x) | `docker exec -i mc-bedrock send-command "give @a barrel 64"` |
| 51 | Esponja Molhada (64x) | `docker exec -i mc-bedrock send-command "give @a sponge 64 1"` |
| 52 | Esponja Seca (64x) | `docker exec -i mc-bedrock send-command "give @a sponge 64"` |
| 53 | Cama Vermelha | `docker exec -i mc-bedrock send-command "give @a bed 1 14"` |
| 54 | Suporte de Poções | `docker exec -i mc-bedrock send-command "give @a brewing_stand 1"` |
| 55 | Caldeirão | `docker exec -i mc-bedrock send-command "give @a cauldron 1"` |

---

## 5. Redstone e Circuitos (56–70)
| # | Item | Comando Docker |
|---|---|---|
| 56 | Pó de Redstone (64x) | `docker exec -i mc-bedrock send-command "give @a redstone 64"` |
| 57 | Bloco de Redstone (64x) | `docker exec -i mc-bedrock send-command "give @a redstone_block 64"` |
| 58 | Tocha de Redstone (64x) | `docker exec -i mc-bedrock send-command "give @a redstone_torch 64"` |
| 59 | Repetidor de Redstone (64x) | `docker exec -i mc-bedrock send-command "give @a repeater 64"` |
| 60 | Comparador de Redstone (64x) | `docker exec -i mc-bedrock send-command "give @a comparator 64"` |
| 61 | Funil (Hopper) (64x) | `docker exec -i mc-bedrock send-command "give @a hopper 64"` |
| 62 | Pistão Grudento (64x) | `docker exec -i mc-bedrock send-command "give @a sticky_piston 64"` |
| 63 | Pistão Comum (64x) | `docker exec -i mc-bedrock send-command "give @a piston 64"` |
| 64 | Observador (64x) | `docker exec -i mc-bedrock send-command "give @a observer 64"` |
| 65 | Ejetor (Dispenser) (64x) | `docker exec -i mc-bedrock send-command "give @a dispenser 64"` |
| 66 | Liberador (Dropper) (64x) | `docker exec -i mc-bedrock send-command "give @a dropper 64"` |
| 67 | Alavanca (64x) | `docker exec -i mc-bedrock send-command "give @a lever 64"` |
| 68 | Lâmpada de Redstone (64x) | `docker exec -i mc-bedrock send-command "give @a redstone_lamp 64"` |
| 69 | Bloco de Slime (64x) | `docker exec -i mc-bedrock send-command "give @a slime 64"` |
| 70 | Bloco de Mel (64x) | `docker exec -i mc-bedrock send-command "give @a honey_block 64"` |

---

## 6. Minérios e Blocos Valiosos (71–85)
| # | Item | Comando Docker |
|---|---|---|
| 71 | Bloco de Netherita (64x) | `docker exec -i mc-bedrock send-command "give @a netherite_block 64"` |
| 72 | Lingote de Netherita (64x) | `docker exec -i mc-bedrock send-command "give @a netherite_ingot 64"` |
| 73 | Bloco de Diamante (64x) | `docker exec -i mc-bedrock send-command "give @a diamond_block 64"` |
| 74 | Diamante (64x) | `docker exec -i mc-bedrock send-command "give @a diamond 64"` |
| 75 | Bloco de Ouro (64x) | `docker exec -i mc-bedrock send-command "give @a gold_block 64"` |
| 76 | Bloco de Ferro (64x) | `docker exec -i mc-bedrock send-command "give @a iron_block 64"` |
| 77 | Bloco de Esmeralda (64x) | `docker exec -i mc-bedrock send-command "give @a emerald_block 64"` |
| 78 | Bloco de Carvão (64x) | `docker exec -i mc-bedrock send-command "give @a coal_block 64"` |
| 79 | Bloco de Lápis-Lazúli (64x) | `docker exec -i mc-bedrock send-command "give @a lapis_block 64"` |
| 80 | Bloco de Quartzo (64x) | `docker exec -i mc-bedrock send-command "give @a quartz_block 64"` |
| 81 | Obsidiana (64x) | `docker exec -i mc-bedrock send-command "give @a obsidian 64"` |
| 82 | Obsidiana Chorosa (64x) | `docker exec -i mc-bedrock send-command "give @a crying_obsidian 64"` |
| 83 | Âncora de Renascimento | `docker exec -i mc-bedrock send-command "give @a respawn_anchor 1"` |
| 84 | Fragmento de Ametista (64x) | `docker exec -i mc-bedrock send-command "give @a amethyst_shard 64"` |
| 85 | Cobre Encerado (64x) | `docker exec -i mc-bedrock send-command "give @a waxed_copper 64"` |

---

## 7. Blocos de Construção e Transporte (86–100)
| # | Item | Comando Docker |
|---|---|---|
| 86 | Tábuas de Carvalho (64x) | `docker exec -i mc-bedrock send-command "give @a planks 64 0"` |
| 87 | Vidro Transparente (64x) | `docker exec -i mc-bedrock send-command "give @a glass 64"` |
| 88 | Pedra Polida (64x) | `docker exec -i mc-bedrock send-command "give @a smooth_stone 64"` |
| 89 | Tijolos de Pedra (64x) | `docker exec -i mc-bedrock send-command "give @a stonebrick 64"` |
| 90 | Pedregulho (64x) | `docker exec -i mc-bedrock send-command "give @a cobblestone 64"` |
| 91 | Tocha (64x) | `docker exec -i mc-bedrock send-command "give @a torch 64"` |
| 92 | Lanterna (64x) | `docker exec -i mc-bedrock send-command "give @a lantern 64"` |
| 93 | Lanterna das Almas (64x) | `docker exec -i mc-bedrock send-command "give @a soul_lantern 64"` |
| 94 | Trilho Elétrico (64x) | `docker exec -i mc-bedrock send-command "give @a golden_rail 64"` |
| 95 | Trilho Comum (64x) | `docker exec -i mc-bedrock send-command "give @a rail 64"` |
| 96 | Carrinho de Mina | `docker exec -i mc-bedrock send-command "give @a minecart 1"` |
| 97 | Barco de Carvalho | `docker exec -i mc-bedrock send-command "give @a oak_boat 1"` |
| 98 | Sela | `docker exec -i mc-bedrock send-command "give @a saddle 1"` |
| 99 | Armadura de Diamante p/ Cavalo | `docker exec -i mc-bedrock send-command "give @a diamond_horse_armor 1"` |
| 100 | TNT (64x) | `docker exec -i mc-bedrock send-command "give @a tnt 64"` |

---

## ⚡ Comandos Úteis de Administração
* **Dar OP a um jogador:**
  ```bash
  docker exec -i mc-bedrock send-command "op \"NomeDoJogador\""
  ```
* **Manter inventário ao morrer:**
  ```bash
  docker exec -i mc-bedrock send-command "gamerule keepinventory true"
  ```
* **Definir tempo para Dia:**
  ```bash
  docker exec -i mc-bedrock send-command "time set day"
  ```
* **Limpar Clima (Sem Chuva):**
  ```bash
  docker exec -i mc-bedrock send-command "weather clear"
  ```
