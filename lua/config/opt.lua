vim.opt.shortmess:append("I")
-- Отключение swap-файлов
vim.opt.swapfile = false

-- Включение номеров строк
vim.opt.number = true
vim.o.scl = "yes"

-- Включение относительных номеров строк (опционально)
vim.opt.relativenumber = true

-- Включение подсветки синтаксиса
vim.cmd('syntax on')

-- Включение автоматического отступа
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Включение поиска с учетом регистра только если есть заглавные буквы
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Включение подсветки результатов поиска
vim.opt.hlsearch = true

-- Включение отображения табов и пробелов
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Настройка ширины табуляции
vim.opt.tabstop = 2       -- 1 tab = 2 spaces
vim.opt.shiftwidth = 2    -- Indent using 2 spaces
vim.opt.expandtab = true  -- Use spaces instead of tabs

-- Включение мыши во всех режимах
vim.opt.mouse = 'a'

-- Включение переноса строк
vim.opt.wrap = true

-- Включение автоматического чтения файла при изменении извне
vim.opt.autoread = true

-- Включение отображения строки статуса
vim.opt.laststatus = 2

-- Включение отображения командной строки
vim.opt.showcmd = true

-- Включение отображения текущей строки
vim.opt.cursorline = true

-- Включение отображения текущего столбца
vim.opt.cursorcolumn = false

-- Включение отображения подсказок при наборе команд
vim.opt.wildmenu = true

-- Включение отображения подсказок при наборе команд
vim.opt.wildmode = 'longest:full,full'

-- Включение отображения подсказок при наборе команд
vim.opt.wildignore = '*.o,*.obj,*~,*.swp,*.git,*.hg,*.svn,*.DS_Store'

-- Включение отображения подсказок при наборе команд
vim.opt.wildignorecase = true

-- Включение отображения подсказок при наборе команд
vim.opt.wildcharm = 26

-- Включение отображения подсказок при наборе команд
vim.opt.wildoptions = 'pum'

-- Включение отображения подсказок при наборе команд
vim.opt.wildignore = '*.o,*.obj,*~,*.swp,*.git,*.hg,*.svn,*.DS_Store'

-- Включение отображения подсказок при наборе команд
vim.opt.wildignorecase = true

-- Включение отображения подсказок при наборе команд
vim.opt.wildcharm = 26

-- Включение отображения подсказок при наборе команд
vim.opt.wildoptions = 'pum'

-- Включение отображения подсказок при наборе команд
vim.opt.wildignore = '*.o,*.obj,*~,*.swp,*.git,*.hg,*.svn,*.DS_Store'

-- Включение отображения подсказок при наборе команд
vim.opt.wildignorecase = true

-- Включение отображения подсказок при наборе команд
vim.opt.wildcharm = 26

-- Включение отображения подсказок при наборе команд
vim.opt.wildoptions = 'pum'

-- Включение отображения подсказок при наборе команд
vim.opt.wildignore = '*.o,*.obj,*~,*.swp,*.git,*.hg,*.svn,*.DS_Store'

-- Включение отображения подсказок при наборе команд
vim.opt.wildignorecase = true

-- Включение отображения подсказок при наборе команд
vim.opt.wildcharm = 26

-- Включение отображения подсказок при наборе команд
vim.opt.wildoptions = 'pum'
