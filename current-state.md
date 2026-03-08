# Estado Atual do Repositório Doom-One.nvim

## Visão Geral
O Doom-One.nvim é um plugin de colorscheme para Neovim escrito em Lua, inspirado no tema Doom One do Doom Emacs. O plugin possui uma arquitetura modular com 33 arquivos .lua.

## Estrutura de Arquivos

```
Doom-One.nvim/
├── colors/
│   └── doom-one.lua              # Entry point (1 linha: require + load)
├── lua/
│   ├── doom-one/
│   │   ├── init.lua              # Módulo principal
│   │   ├── config.lua            # Configurações padrão
│   │   ├── palette.lua           # 4 variantes de cores
│   │   └── groups/
│   │       ├── init.lua          # Carregador de módulos
│   │       ├── editor.lua        # UI elements
│   │       ├── syntax.lua        # Vim syntax groups
│   │       ├── treesitter.lua     # TreeSitter highlights
│   │       ├── lsp.lua            # LSP semantic tokens
│   │       └── plugins/           # 22 integrações de plugins
│   │           ├── bufferline.lua, cmp.lua, dap.lua
│   │           ├── dashboard.lua, flash.lua, fzf.lua
│   │           ├── gitsigns.lua, headlines.lua
│   │           ├── indent-blankline.lua, lualine.lua
│   │           ├── markview.lua, neotree.lua, noice.lua
│   │           ├── notify.lua, nvimtree.lua, oil.lua
│   │           ├── render-markdown.lua, telescope.lua
│   │           ├── todo-comments.lua, which-key.lua, trouble.lua
│   └── lualine/
│       └── themes/
│           └── doom-one.lua      # Tema Lualine
├── README.md
├── blueprints.md
├── current-state.md
├── LICENSE
└── .gitignore
```

## Sistema de Cores e Paleta

### Paleta de Cores (palette.lua)
O plugin define **4 variantes** de cores:

| Campo | dark | darker | vibrant | light |
|-------|------|--------|---------|-------|
| bg | `#282c34` | `#1c1f24` | `#1a1b26` | `#fafafa` |
| fg | `#bbc2cf` | `#bbc2cf` | `#c0caf5` | `#383a42` |
| red | `#ff6c6b` | `#ff6c6b` | `#ff6c6b` | `#e45649` |
| orange | `#da8548` | `#da8548` | `#da8548` | `#da8548` |
| yellow | `#ecbe7b` | `#ecbe7b` | `#ecbe7b` | `#986801` |
| green | `#98be65` | `#98be65` | `#98be65` | `#50a14f` |
| blue | `#51afef` | `#51afef` | `#51afef` | `#4078f2` |
| magenta | `#c678dd` | `#c678dd` | `#c678dd` | `#a626a4` |
| cyan | `#46d9ff` | `#46d9ff` | `#46d9ff` | `#0184bc` |
| violet | `#a9a1e1` | `#a9a1e1` | `#a9a1e1` | `#b751b6` |
| **variable** | `#dcaeea` | `#dcaeea` | `#dcaeea` | `#a626a4` |

**Funções auxiliares em palette.lua**:
- `get_palette(background)` - Retorna paleta selecionada
- `blend(foreground, background, alpha)` - Mistura cores com alpha

## Componentes Principais

### 1. lua/doom-one/init.lua
- **Função**: Módulo principal
- **Funções**:
  - `setup(opts)`: Configura o plugin
  - `load()`: Carrega o colorscheme
- **Lógica**: 
  - Limpa highlights existentes
  - Define termguicolors
  - Obtém paleta base e mescla com cores customizadas
  - Obtém highlights de todos os grupos
  - Aplica highlights customizados (function ou table)
  - Aplica todos os highlights via nvim_set_hl

### 2. lua/doom-one/config.lua
- **Função**: Configurações padrão
- **Opções**:
  - `transparent`: boolean (default: false)
  - `background`: "dark" | "darker" | "vibrant" | "light" | nil
  - `colors`: table (override de cores)
  - `highlights`: table | function (override de highlights)
  - `styles`: table com estilos (italic, bold, etc.)
  - `integrations`: table com integrações de plugins

### 3. lua/doom-one/palette.lua
- **Função**: Define as paletas de cores
- **Variantes**:
  - `dark`: Tema clássico Doom One
  - `darker`: Fundo mais profundo
  - `vibrant`: Alto contraste
  - `light`: Variante clara
- **Funções auxiliares**:
  - `get_palette(background)`: Retorna paleta
  - `blend()`: Mistura cores
- **Status**: Campo `variable` (#dcaeea) já existe em todas as variantes

### 4. lua/doom-one/groups/editor.lua
- **Função**: Highlights de elementos da UI
- **Cobertura**: Normal, LineNr, CursorLineNr, Visual, Search, Pmenu, etc.
- **Status**: Já suporta `transparent` e `palette.dark_blue` para Visual

### 5. lua/doom-one/groups/syntax.lua
- **Função**: Highlights de sintaxe básica (vim)
- **Grupos**: Comment, Constant, String, Identifier, Function, Keyword, etc.
- **Status**: Aplica styles configuráveis

### 6. lua/doom-one/groups/treesitter.lua
- **Função**: Highlights do TreeSitter
- **Grupos**: @variable, @function, @type, @keyword, @markup, etc.
- **Status**: Extensivo mas com diferenças das configurações do usuário

### 7. lua/doom-one/groups/lsp.lua
- **Função**: Highlights de LSP Semantic Tokens
- **Grupos**: @lsp.type.*, @lsp.typemod.*
- **Status**: Básico, precisa de expansão

## Status das Configurações do Usuário

### ✅ Já Implementado
1. Campo `variable` (#dcaeea) na paleta - presente em todas as variantes
2. Opções de styles (comments, conditionals em itálico) - já suportado
3. Suporte a highlights function - já implementado em init.lua
4. UI Elements básicos (LineNr, CursorLineNr, Visual) - já presentes

### ⚠️ Diferenças Encontradas
1. **@variable**: Atual usa `palette.orange`, usuário quer `palette.variable`
2. **@variable.member**: Atual usa `palette.fg`, usuário quer `palette.cyan`
3. **@property**: Atual usa `palette.fg`, usuário quer `palette.cyan`
4. **@function.method**: Atual usa `palette.magenta`, usuário quer `palette.cyan`
5. **@constructor**: Atual usa `palette.blue`, usuário quer `palette.yellow`
6. **Boolean**: Atual usa `palette.orange`, usuário quer `palette.violet`
7. **Grupos LSP**: Muitos ausentes ou não configurados conforme desejado
8. **@markup.heading**: Atual usa `palette.blue`, usuário quer `palette.red`
9. **@markup.raw**: Atual usa `palette.teal`, usuário quer `bg = palette.base3`

## Fluxo de Execução (Carregamento do Tema)

```
┌─────────────────────────────────────────────────────────────┐
│ 1. colors/doom-one.lua                                      │
│    └── require("doom-one").load()                          │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│ 2. lua/doom-one/init.lua:load()                           │
│    • Limpa highlights anteriores (hi clear)                │
│    • Define termguicolors = true                          │
│    • Obtém config (transparent, background, colors, etc)  │
│    • get_palette(background) → paleta base                │
│    • Mescla com config.colors (override)                  │
│    • groups.get(palette, config)                          │
│    • Mescla com config.highlights (function ou table)     │
│    • vim.api.nvim_set_hl(0, group, spec) para cada um    │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│ 3. lua/doom-one/groups/init.lua:get()                    │
│    Carrega módulos na ordem:                              │
│    1. editor.lua   → UI elements (Normal, LineNr, etc)   │
│    2. syntax.lua   → Vim syntax (Comment, String, etc)   │
│    3. treesitter.lua → TreeSitter (@variable, @function) │
│    4. lsp.lua      → LSP semantic tokens                 │
│    5. plugins/*    → 22 integrações (se enabled)          │
└─────────────────────────────────────────────────────────────┘
```

## Sistema de Configuração (config.lua)

```lua
require("doom-one").setup({
  transparent = false,      -- Fundo transparente
  background = "dark",      -- dark/darker/vibrant/light
  colors = {},              -- Override de cores da paleta
  highlights = {},          -- Override de highlights
  styles = {                -- Estilos (italic, bold, etc)
    comments = { italic = true },
    conditionals = { italic = true },
    -- ... outros
  },
  integrations = {
    all = true,             -- Habilita todas as integrações
    -- ou individual: telescope = true, neotree = true, etc
  }
})
```

## Arquitetura de Highlights

Cada arquivo de grupo segue o mesmo padrão:

```lua
local M = {}

function M.get(palette, config)
  return {
    -- Tabela de highlights no formato vim.api.nvim_set_hl
    GroupName = { fg = palette.color, bg = ..., bold = true },
  }
end

return M
```

**Grupos de Highlights**:
- **editor.lua**: UI elements (CursorLine, Visual, Search, Pmenu, StatusLine, etc)
- **syntax.lua**: Vim syntax groups (Comment, String, Keyword, Type, etc)
- **treesitter.lua**: TreeSitter captures (@variable, @function, @type, @markup, etc)
- **lsp.lua**: LSP semantic tokens (@lsp.type.*, @lsp.typemod.*)
- **plugins/**: Integrações específicas (telescope, cmp, gitsigns, etc)

## Observações

- O sistema já suporta extensão via `highlights` function no setup
- Os grupos LSP precisam ser mais abrangentes
- TreeSitter tem algumas diferenças de cores das preferências do usuário
- A estrutura modular permite fácil extensão
- O plugin possui **4 variantes** de tema (dark, darker, vibrant, light) compartilhadas automaticamente
- **NENHUM TESTE existente** no repositório atualmente
- A paleta `variable` (#dcaeea em dark/darker/vibrant) já existe
- O sistema de styles é configurável (italic, bold, etc)
