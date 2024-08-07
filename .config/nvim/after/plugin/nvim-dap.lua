vim.keymap.set('n', '<leader>db', '<cmd>lua require"dap".toggle_breakpoint()<CR>', { desc = '[D]ebug [B]reakpoint' })
vim.keymap.set('n', '<leader>dc', '<cmd>lua require"dap".continue()<CR>', { desc = '[D]ebug [C]ontinue' })
vim.keymap.set('n', '<leader>do', '<cmd>lua require"dap".step_over()<CR>', { desc = '[D]ebug Step [O]ver' })
vim.keymap.set('n', '<leader>di', '<cmd>lua require"dap".step_into()<CR>', { desc = '[D]ebug Step [I]nto' })
vim.keymap.set('n', '<leader>dt', '<cmd>lua require"dap-python".test_method()<CR>', { desc = '[D]ebug [T]est' })

local dap = require('dap')

vim.fn.sign_define('DapBreakpoint', { text='●', texthl='LspDiagnosticsDefaultError' })
vim.fn.sign_define('DapLogPoint' , { text='◉', texthl='LspDiagnosticsDefaultError' })
vim.fn.sign_define('DapStopped' , { text='➔', texthl='LspDiagnosticsDefaultInformation', linehl='CursorLine' })

-- dap UI
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

-- Python
-- requires the below referenced virtual environment with debugpy installed
require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')

-- CPP
local dap = require('dap')
dap.set_log_level('DEBUG')

dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    command = "/Users/simonzimmermann/Downloads/codelldb-x86_64-darwin/extension/adapter/codelldb",
    args = {"--port", "${port}"},
  }
}

dap.configurations.cpp = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', '/Applications/', 'file')
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
        sourcePaths = { '/Users/simonzimmermann/dev/Pd-Externals/source/' },
        args = {},
      },
}

dap.configurations.c = dap.configurations.cpp

