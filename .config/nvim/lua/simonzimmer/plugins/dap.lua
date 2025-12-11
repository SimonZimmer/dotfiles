return {
  'mfussenegger/nvim-dap',
  keys = {
    { "<leader>db", "<cmd>DapToggleBreakpoint<cr>", desc = "Toggle breakpoint" },
    { "<leader>dc", "<cmd>DapContinue<cr>", desc = "Continue" },
    { "<leader>ds", "<cmd>DapStepOver<cr>", desc = "Step over" },
    { "<leader>di", "<cmd>DapStepInto<cr>", desc = "Step into" },
  },
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
    'mfussenegger/nvim-dap-python',
    'nvim-neotest/nvim-nio',
  },
  config = function()
    vim.keymap.set('n', '<leader>db', '<cmd>lua require"dap".toggle_breakpoint()<CR>', { desc = '[D]ebug [B]reakpoint' })
    vim.keymap.set('n', '<leader>dc', '<cmd>lua require"dap".continue()<CR>', { desc = '[D]ebug [C]ontinue' })
    vim.keymap.set('n', '<leader>do', '<cmd>lua require"dap".step_over()<CR>', { desc = '[D]ebug Step [O]ver' })
    vim.keymap.set('n', '<leader>di', '<cmd>lua require"dap".step_into()<CR>', { desc = '[D]ebug Step [I]nto' })
    vim.keymap.set('n', '<leader>dt', '<cmd>lua require"dap-python".test_method()<CR>', { desc = '[D]ebug [T]est' })

    local dap = require('dap')

    vim.fn.sign_define('DapBreakpoint', { text='●', texthl='DiagnosticError' })
    vim.fn.sign_define('DapLogPoint' , { text='◉', texthl='DiagnosticError' })
    vim.fn.sign_define('DapStopped' , { text='➔', texthl='DiagnosticInfo', linehl='CursorLine' })

    local ui  = require 'dapui'
    dap.listeners.after['event_initialized']['dapui_config'] = function() ui.open({})
    end
    dap.listeners.before['event_terminated']['dapui_config'] = function()
      ui.close({})
    end

    dap.listeners.before['event_exited']['dapui_config'] = function()
      ui.close({})
    end

    require 'nvim-dap-virtual-text'.setup {}

    ui.setup {
      mappings = {
        expand = {'<CR>', '<LeftMouse>'},
        open = {'o'},
        remove = {'d', 'x'},
        edit = {'c'},
        repl = {'r'},
      },
      layouts = {
        {
          elements = {
            'breakpoints',
            'watches',
            'stacks',
            'scopes',
          },
          size = 70,
          position = 'right',
        }, {
          elements = {'repl'},
          size = 20,
          position = 'bottom',
        },
      },
      floating = {
        max_height = nil,
        max_width  = nil,
      },
    }

    local function dapui_eval()
      local expr = vim.fn.input('DAP expression: ')
      if vim.fn.empty(expr) ~= 0 then
        return
      end
      ui.eval(expr, {})
    end

    vim.keymap.set({'n', 'v'}, '<M-k>', ui.eval, {})
    vim.keymap.set('n', '<M-K>', dapui_eval, {})

    require('dap-python').setup('python3')

    dap.set_log_level('DEBUG')

    local codelldb_path = vim.fn.expand("~/.local/share/nvim/mason/bin/codelldb")
    if vim.fn.executable(codelldb_path) == 1 then
      dap.adapters.codelldb = {
        type = 'server',
        port = "${port}",
        executable = {
          command = codelldb_path,
          args = {"--port", "${port}"},
        }
      }

      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          stopAtEntry = true,
          setupCommands = {
            {
              text = '-enable-pretty-printing',
              description = 'enable pretty printing',
              ignoreFailures = false,
            }
          },
          runInTerminal = true,
        },
        {
          name = 'Attach to process',
          type = 'codelldb',
          request = 'attach',
          cwd = '${workspaceFolder}',
          pid = require('dap.utils').pick_process,
          stopAtEntry = true,
          setupCommands = {
            {
              text = '-enable-pretty-printing',
              description = 'enable pretty printing',
              ignoreFailures = false,
            }
          },
          runInTerminal = true,
          sourcePaths = { vim.fn.expand("~/dev/Pd-Externals/source/") },
          args = {},
        },
      }

      dap.configurations.c = dap.configurations.cpp
    else
      vim.notify("codelldb not found. Install via :MasonInstall codelldb", vim.log.levels.WARN)
    end
  end,
}
