# Neovim Configuration

This is a personal Neovim configuration written in Lua, managed by `lazy.nvim`, and wrapped in a Nix flake for reproducible development environments.

## Project Structure

*   **`init.lua`**: The entry point for Neovim. Sets up options, globals, and bootstraps lazy.nvim.
*   **`lua/config/`**: Core configuration modules:
    *   `lazy.lua`: Bootstraps and configures `lazy.nvim`.
    *   `opt.lua`: Sets vim options (`vim.opt`).
    *   `remap.lua`: Defines global keymaps.
    *   `lsp.lua`: Dynamic LSP server loading via `vim.lsp.config`, custom LSP commands, and `LspAttach` mappings.
    *   `diagnostic.lua`: Configures diagnostic display and DAP signs.
    *   `filetypes.lua`: Custom filetype detection patterns.
    *   `yank_highlight.lua`: Yank highlight on `TextYankPost`.
    *   `snacks/`: Snacks.nvim sub-modules (dashboard, picker, scroll, indent).
    *   `lang/python_env.lua`: Python virtual environment detection.
*   **`lua/plugins/`**: Individual plugin specs — one file per plugin.
*   **`after/lsp/`**: Per-server LSP config files loaded dynamically by `lua/config/lsp.lua` via `vim.lsp.config`. Drop a `<name>.lua` file here and the server is auto-discovered.
*   **`after/syntax/`**: Vim syntax overrides (gitcommit highlighting).
*   **`queries/`**: Treesitter query overrides (markdown injection workaround).
*   **`snippets/`**: Custom VS Code-style snippets for Lua, Python, Nix, Markdown, gitcommit, YAML.
*   **`syntax/`**: Vim syntax files (gptcommit).
*   **`flake.nix`**: Nix flake with pre-commit hooks and dev shell.

## Key Technologies

*   **Plugin Manager**: [lazy.nvim](https://github.com/folke/lazy.nvim)
*   **LSP Client**: Native Neovim LSP via `vim.lsp.config` / `vim.lsp.enable` (Neovim 0.11+).
*   **Treesitter**: [arborist.nvim](https://github.com/arborist-ts/arborist.nvim) — smart parser management for Neovim 0.12+.
*   **Completion**: [blink.cmp](https://github.com/Saghen/blink.cmp) — high-performance completion engine.
*   **Statusline**: [heirline.nvim](https://github.com/rebelot/heirline.nvim) + [heirline-components.nvim](https://github.com/Zeioth/heirline-components.nvim).
*   **UI**: [snacks.nvim](https://github.com/folke/snacks.nvim) (picker, dashboard, notifier, indent, scroll, explorer, zen).
*   **Formatting**: [conform.nvim](https://github.com/stevearc/conform.nvim).
*   **Linting**: [nvim-lint](https://github.com/mfussenegger/nvim-lint).
*   **Theme**: [tokyonight-night](https://github.com/folke/tokyonight.nvim).

## Usage

### Running Neovim
Simply run `nvim`. On first run, lazy.nvim auto-installs itself and all plugins.

### Development Environment (Nix)
```bash
nix develop
```
Enters a shell with:
*   `stylua`, `convco`, `trufflehog` — formatter, commit linter, secret scanner
*   Pre-commit hooks (trailing whitespace, large files, YAML check, stylua)
*   LSP servers: `lua-language-server`, `nixd`, `pyright`, `ruff`, `yaml-language-server`, `taplo`
*   `debugpy` for Python DAP

## Configuration Details

### Adding/Modifying Plugins
1.  Create or edit a file in `lua/plugins/`.
2.  Return a Lua table following the `lazy.nvim` spec.
3.  Example:
    ```lua
    return {
      "username/repo",
      event = "VeryLazy",
      opts = { ... },
    }
    ```

### LSP Configuration
LSP servers are configured via the built-in `vim.lsp.config` API (Neovim 0.11+). Server-specific configs live in `after/lsp/<name>.lua` and are auto-loaded by `lua/config/lsp.lua`.

To add a new server:
1.  Add its name to the `servers` list in `lua/config/lsp.lua`.
2.  (Optional) Create `after/lsp/<name>.lua` returning a config table for `vim.lsp.config`.

### Keymaps
*   **Global mappings**: `lua/config/remap.lua`.
*   **LSP mappings**: `lua/config/lsp.lua` (within `LspAttach`).
*   **Plugin mappings**: In the `keys` table of the respective plugin spec.

## Conventions

*   **Formatting**: Lua formatted with `stylua` (`.stylua.toml` at root).
*   **Commits**: Conventional Commits (enforced by convco pre-commit hook).
*   **LSP Settings**: Per-server configs in `after/lsp/`, keeping main config clean.
