# Blueprint - Plano de Implementação

## Objetivo
Implementar as alterações solicitadas pelo usuário para alinhar o plugin Doom-One.nvim com a configuração fornecida.

## Visão Geral da Arquitetura

O Doom-One.nvim possui uma arquitetura modular com:
- **4 variantes de tema**: dark, darker, vibrant, light
- **Sistema de cores**: Paleta com 17+ cores (bg, fg, red, orange, yellow, green, blue, magenta, cyan, violet, variable, etc)
- **Highlighting**: Sistema em camadas (editor → syntax → treesitter → lsp → plugins)
- **Total de arquivos**: 33 arquivos .lua

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

### 1. ✅ VALIDADO - Campo `variable` na Paleta
**Arquivo**: `lua/doom-one/palette.lua`  
**Status**: Já existe em todas as variantes (dark, darker, vibrant, light)  
**Ação**: Nenhuma modificação necessária

### 2. 📝 MODIFICAR - lua/doom-one/groups/syntax.lua

#### Alterações Necessárias:

```lua
-- Linha 8: Modificar Constant para usar violet em vez de fg padrão
Constant = { fg = palette.violet },
-- (já está correto no arquivo atual)

-- Linha 12: Modificar Boolean para usar violet em vez de orange
Boolean = vim.tbl_extend("force", { fg = palette.violet }, styles.booleans or {}),
-- (ATUAL: { fg = palette.orange })

-- Linha 14: Modificar Identifier para usar variable
Identifier = vim.tbl_extend("force", { fg = palette.variable }, styles.variables or {}),
-- (ATUAL: { fg = palette.fg })
```

### 3. 📝 MODIFICAR - lua/doom-one/groups/treesitter.lua

#### Alterações Necessárias:

```lua
-- Linha 8: Modificar @variable para usar palette.variable
["@variable"] = vim.tbl_extend("force", { fg = palette.variable }, styles.variables or {}),
-- (ATUAL: { fg = palette.orange })

-- Linha 12: Modificar @variable.member para usar cyan
["@variable.member"] = vim.tbl_extend("force", { fg = palette.cyan }, styles.properties or {}),
-- (ATUAL: { fg = palette.fg })

-- Linha 13: Modificar @property para usar cyan
["@property"] = vim.tbl_extend("force", { fg = palette.cyan }, styles.properties or {}),
-- (ATUAL: { fg = palette.fg })

-- Linha 52: Modificar @function.method para usar cyan
["@function.method"] = { fg = palette.cyan },
-- (ATUAL: { fg = palette.magenta })

-- Linha 54: Modificar @constructor para usar yellow
["@constructor"] = { fg = palette.yellow },
-- (ATUAL: { fg = palette.blue })

-- Linha 103: Modificar @markup.heading para usar red
["@markup.heading"] = { fg = palette.red, bold = true },
-- (ATUAL: { fg = palette.blue, bold = true })

-- Linha 117: Modificar @markup.raw para ter bg
["@markup.raw"] = { bg = palette.base3 },
-- (ATUAL: { fg = palette.teal })
```

### 4. 📝 MODIFICAR - lua/doom-one/groups/lsp.lua

#### Adições Necessárias (após a linha 58):

```lua
    -- Grupos LSP adicionais conforme configuração do usuário
    ["@lsp.type.function"] = { fg = palette.magenta },
    ["@lsp.type.method"] = { fg = palette.cyan },
    ["@lsp.type.type"] = { fg = palette.yellow },
    ["@lsp.typemod.variable.defaultLibrary"] = { fg = palette.magenta },
    ["@lsp.typemod.variable.readonly"] = { fg = palette.violet },
```

#### Modificações Necessárias:

```lua
-- Linha 36: Modificar @lsp.type.parameter para ter fg explícito
["@lsp.type.parameter"] = { fg = palette.orange },
-- (ATUAL: { link = "@variable.parameter" })

-- Linha 37: Modificar @lsp.type.property para ter fg explícito
["@lsp.type.property"] = { fg = palette.cyan },
-- (ATUAL: { link = "@property" })

-- Linha 41: Modificar @lsp.type.variable para usar palette.variable
["@lsp.type.variable"] = { fg = palette.variable },
-- (ATUAL: {})
```

### 5. ✅ VALIDADO - Configurações de Styles
**Arquivo**: `lua/doom-one/config.lua`  
**Status**: Já suporta styles comentários e conditionals em itálico  
**Ação**: Nenhuma modificação necessária

## Diferenças Atuais (Estado → Desejado)

| Grupo | Atual | Desejado | Arquivo |
|-------|-------|----------|---------|
| `@variable` (treesitter) | orange | variable (#dcaeea) | treesitter.lua |
| `@variable.member` | fg | cyan | treesitter.lua |
| `@property` | fg | cyan | treesitter.lua |
| `@function.method` | magenta | cyan | treesitter.lua |
| `@constructor` | blue | yellow | treesitter.lua |
| `Boolean` | orange | violet | syntax.lua |
| `@markup.heading` | blue | red | treesitter.lua |
| `@markup.raw` | teal (fg) | base3 (bg) | treesitter.lua |
| `@lsp.type.variable` | {} | variable | lsp.lua |
| `@lsp.type.parameter` | link | orange | lsp.lua |
| `@lsp.type.property` | link | cyan | lsp.lua |

| Arquivo | Modificações | Prioridade |
|---------|-------------|------------|
| `lua/doom-one/groups/syntax.lua` | Boolean (orange→violet), Identifier (fg→variable) | Alta |
| `lua/doom-one/groups/treesitter.lua` | @variable, @variable.member, @property, @function.method, @constructor, @markup.heading, @markup.raw | Alta |
| `lua/doom-one/groups/lsp.lua` | Adicionar grupos @lsp.type.* e @lsp.typemod.* | Alta |

---

## Ordem de Implementação

1. **Primeiro**: `lua/doom-one/groups/syntax.lua`
   - Boolean → violet
   - Identifier → variable

2. **Segundo**: `lua/doom-one/groups/treesitter.lua`
   - @variable → variable
   - @variable.member → cyan
   - @property → cyan
   - @function.method → cyan
   - @constructor → yellow
   - @markup.heading → red
   - @markup.raw → bg base3

3. **Terceiro**: `lua/doom-one/groups/lsp.lua`
   - @lsp.type.variable → variable
   - @lsp.type.parameter → orange
   - @lsp.type.property → cyan
   - Adicionar @lsp.type.function, method, type
   - Adicionar @lsp.typemod.variable.defaultLibrary, readonly

---

## Testes Sugeridos

Após as modificações, testar:

1. Carregamento do tema sem erros
2. Variáveis aparecem em #dcaeea (variable)
3. Propriedades/métodos em cyan
4. Construtores em yellow
5. Booleanos em violet
6. Headings markdown em red
7. Blocos de código raw com bg base3
8. Integração LSP funcionando corretamente

---

## Notas para Implementação

- Todas as cores solicitadas já existem na paleta
- O sistema de `highlights` function no setup continua funcionando como override
- As mudanças são compatíveis com o sistema de `styles` existente
- As variantes darker, vibrant e light herdarão as mudanças automaticamente
