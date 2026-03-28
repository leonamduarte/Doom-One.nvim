<div align="center">
  <img src="https://raw.githubusercontent.com/paesmont/Doom-One.nvim/main/assets/logo.png" alt="Doom One" width="200" />
  <h1>Doom-One.nvim</h1>
  <p>
    Um port fiel e vibrante do tema <b>Doom One</b> do Doom Emacs para o Neovim.
  </p>

  <p>
    <a href="https://github.com/paesmont/Doom-One.nvim/stargazers"><img src="https://img.shields.io/github/stars/paesmont/Doom-One.nvim?style=for-the-badge&logo=github&color=51afef&logoColor=282c34" alt="Stars" /></a>
    <a href="https://github.com/paesmont/Doom-One.nvim/blob/main/LICENSE"><img src="https://img.shields.io/github/license/paesmont/Doom-One.nvim?style=for-the-badge&logo=opensourceinitiative&color=98be65&logoColor=282c34" alt="License" /></a>
  </p>
</div>

---

## 📸 Screenshots

*Em breve...*

## ✨ Características

- 🎨 **4 Variantes**: Dark, Darker, Vibrant e Light.
- 🚀 **Performance**: Escrito inteiramente em Lua, otimizado para o Neovim moderno.
- 🛠️ **Modular**: Estrutura organizada e fácil de estender.
- 🔌 **Integrações**: Suporte nativo para os plugins mais populares (LazyVim compatível).
- ⚙️ **Customizável**: Ajuste estilos de fontes (itálico/negrito) e cores facilmente.

## 🌈 Sabores

| Variante | Descrição |
| --- | --- |
| `dark` | O clássico Doom One (padrão). |
| `darker` | Uma versão com fundo mais profundo e escuro. |
| `vibrant` | Alto contraste inspirado no TokyoNight, mantendo a alma do Doom One. |
| `light` | Uma variante clara elegante e legível. |

## 📦 Instalação

### [lazy.nvim](https://github.com/folke/lazy.nvim) (Recomendado)

```lua
-- No seu arquivo de plugins (ex: lua/plugins.lua ou lazy-lock.json)
return {
  {
    "paesmont/Doom-One.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      -- Configurações aqui (veja seção "Configuração" abaixo)
    },
    config = function(_, opts)
      require("doom-one").setup(opts)
      vim.cmd.colorscheme("doom-one")
    end,
  },
}
```

### [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use({
  "paesmont/Doom-One.nvim",
  config = function()
    require("doom-one").setup()
    vim.cmd.colorscheme("doom-one")
  end
})
```

### [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'paesmont/Doom-One.nvim'

" No seu init.lua ou init.vim
lua << EOF
require("doom-one").setup()
vim.cmd.colorscheme("doom-one")
EOF
```

## ⚙️ Configuração

O `setup` é opcional. Se você não chamar, o tema usará os padrões abaixo:

```lua
require("doom-one").setup({
  transparent = false, -- desabilita o fundo para transparência do terminal
  background = "dark", -- "dark", "darker", "vibrant", "light"
  colors = {}, -- sobrescreve cores da paleta
  highlights = {}, -- sobrescreve grupos de destaque
  styles = {
    comments = { italic = true },
    conditionals = { italic = true },
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
  },
  integrations = {
    all = true, -- habilita todas as integrações
    -- ou habilite individualmente:
    -- telescope = true,
    -- neotree = true,
    -- ...
  },
})
```

### Opções Completas de Configuração

#### `transparent` (boolean)
- **Padrão**: `false`
- **Descrição**: Ativa o fundo transparente do terminal
- **Valores**: `true` | `false`

#### `background` (string)
- **Padrão**: `"dark"`
- **Descrição**: Define a variante do tema
- **Valores**: `"dark"` | `"darker"` | `"vibrant"` | `"light"`

#### `colors` (table)
- **Padrão**: `{}`
- **Descrição**: Sobrescreve cores da paleta. Útil para personalização.

**Cores disponíveis na paleta:**

| Cor | Descrição | Padrão (dark) |
|-----|-----------|---------------|
| `bg` | Fundo principal | `#282c34` |
| `fg` | Texto principal | `#bbc2cf` |
| `bg_alt` | Fundo alternativo | `#21242b` |
| `fg_alt` | Texto alternativo | `#5b6268` |
| `base0` - `base8` | Cores base (0-8) | varies |
| `grey` | Cinza | `#3f444a` |
| `red` | Vermelho | `#ff6c6b` |
| `orange` | Laranja | `#da8548` |
| `green` | Verde | `#98be65` |
| `teal` | Verde-azulado | `#4db5bd` |
| `yellow` | Amarelo | `#ecbe7b` |
| `blue` | Azul | `#51afef` |
| `dark_blue` | Azul escuro | `#2257a0` |
| `magenta` | Magenta | `#c678dd` |
| `violet` | Violeta | `#a9a1e1` |
| `cyan` | Ciano | `#46d9ff` |
| `dark_cyan` | Ciano escuro | `#5699af` |
| `variable` | Variável | `#dcaeea` |

**Exemplo de override de cores:**
```lua
colors = {
  red = "#ff0000",
  blue = "#0000ff",
  bg = "#1a1b26", -- Override fundo com variante vibrant
}
```

#### `highlights` (table | function)
- **Padrão**: `{}`
- **Descrição**: Sobrescreve grupos de destaque específicos

**Exemplo com tabela:**
```lua
highlights = {
  Comment = { fg = "#5B6268", italic = true },
  Function = { fg = "#c678dd" },
}
```

**Exemplo com função (recebe paleta como parâmetro):**
```lua
highlights = function(palette)
  return {
    Comment = { fg = palette.base5 },
    Function = { fg = palette.magenta },
    ["@variable"] = { fg = palette.variable },
  }
end
```

#### `styles` (table)
- **Padrão**: Ver abaixo
- **Descrição**: Aplica estilos (italic, bold, etc) aos grupos de syntax

```lua
styles = {
  comments = { italic = true },    -- Comment
  conditionals = { italic = true }, -- Conditional
  loops = {},                        -- Loop
  functions = {},                    -- Function
  keywords = {},                     -- Keyword
  strings = {},                      -- String
  variables = {},                    -- Identifier, @variable
  numbers = {},                      -- Number, Float
  booleans = {},                     -- Boolean
  properties = {},                   -- Property, @property
  types = {},                        -- Type, @type
  operators = {},                    -- Operator
}
```

**Exemplo de uso:**
```lua
styles = {
  comments = { italic = true, bold = true },
  functions = { bold = true },
  keywords = { italic = true },
}
```

#### `integrations` (table)
- **Padrão**: `{ all = true }`
- **Descrição**: Habilita integrações com plugins externos

**Integrações disponíveis:**

| Integração | Descrição |
|------------|-----------|
| `telescope` | Telescope.nvim |
| `nvimtree` | NvimTree.lua |
| `neotree` | Neo-tree.nvim |
| `lualine` | Lualine.nvim |
| `bufferline` | Bufferline.nvim |
| `noice` | Noice.nvim |
| `trouble` | Trouble.nvim |
| `whichkey` | Which-Key.nvim |
| `gitsigns` | Gitsigns.nvim |
| `indentblankline` | Indent-Blankline.nvim |
| `dashboard` | Dashboard.nvim |
| `notify` | Nvim-notify |
| `flash` | Flash.nvim |
| `cmp` | nvim-cmp |
| `dap` | nvim-dap |
| `fzf` | fzf |
| `headlines` | Headlines.nvim |
| `markview` | MarkView.nvim |
| `oil` | Oil.nvim |
| `rendermarkdown` | render-markdown.nvim |
| `todocomments` | Todo-comments.nvim |
| `all` | Habilita todas as integrações |

**Exemplo de uso:**
```lua
-- Habilitar todas (padrão)
integrations = {
  all = true,
}

-- Ou habilitar individualmente
integrations = {
  telescope = true,
  lualine = true,
  gitsigns = true,
  cmp = true,
}
```

## 🔌 Integrações

Doom-One suporta nativamente uma vasta gama de plugins, incluindo:

- [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- [Nvim-Tree](https://github.com/nvim-tree/nvim-tree.lua)
- [Neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim)
- [Lualine](https://github.com/nvim-lualine/lualine.nvim)
- [Bufferline](https://github.com/akinsho/bufferline.nvim)
- [Noice](https://github.com/folke/noice.nvim)
- [Trouble](https://github.com/folke/trouble.nvim)
- [Which-Key](https://github.com/folke/which-key.nvim)
- [Gitsigns](https://github.com/lewis6991/gitsigns.nvim)
- [Indent-blankline](https://github.com/lukas-reineke/indent-blankline.nvim)
- [Dashboard-nvim](https://github.com/nvimdev/dashboard-nvim)
- [Nvim-notify](https://github.com/rcarriga/nvim-notify)
- [Flash.nvim](https://github.com/folke/flash.nvim)
- [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- E muitos outros!

### Lualine

Para usar o tema no Lualine:

```lua
require('lualine').setup {
  options = {
    theme = 'doom-one', -- Ele detecta automaticamente se você estiver usando o colorscheme
  }
}
```

---

<div align="center">
  Feito com ❤️ inspirado pelo Doom Emacs e Catppuccin.
</div>
