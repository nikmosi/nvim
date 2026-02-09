# Neovim Keymaps

## Global Keymaps
Defined in `lua/config/remap.lua`.

| Mode | Key | Action | Description |
| :--- | :--- | :--- | :--- |
| v | `<A-j>` | `:m '>+1<CR>gv=gv` | Move line down |
| v | `<A-k>` | `:m '<-2<CR>gv=gv` | Move line up |
| n | `<A-j>` | `V:m '>+1<CR>gv=gv<Esc>` | Move line down |
| n | `<A-k>` | `V:m '<-2<CR>gv=gv<Esc>` | Move line up |
| n | `q:` | `:q<CR>` | Quit command mode |
| n, v | `<leader>y` | `"+y` | Yank to clipboard |
| n | `<leader>Y` | `"+yy` | Yank line to clipboard |
| n, v | `<leader>p` | `"+p` | Paste from clipboard |
| x | `<leader>P` | `"_dP` | Delete to void |
| n | `<leader>W` | `:noautocmd w` | Write without formatting |
| n | `<leader>w` | `:w` | Write formatting |
| t | `<Esc>` | `<C-\><C-n>` | Terminal escape |

## LSP Keymaps
Defined in `lua/plugins/lsp.lua` (loaded on `LspAttach`).

| Mode | Key | Action | Description |
| :--- | :--- | :--- | :--- |
| n | `<leader>lsr` | `vim.cmd.LspRestart` | LSP Restart |
| n | `K` | `vim.lsp.buf.hover` | Hover |
| n | `gi` | `vim.lsp.buf.implementation` | Go to Implementation |
| n | `go` | `vim.lsp.buf.type_definition` | Go to Type Definition |
| n | `gs` | `vim.lsp.buf.signature_help` | Signature Help |
| n | `<leader>cr` | `vim.lsp.buf.rename` | Rename |
| n | `<leader>cd` | `vim.diagnostic.open_float` | Line Diagnostics |
| n, x | `<leader>cf` | `vim.lsp.buf.format` | Format Buffer |
| n | `<leader>ca` | `vim.lsp.buf.code_action` | Code Action |

## Plugin Keymaps

### Which Key
| Mode | Key | Description |
| :--- | :--- | :--- |
| n | `<leader>?` | Buffer Local Keymaps (which-key) |

### Tabline (Cokeline)
| Mode | Key | Description |
| :--- | :--- | :--- |
| n | `L` | Next buffer |
| n | `H` | Previous buffer |

### Persistence
| Mode | Key | Description |
| :--- | :--- | :--- |
| n | `<leader>qs` | Restore Session |
| n | `<leader>qS` | Select Session |
| n | `<leader>ql` | Restore Last Session |
| n | `<leader>qd` | Don't Save Current Session |

### DAP (Debug Adapter Protocol)
| Mode | Key | Description |
| :--- | :--- | :--- |
| n, v | `<leader>d` | +debug |
| n | `<leader>dB` | Breakpoint Condition |
| n | `<leader>db` | Toggle Breakpoint |
| n | `<leader>dc` | Continue |
| n | `<leader>da` | Run with Args |
| n | `<leader>dC` | Run to Cursor |
| n | `<leader>dg` | Go to Line (No Execute) |
| n | `<leader>di` | Step Into |
| n | `<leader>dj` | Down |
| n | `<leader>dk` | Up |
| n | `<leader>dl` | Run Last |
| n | `<leader>do` | Step Out |
| n | `<leader>dO` | Step Over |
| n | `<leader>dp` | Pause |
| n | `<leader>dr` | Toggle REPL |
| n | `<leader>ds` | Session |
| n | `<leader>dt` | Terminate |
| n | `<leader>dw` | Widgets |
| n | `<leader>du` | Dap UI |
| n, v | `<leader>de` | Eval |

### Refactoring
| Mode | Key | Description |
| :--- | :--- | :--- |
| n, v | `<leader>r` | +refactor |
| v | `<leader>rs` | Refactor |
| n, v | `<leader>ri` | Inline Variable |
| n | `<leader>rb` | Extract Block |
| n | `<leader>rf` | Extract Block To File |
| n | `<leader>rP` | Debug Print |
| n | `<leader>rp` | Debug Print Var |
| n | `<leader>rc` | Debug Cleanup |

### Snacks
| Mode | Key | Description |
| :--- | :--- | :--- |
| n | `<leader>e` | File Explorer |
| n | `<leader>fw` | Grep |
| n | `<leader>fb` | Buffers |
| n | `<leader>fc` | Find Config File |
| n | `<leader>ff` | Find Files |
| n | `<leader>fg` | Find Git Files |
| n | `<leader>fp` | Projects |
| n | `<leader>fr` | Recent |
| n | `<leader>gb` | Git Branches |
| n | `<leader>gl` | Git Log |
| n | `<leader>gL` | Git Log Line |
| n | `<leader>gs` | Git Status |
| n | `<leader>gS` | Git Stash |
| n | `<leader>gd` | Git Diff (Hunks) |
| n | `<leader>gf` | Git Log File |
| n | `<leader>sb` | Buffer Lines |
| n | `<leader>sB` | Grep Open Buffers |
| n | `<leader>sg` | Grep |
| n, x | `<leader>sw` | Visual selection or word |
| n | `<leader>s"` | Registers |
| n | `<leader>s/` | Search History |
| n | `<leader>sa` | Autocmds |
| n | `<leader>sc` | Command History |
| n | `<leader>sC` | Commands |
| n | `<leader>sd` | Diagnostics |
| n | `<leader>sD` | Buffer Diagnostics |
| n | `<leader>sh` | Help Pages |
| n | `<leader>sH` | Highlights |
| n | `<leader>si` | Icons |
| n | `<leader>sj` | Jumps |
| n | `<leader>sk` | Keymaps |
| n | `<leader>sl` | Location List |
| n | `<leader>sm` | Marks |
| n | `<leader>sM` | Man Pages |
| n | `<leader>sp` | Plugin Specs |
| n | `<leader>sq` | Quickfix List |
| n | `<leader>sR` | Resume |
| n | `<leader>su` | Undo History |
| n | `<leader>uC` | Colorschemes |
| n | `gd` | Goto Definition |
| n | `gD` | Goto Declaration |
| n | `gr` | References |
| n | `gI` | Goto Implementation |
| n | `gy` | Goto T[y]pe Definition |
| n | `<leader>ss` | LSP Symbols |
| n | `<leader>sS` | LSP Workspace Symbols |
| n | `<leader>z` | Toggle Zen Mode |
| n | `<leader>Z` | Toggle Zoom |
| n | `<leader>.` | Toggle Scratch Buffer |
| n | `<leader>S` | Select Scratch Buffer |
| n | `<leader>n` | Notification History |
| n | `<leader>bd` | Delete Buffer |
| n | `<leader>fR` | Rename File |
| n, v | `<leader>gB` | Git Browse |
| n | `<leader>gg` | Lazygit |
| n | `<leader>un` | Dismiss All Notifications |
| n | `<c-/>` | Toggle Terminal |
| n, t | `]]` | Next Reference |
| n, t | `[[` | Prev Reference |
| n | `<leader>bo` | Close all buffers except current |
| n | `<leader>bc` | Close current buffer |

### Diffview
| Mode | Key | Description |
| :--- | :--- | :--- |
| n | `<leader>gv` | Diffview Open |
| n | `<leader>gV` | Diffview Close |
| n | `<leader>gh` | Diffview File History |
| n | `<leader>gH` | Diffview Branch History |

### Yanky
| Mode | Key | Description |
| :--- | :--- | :--- |
| n, x | `<leader>C` | Open Yank History |

### Venv Selector
| Mode | Key | Description |
| :--- | :--- | :--- |
| n | `<leader>,v` | Select Venv |

### Undotree
| Mode | Key | Description |
| :--- | :--- | :--- |
| n | `<F5>` | Open undotree |

### Todo Comments
| Mode | Key | Description |
| :--- | :--- | :--- |
| n | `<leader>st` | Todo |
| n | `<leader>sT` | Todo/Fix/Fixme |

### Splitjoin
| Mode | Key | Description |
| :--- | :--- | :--- |
| n, x | `gS` | Toggle split/join |
| n, x | `<leader>gsp` | Split |
| n, x | `<leader>gsj` | Join |

### Snipe
| Mode | Key | Description |
| :--- | :--- | :--- |
| n | `sb` | Open Snipe buffer menu |

### Python Import
| Mode | Key | Description |
| :--- | :--- | :--- |
| i, n | `<M-CR>` | Add python import |
| x | `<M-CR>` | Add python import |
| n | `<space>i` | Add python import and move cursor |
| x | `<space>i` | Add python import and move cursor |
| n | `<space>tr` | Add rich traceback |

### Snipe Marks
| Mode | Key | Description |
| :--- | :--- | :--- |
| n | `<leader>ml` | Find local marks |
| n | `<leader>ma` | Find all marks |

### Neotest
| Mode | Key | Description |
| :--- | :--- | :--- |
| n | `<leader>tn` | Run tests |
| n | `<leader>tf` | Run tests for current file |
| n | `<leader>ts` | Toggle test summary |

### Trouble
| Mode | Key | Description |
| :--- | :--- | :--- |
| n | `<leader>xx` | Diagnostics (Trouble) |
| n | `<leader>xX` | Buffer Diagnostics (Trouble) |
| n | `<leader>xs` | Symbols (Trouble) |
| n | `<leader>xl` | LSP Definitions / References |
| n | `<leader>xL` | Location List (Trouble) |
| n | `<leader>xQ` | Quickfix List (Trouble) |

### Gitsigns
| Mode | Key | Description |
| :--- | :--- | :--- |
| n | `]c` | Next Hunk |
| n | `[c` | Prev Hunk |
| n | `<leader>hs` | Stage Hunk |
| n | `<leader>hr` | Reset Hunk |
| v | `<leader>hs` | Stage Hunk |
| v | `<leader>hr` | Reset Hunk |
| n | `<leader>hS` | Stage Buffer |
| n | `<leader>hR` | Reset Buffer |
| n | `<leader>hp` | Preview Hunk |
| n | `<leader>hi` | Preview Hunk Inline |
| n | `<leader>hb` | Blame Line |
| n | `<leader>hd` | Diff This |
| n | `<leader>hD` | Diff This ~ |
| n | `<leader>ht` | Toggle Deleted |

### Dial
| Mode | Key | Description |
| :--- | :--- | :--- |
| n | `<C-a>` | Dial Increment |
| n | `<C-x>` | Dial Decrement |
