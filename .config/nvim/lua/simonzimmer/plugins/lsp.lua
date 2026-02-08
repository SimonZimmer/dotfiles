return {
  { 'VonHeikemen/lsp-zero.nvim', lazy = true },

  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  },

  {
    'williamboman/mason-lspconfig.nvim',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = { "lua_ls", "clangd", "pylsp", "azure_pipelines_ls", "yamlls", "helm_ls", "gopls" },
      }
    end,
  },

  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    event = "VeryLazy",
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
      require('mason-tool-installer').setup {
        ensure_installed = {
          'cmake-language-server',
          'lua-language-server',
          'yamllint',
          'actionlint',
          'golangci-lint',
        },
        auto_update = false,
      }
    end,
  },

  {
    'neovim/nvim-lspconfig',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { 'b0o/schemastore.nvim' },
    config = function()
      local lsp = require('lsp-zero')

      vim.lsp.config.lua_ls = {
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            workspace = {
              checkThirdParty = false,
              library = { vim.env.VIMRUNTIME },
            },
            diagnostics = { globals = { 'vim' } },
          },
        },
      }

      vim.lsp.config.clangd = {}
      vim.lsp.enable('clangd')

      vim.lsp.config.yamlls = {
        cmd = { 'yaml-language-server', '--stdio' },
        filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab' },
        root_dir = vim.fs.root(0, {'.git', '.'}),
        settings = {
          yaml = {
            schemaStore = {
              enable = false,
              url = "",
            },
            schemas = require('schemastore').yaml.schemas(),
          },
        }
      }
      vim.lsp.enable('yamlls')

      vim.lsp.config.helm_ls = {
        cmd = { 'helm_ls', 'serve' },
        filetypes = { 'helm' },
        root_dir = function(fname)
          return require('lspconfig.util').root_pattern('Chart.yaml')(fname) or vim.fs.root(fname, {'.git', '.'})
        end,
        settings = {
          ['helm-ls'] = {
            yamlls = {
              path = "yaml-language-server",
            }
          }
        }
      }
      vim.lsp.enable('helm_ls')

      lsp.on_attach(function(client, bufnr)
        local opts = { buffer = bufnr, remap = false }

        if client.name == "eslint" then
          vim.cmd.LspStop('eslint') return
        end

        vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "<leader>D", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>gn", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "<leader>gp", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", '<leader>gh', function()
          local params = { uri = vim.uri_from_bufnr(0) }
          vim.lsp.buf_request(0, 'textDocument/switchSourceHeader', params, function(err, result)
            if result then
              vim.cmd('edit ' .. vim.uri_to_fname(result))
            end
          end)
        end, opts)
      end)

      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      vim.lsp.config.pylsp = {
        cmd = { 'pylsp' },
        filetypes = { 'python' },
        root_dir = vim.fs.root(0, {'.git', 'setup.py', 'pyproject.toml', '.'}),
        capabilities = capabilities
      }
      vim.lsp.enable('pylsp')

      vim.lsp.config.gopls = {
        cmd = { "gopls" },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_dir = vim.fs.root(0, { "go.work", "go.mod", ".git" }),
        settings = {
          gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
              unusedparams = true,
            },
          },
        },
      }
      vim.lsp.enable('gopls')

      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = false,
      })


      local function format_with_clang()
        local clang_format_path = vim.fn.glob(vim.fn.expand("~/.config") .. "/**/.clang-format")
        if clang_format_path == "" then
          vim.notify("Error: .clang-format file not found", vim.log.levels.ERROR)
          return
        end
        local clang_format_cmd = "clang-format -i --style=file:" .. clang_format_path
        local file_path = vim.fn.expand("%:p")
        local cmd = clang_format_cmd .. " " .. file_path

        local result = vim.fn.system(cmd)
        if vim.v.shell_error ~= 0 then
          vim.notify("Error running clang-format: " .. result, vim.log.levels.ERROR)
          return
        end
        vim.cmd("checktime")
      end

      vim.api.nvim_create_augroup("ClangFormatOnSave", { clear = true })
      vim.api.nvim_create_autocmd("BufWritePost", {
        group = "ClangFormatOnSave",
        pattern = { "*.h", "*.cpp", "*.c" },
        callback = format_with_clang,
      })
    end,
  },

  {
    'mfussenegger/nvim-lint',
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require('lint').linters_by_ft = {
        yaml = {'yamllint'},
        helm = {'yamllint'},
        go = {'golangcilint'},
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged" }, {
        group = lint_augroup,
        callback = function()
          local lint = require("lint")
          if vim.bo.filetype == "yaml" then
            if vim.fn.expand("%:p"):match(".github/workflows/") then
              lint.try_lint("actionlint")
            end
          end
          lint.try_lint()
        end,
      })
    end,
  },

  { 'towolf/vim-helm', ft = "helm" },
}
