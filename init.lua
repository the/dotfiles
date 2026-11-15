vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.completeopt = {'menu', 'menuone', 'noinsert'}
vim.opt.autocomplete = true
vim.wo.scrolloff = 4
vim.g.mapleader = ' '

vim.pack.add({
    {src='git@github.com:nvim-tree/nvim-tree.lua.git'},
    {src='git@github.com:nvim-tree/nvim-web-devicons.git'},
    {src='git@github.com:ibhagwan/fzf-lua.git'},
    {src='git@github.com:nvim-lualine/lualine.nvim.git'},
})

--
-- LSP
--

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        -- Default mappings according to https://dotfiles.substack.com/p/whats-new-in-neovim-012
        -- gra → code actions
        -- gri → implementations
        -- grn → rename
        -- grr → references
        -- grt → type definition
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {buffer=args.buf})
    end,
})

local lsp_default_on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = bufnr,
        callback = function()
            vim.lsp.buf.format({bufnr=bufnr, async=false})
        end
    })
end

--
-- fzf Lua
--

vim.keymap.set('n', '<C-p>', ':FzfLua files<CR>')
vim.keymap.set('n', '<C-g>', ':FzfLua live_grep<CR>')

require('fzf-lua').setup({
    file_ignore_patterns = {
        '%.git/',
        '%.terraform/',
        'vendor/',
        'bin/',
        'node_modules/',
        '%.next/',
    },
})

--
-- NvimTree
--

require('nvim-tree').setup({
    filters = {
        custom = {'.git$', 'node_modules$', '.DS_Store', 'bin/', '.next/'}
    }
})

-- auto quit if nvim-tree is the last window
vim.api.nvim_create_autocmd('BufEnter', {
    pattern = 'NvimTree_*',
    callback = function()
        if #vim.api.nvim_list_wins() == 1 then
            vim.cmd('quit')
        end
    end,
})

vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>')

--
-- Netrw
--

-- vim.keymap.set('n', '<Leader>e', ':Lex<CR>')
-- vim.g.netrw_browse_split = 4
-- vim.g.netrw_winsize = 20
-- vim.g.netrw_liststyle = 3

--
-- Go
--

vim.lsp.config('gopls', {
    cmd = {'gopls'},
    filetypes = {'go', 'gomod'},
    root_markers = {'go.mod', '.git'},
    on_attach = function(client, bufnr)
        -- https://go.dev/gopls/editor/vim#a-hrefneovim-imports-idneovim-importsimports-and-formattinga
        vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = bufnr,
            callback = function()
                local params = vim.lsp.util.make_range_params()
                params.context = {only={"source.organizeImports"}}
                -- buf_request_sync defaults to a 1000ms timeout. Depending on your
                -- machine and codebase, you may want longer. Add an additional
                -- argument after params if you find that you have to write the file
                -- twice for changes to be saved.
                -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
                local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
                for cid, res in pairs(result or {}) do
                    for _, r in pairs(res.result or {}) do
                        if r.edit then
                            local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                            vim.lsp.util.apply_workspace_edit(r.edit, enc)
                        end
                    end
                end
                vim.lsp.buf.format({bufnr=bufnr, async=false})
            end
        })
    end
})
vim.lsp.enable('gopls')

--
-- OpenTofu / Terraform
--

vim.lsp.config('tofu_ls', {
    cmd = {'tofu-ls', 'serve'},
    filetypes = {'terraform', 'terraform-vars'},
    root_markers = {'.git', '.terraform.lock.hcl'},
    on_attach = lsp_default_on_attach,
})

vim.lsp.config('terraform_ls', {
    cmd = {'terraform-ls', 'serve'},
    filetypes = {'terraform', 'terraform-vars'},
    root_markers = {'.git', '.terraform.lock.hcl'},
    on_attach = lsp_default_on_attach,
})

local has_tofu = vim.fn.executable("tofu") == 1
local has_terraform = vim.fn.executable("terraform") == 1
-- Choose OpenTofu over Terraform if both are installed
if has_tofu then
  vim.lsp.enable("tofu_ls")
elseif has_terraform then
  vim.lsp.enable("terraform_ls")
end

--
-- Lualine
--

require('lualine').setup()
