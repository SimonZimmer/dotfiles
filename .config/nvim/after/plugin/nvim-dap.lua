local dap = require 'dap'
local ui  = require 'dapui'
local vt  = require 'nvim-dap-virtual-text'


local signs = {
	DapBreakpoint = {text='●', texthl='LspDiagnosticsDefaultError'},
	DapLogPoint = {text='◉', texthl='LspDiagnosticsDefaultError'},
	DapStopped = {text='➔', texthl='LspDiagnosticsDefaultInformation', linehl='CursorLine'},
}

vim.keymap.set('n', 'db', '<cmd>lua require"dap".toggle_breakpoint()<CR>', {})
vim.keymap.set('n', 'dc', '<cmd>lua require"dap".continue()<CR>', {})
vim.keymap.set('n', 'do', '<cmd>lua require"dap".step_over()<CR>', {})
vim.keymap.set('n', 'di', '<cmd>lua require"dap".step_into()<CR>', {})

local adapters = {
	name = 'lldb-vscode',
	type = 'executable',
	attach = {
		pidProperty = "pid",
		pidSelect = "ask"
	},
	command = 'lldb-vscode',
	args = {},
	LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES",
	options = {
		env = {
			LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES",
		},
	},
}

local configurations = {
	{
		type = 'scala',
		request = 'launch',
		name = 'Run',
		metals = {
			runType = 'run',
		},
	}, {
		type = 'scala',
		request = 'launch',
		name = 'Test file',
		metals = {
			runType = 'testFile',
		},
	}, {
		type = 'scala',
		request = 'launch',
		name = 'Test target',
		metals = {
			runType = 'testTarget',
		},
	}
}

for sign, options in pairs(signs) do
	vim.fn.sign_define(sign, options)
end

for language, adapter in pairs(adapters) do
	dap.adapters[language] = adapter
end

for language, configs in pairs(configurations) do
	dap.configurations[language] = configs
end


dap.listeners.after['event_initialized']['dapui_config'] = function()
	ui.open({})
end

dap.listeners.before['event_terminated']['dapui_config'] = function()
	ui.close({})
end

dap.listeners.before['event_exited']['dapui_config'] = function()
	ui.close({})
end


vt.setup {}


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
			size = 40,
			position = 'right',
		}, {
			elements = {'repl'},
			size = 10,
			position = 'bottom',
		},
	},
	floating = {
		max_height = nil,  -- Either absolute integer or float
		max_width  = nil,  -- between 0 and 1 (size relative to screen size)
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
