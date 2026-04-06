# Blueprint - Plano de Implementação

## Estrutura Atual do Projeto

```
Doom-One.nvim/
├── .editorconfig                    # Editor configuration
├── .github/
│   └── workflows/
│       └── ci.yml                   # GitHub Actions CI (lint + format + smoke test)
├── .luacheckrc                      # Luacheck linting config
├── stylua.toml                      # StyLua formatting config
├── .opencode/
│   └── opencode.json                # Configuração MCP para OpenCode
├── colors/
│   └── doom-one.lua                 # Entry point do colorscheme
├── lua/
│   ├── doom-one/
│   │   ├── init.lua                 # Módulo principal (setup + load)
│   │   ├── config.lua               # Configurações padrão
│   │   ├── palette.lua              # Paletas de cores (4 variantes)
│   │   └── groups/
│   │       ├── init.lua             # Loader de módulos
│   │       ├── editor.lua           # Highlights de UI
│   │       ├── syntax.lua           # Highlights de syntax Vim
│   │       ├── treesitter.lua       # Capturas TreeSitter
│   │       ├── lsp.lua              # Tokens semânticos LSP
│   │       └── plugins/             # 21 integrações de plugins
│   │           ├── bufferline.lua
│   │           ├── cmp.lua
│   │           ├── dap.lua
│   │           ├── dashboard.lua
│   │           ├── flash.lua
│   │           ├── fzf.lua
│   │           ├── gitsigns.lua
│   │           ├── headlines.lua
│   │           ├── indent-blankline.lua
│   │           ├── lualine.lua
│   │           ├── markview.lua
│   │           ├── neotree.lua
│   │           ├── noice.lua
│   │           ├── notify.lua
│   │           ├── nvimtree.lua
│   │           ├── oil.lua
│   │           ├── render-markdown.lua
│   │           ├── telescope.lua
│   │           ├── todo-comments.lua
│   │           ├── trouble.lua
│   │           └── which-key.lua
│   └── lualine/
│       └── themes/
│           └── doom-one.lua         # Tema standalone para lualine
├── memory/                          # Arquivos de memória OpenCode
│   ├── repo_summary.md
│   ├── architecture.md
│   └── recent_changes.md
├── test/
│   └── smoke_test.lua               # Smoke tests para validação
├── blueprints.md                    # Este arquivo
├── CHANGELOG.md                     # Histórico de mudanças
├── CONTRIBUTING.md                  # Guia de contribuição
└── README.md                        # Documentação principal
```

### Invariantes Arquiteturais

1. **Entry point minimalista**: `colors/doom-one.lua` deve ser uma única linha
2. **Ordem de carregamento**: editor → syntax → treesitter → lsp → plugins
3. **Contrato de módulo**: Todo módulo em `groups/` exporta `M.get(palette, config)`
4. **Palette immutability**: Usar deep merge para overrides, nunca modificar paletas base
5. **Safe plugin loading**: Plugins carregados com `pcall` + `vim.notify` para graceful degradation
6. **Override precedence**: User highlights sempre sobrescrevem defaults
7. **Performance**: Cache de `require()` e `blend()` para evitar chamadas redundantes

---

## Objetivo

Implementar as alterações solicitadas pelo usuário para alinhar o plugin Doom-One.nvim com a configuração fornecida.

## Visão Geral da Arquitetura

O Doom-One.nvim possui uma arquitetura modular com:
- **4 variantes de tema**: dark, darker, vibrant, light
- **Sistema de cores**: Paleta com 18 cores (bg, fg, bg_alt, fg_alt, base0-8, grey, red, orange, yellow, green, teal, blue, dark_blue, magenta, cyan, dark_cyan, violet, variable)
- **Highlighting**: Sistema em camadas (editor → syntax → treesitter → lsp → plugins)
- **Total de arquivos**: 31 arquivos .lua

### Fluxo de Carregamento
```
colors/doom-one.lua → init.lua:load() → groups/init.lua:get()
→ editor.lua → syntax.lua → treesitter.lua → lsp.lua → plugins/
```

## Análise das Alterações do Usuário

A configuração do usuário inclui:
1. Paleta de cores exata baseada no doom-one-theme.el do Emacs
2. Syntax highlighting abrangente (UI Elements, Syntax Core, TreeSitter, LSP, Markdown)
3. Novo campo `variable` na paleta de cores
4. Configurações de styles com comentários e conditionals em itálico

---

## Plano de Modificações

### 1. ✅ COMPLETO - Campo `variable` na Paleta
**Arquivo**: `lua/doom-one/palette.lua`  
**Status**: Implementado em todas as variantes (dark, darker, vibrant, light)

### 2. ✅ COMPLETO - lua/doom-one/groups/syntax.lua

#### Alterações Aplicadas:

```lua
Boolean = vim.tbl_extend("force", { fg = palette.violet }, styles.booleans or {}),
Identifier = vim.tbl_extend("force", { fg = palette.variable }, styles.variables or {}),
```

### 3. ✅ COMPLETO - lua/doom-one/groups/treesitter.lua

#### Alterações Aplicadas:

```lua
["@variable"] = vim.tbl_extend("force", { fg = palette.variable }, styles.variables or {}),
["@variable.member"] = vim.tbl_extend("force", { fg = palette.cyan }, styles.properties or {}),
["@property"] = vim.tbl_extend("force", { fg = palette.cyan }, styles.properties or {}),
["@function.method"] = { fg = palette.cyan },
["@constructor"] = { fg = palette.yellow },
["@markup.heading"] = { fg = palette.red, bold = true },
["@markup.raw"] = { bg = palette.base3 },
```

### 4. ✅ COMPLETO - lua/doom-one/groups/lsp.lua

#### Alterações Aplicadas:

```lua
["@lsp.type.variable"] = { fg = palette.variable },
["@lsp.type.parameter"] = { fg = palette.orange },
["@lsp.type.property"] = { fg = palette.cyan },
["@lsp.type.function"] = { fg = palette.magenta },
["@lsp.type.method"] = { fg = palette.cyan },
["@lsp.type.type"] = { fg = palette.yellow },
["@lsp.typemod.variable.defaultLibrary"] = { fg = palette.magenta },
["@lsp.typemod.variable.readonly"] = { fg = palette.violet },
```

### 5. ✅ COMPLETO - Configurações de Styles
**Arquivo**: `lua/doom-one/config.lua`  
**Status**: Suporta styles comentários e conditionals em itálico

### 6. ✅ COMPLETO - Melhorias de Qualidade

- **Error observability**: `vim.notify()` em falhas de integração
- **Performance**: Cache de `blend()` e `require()` em variáveis locais
- **CI/CD**: GitHub Actions com luacheck, stylua, e smoke tests
- **Linting**: `.luacheckrc` configurado
- **Formatting**: `stylua.toml` configurado
- **Editor config**: `.editorconfig` para consistência
- **Testes**: `test/smoke_test.lua` com 12 cenários
- **Docs**: `CHANGELOG.md` e `CONTRIBUTING.md` adicionados

---

## Diferenças Resolvidas (Estado → Desejado)

| Grupo | Antes | Depois | Status |
|-------|-------|--------|--------|
| `@variable` (treesitter) | orange | variable (#dcaeea) | ✅ |
| `@variable.member` | fg | cyan | ✅ |
| `@property` | fg | cyan | ✅ |
| `@function.method` | magenta | cyan | ✅ |
| `@constructor` | blue | yellow | ✅ |
| `Boolean` | orange | violet | ✅ |
| `@markup.heading` | blue | red | ✅ |
| `@markup.raw` | teal (fg) | base3 (bg) | ✅ |
| `@lsp.type.variable` | {} | variable | ✅ |
| `@lsp.type.parameter` | link | orange | ✅ |
| `@lsp.type.property` | link | cyan | ✅ |

---

## Testes

Todos os testes sugeridos foram validados:

1. ✅ Carregamento do tema sem erros
2. ✅ Variáveis aparecem em #dcaeea (variable)
3. ✅ Propriedades/métodos em cyan
4. ✅ Construtores em yellow
5. ✅ Booleanos em violet
6. ✅ Headings markdown em red
7. ✅ Blocos de código raw com bg base3
8. ✅ Integração LSP funcionando corretamente

---

## Notas para Implementação

- ✅ Todas as cores solicitadas já existem na paleta
- ✅ O sistema de `highlights` function no setup continua funcionando como override
- ✅ As mudanças são compatíveis com o sistema de `styles` existente
- ✅ As variantes darker, vibrant e light herdarão as mudanças automaticamente
- ✅ Performance otimizada com cache de require() e blend()
- ✅ Error handling com vim.notify() para debuggability
