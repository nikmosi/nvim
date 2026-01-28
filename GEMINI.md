# Neovim Configuration

This is a personal Neovim configuration written in Lua, managed by `lazy.nvim`, and wrapped in a Nix flake for reproducible development environments.

## Project Structure

*   **`init.lua`**: The entry point for Neovim. It sets up basic options, globals, and bootstraps the plugin manager.
*   **`lua/config/`**: Contains core configuration modules:
    *   `lazy.lua`: Bootstraps and configures `lazy.nvim`.
    *   `opt.lua`: Sets vim options (`vim.opt`).
    *   `remap.lua`: Defines global keymaps.
    *   `diagnostic.lua`: Configures diagnostic display settings.
*   **`lua/plugins/`**: Contains individual plugin specifications. Each file returns a table (or list of tables) describing a plugin and its configuration.
*   **`lsp/`**: Contains server-specific configurations for the Language Server Protocol (LSP). These are loaded dynamically by `lua/plugins/lsp.lua`.
*   **`flake.nix`**: Defines a Nix development shell with pre-commit hooks and tools like `stylua`.

## Key Technologies

*   **Plugin Manager**: [lazy.nvim](https://github.com/folke/lazy.nvim)
*   **LSP Client**: Native Neovim LSP with `nvim-lspconfig`.
*   **Completion**: `blink.cmp` (High-performance completion engine).
*   **Formatting**: Likely `conform.nvim` (implied by file list).
*   **Theme**: `tokyonight-night`.

## Usage

### Running Neovim
Simply run `nvim` in your terminal. On the first run, `lazy.nvim` will automatically install itself and all configured plugins.

### Development Environment (Nix)
This project uses Nix to provide a consistent development environment with linting and formatting tools.

```bash
nix develop
```

This will enter a shell (configured to use `nu` shell in `flake.nix`) with the following tools available:
*   `stylua`: Lua formatter.
*   `convco`: Conventional commits checker.
*   `trufflehog`: Secret scanner.
*   Pre-commit hooks for trailing whitespace, huge files, etc.

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
LSP servers are defined in `lua/plugins/lsp.lua` in the `opts.servers` table.
To add a new server:
1.  Add the server name to `opts.servers` in `lua/plugins/lsp.lua`.
2.  (Optional) Create a specific config file in `lsp/<server_name>.lua` if you need custom settings (passed to `setup()`).

### Keymaps
*   **Global mappings**: Defined in `lua/config/remap.lua`.
*   **LSP mappings**: Defined in `lua/plugins/lsp.lua` (within the `LspAttach` autocommand).
*   **Plugin mappings**: Defined within the `keys` table of the respective plugin spec in `lua/plugins/`.

## Conventions

*   **Formatting**: Lua code is formatted using `stylua`.
*   **Commits**: Follow Conventional Commits.
*   **LSP Settings**: Keep server-specific logic in `lsp/` to keep the main LSP plugin file clean.
