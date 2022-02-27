local gl = require("galaxyline")
local gls = gl.section

local fileinfo = require("galaxyline.providers.fileinfo")
local lspclient = require("galaxyline.providers.lsp")

local colours = {
	bg = "#222222",
	black = "#000000",
	white = "#ffffff",
	accent_light = "#c2d5ff",
	accent = "#5f87d7",
	accent_dark = "#00236e",
	alternate = "#8fbcbb",
	alternate_dark = "#005f5f",
	yellow = "#fabd2f",
	cyan = "#008080",
	darkblue = "#081633",
	green = "#afd700",
	orange = "#FF8800",
	purple = "#5d4d7a",
	magenta = "#d16d9e",
	grey = "#555555",
	blue = "#0087d7",
	red = "#ec5f67",
	pink = "#e6a1e2",
}

local function highlight(name, fg, bg, style)
	local cmd = "hi " .. name .. " guibg=" .. bg .. " guifg=" .. fg
	if style then
		cmd = cmd .. " gui=" .. style
	end
	vim.api.nvim_command(cmd)
end

local function hi_link(name1, name2)
	vim.api.nvim_command("hi link " .. name1 .. " " .. name2)
end

local function mix_colours(color_1, color_2, weight)
	local d2h = function(d) -- convert a decimal value to hex
		return string.format("%x", d)
	end
	local h2d = function(h) -- convert a hex value to decimal
		return tonumber(h, 16)
	end

	color_1 = string.sub(color_1, 1, -1)
	color_2 = string.sub(color_2, 1, -1)

	weight = weight or 50 -- set the weight to 50%, if that argument is omitted

	local color = "#";

	for i = 2, 6, 2 do -- loop through each of the 3 hex pairsred, green, and blue
		local v1 = h2d(string.sub(color_1, i, i+1)) -- extract the current pairs
		local v2 = h2d(string.sub(color_2, i, i+1))

		-- combine the current pairs from each source color, according to the specified weight
		local val = d2h(math.floor(v2 + (v1 - v2) * (weight / 100.0)))

		while(string.len(val) < 2) do val = '0' .. val end -- prepend a '0' if val results in a single digit

		color = color .. val -- concatenate val to our new color string
	end

	return color; -- PROFIT!
end

local function generate_mode_colours()
	-- n   Normal
	-- no  Operator-pending
	-- v   Visual by character
	-- V   Visual by line
	-- CTRL-V  Visual blockwise
	-- s   Select by character
	-- S   Select by line
	-- CTRL-S  Select blockwise
	-- i   Insert
	-- ic  Insert mode completion |compl-generic|
	-- ix  Insert mode |i_CTRL-X| completion
	-- R   Replace |R|
	-- Rc  Replace mode completion |compl-generic|
	-- Rv  Virtual Replace |gR|
	-- Rx  Replace mode |i_CTRL-X| completion
	-- c   Command-line editing
	-- cv  Vim Ex mode |gQ|
	-- ce  Normal Ex mode |Q|
	-- r   Hit-enter prompt
	-- rm  The -- more -- prompt
	-- r?  A |:confirm| query of some sort
	-- !   Shell or external command is executing
	-- t   Terminal mode: keys go to the job

	local mode_colours = { -- fg, bg
		n      = {colours.accent_light, colours.accent         },
		no     = {colours.accent_light, colours.accent         },
		v      = {colours.black,        colours.yellow         },
		V      = {colours.black,        colours.yellow         },
		[""] = {colours.black,        colours.yellow         },
		s      = {colours.black,        colours.orange         },
		S      = {colours.black,        colours.orange         },
		[""] = {colours.black,        colours.orange         },
		i      = {colours.alternate,    colours.alternate_dark },
		ic     = {colours.alternate,    colours.alternate_dark },
		ix     = {colours.alternate,    colours.alternate_dark },
		R      = {colours.black,        colours.green          },
		Rc     = {colours.black,        colours.green          },
		Rv     = {colours.black,        colours.green          },
		Rx     = {colours.black,        colours.green          },
		c      = {colours.white,        colours.red            },
		cv     = {colours.white,        colours.red            },
		ce     = {colours.white,        colours.red            },
		r      = {colours.black,        colours.cyan           },
		rm     = {colours.black,        colours.cyan           },
		["r?"] = {colours.black,        colours.cyan           },
		["!"]  = {colours.black,        colours.white          },
		t      = {colours.black,        colours.white          },
	}

	local full_table = {}
	for mode, values in pairs(mode_colours) do
		local main_bg = values[2]
		local base_fg = values[1]
		local dim_bg
		local dimmer_bg = mix_colours(main_bg, colours.bg, 20)
		local main_fg
		local dim_fg
		if base_fg == colours.white or base_fg == colours.black then
			if base_fg == colours.black then
				dim_bg = mix_colours(main_bg, colours.bg, 40)
				main_fg = mix_colours(main_bg, colours.black, 50)
				dim_fg = main_bg
			else
				dim_bg = mix_colours(main_bg, colours.bg, 50)
				main_fg = mix_colours(main_bg, colours.white, 30)
				dim_fg = mix_colours(main_bg, colours.white, 50)
			end
		else
			main_fg = base_fg
			dim_bg = mix_colours(main_bg, colours.bg, 50)
			dim_fg = mix_colours(main_fg, dim_bg, 80)
		end
		full_table[mode] = {
			main_fg = main_fg,
			main_bg = main_bg,
			dim_fg = dim_fg,
			dim_bg = dim_bg,
			dimmer_bg = dimmer_bg,
		}
	end
	return full_table
end

local mode_colours = generate_mode_colours()

highlight("GalaxySearchResult", mix_colours(colours.yellow, colours.black, 50), colours.yellow)
highlight("GalaxyTrailing", mix_colours(colours.red, colours.white, 30), colours.red)
hi_link("GalaxyInnerSeparator1", "GalaxySection1")
hi_link("GalaxyInnerSeparator2", "GalaxySection2")

local function search(pattern)
  local line = vim.fn.search(pattern, "nw")
  if line == 0 then
    return ""
  end
  return string.format("%d", line)
end

local function check_trailing()
  return search([[\s$]])
end

local function search_results_available()
	local search_count = vim.fn.searchcount({
		recompute = 1,
		maxcount = -1,
	})
	return vim.v.hlsearch == 1 and search_count.total > 0
end

gls.left[1] = {
	ViMode = {
		provider = function()
			local alias = {
				n = "NORMAL",
				no = "N OPERATOR",
				v = "VISUAL",
				V = "V LINE",
				[""] = "V BLOCK",
				s = "SELECT",
				S = "S LINE",
				[""] = "S BLOCK",
				i = "INSERT",
				ic = "I COMPLETION",
				ix = "I X COMP",
				R = "REPLACE",
				Rc = "R COMPLETION",
				Rv = "R VIRTUAL",
				Rx = "R X COMP",
				c = "COMMAND",
				cv = "EX",
				r = "PROMPT",
				rm = "MORE",
				["r?"] = "CONFIRM",
				["!"] = "EXT COMMAND",
				t = "TERMINAL",
			}
			local mode = vim.fn.mode()
			local c = mode_colours[mode]

			local search_results = search_results_available()
			if search_results then
				highlight("GalaxySearchResultEdge", colours.yellow, c.main_bg)
				highlight("GalaxyTrailingEdge", colours.red, colours.yellow)
			else
				highlight("GalaxyTrailingEdge", colours.red, c.main_bg)
			end

			highlight("GalaxylineFillSection", c.dimmer_bg, c.dimmer_bg)
			-- highlight("StatusLine", c.dimmer_bg, c.dimmer_bg)
			highlight("GalaxyMidText", c.dim_fg, c.dimmer_bg)

			highlight("GalaxySection1", c.main_fg, c.main_bg)
			highlight("GalaxySection1Edge", c.main_bg, c.dim_bg)
			highlight("GalaxySection2", c.dim_fg, c.dim_bg)
			highlight("GalaxySection2Bright", colours.white, c.dim_bg)
			highlight("GalaxySection2Edge", c.dim_bg, c.dimmer_bg)

			highlight("GalaxyViMode", c.main_fg, c.main_bg, "bold")
			highlight("GalaxyFileIcon", fileinfo.get_file_icon_color(), c.dimmer_bg)
			highlight("GalaxyEditIcon", colours.red, c.dimmer_bg)

			return '  ' .. alias[vim.fn.mode()] .. ' '
		end,
		separator = "",
		separator_highlight = "GalaxySection1Edge",
		highlight = "GalaxySection1",
		-- highlight = { colours.accent_dark, colours.accent, "bold" },
	},
}

gls.left[2] = { -- lsp server
	LspServer = {
		provider = function()
			local curr_client = lspclient.get_lsp_client()
			if curr_client ~= "No Active Lsp" then
				return ' ' .. curr_client .. ' '
			end
		end,
		highlight = "GalaxySection2",
	},
}

gls.left[3] = {
	LspFunctionIcon = {
		provider = function()
			local current_function = vim.b.lsp_current_function
			if current_function and current_function ~= '' then
				return ' '
			end
		end,
		highlight = "GalaxySection2Bright",
	},
}

gls.left[4] = {
	LspFunction = {
		provider = function()
			local current_function = vim.b.lsp_current_function
			if current_function and current_function ~= '' then
				return ' ' .. current_function .. ' '
			end
		end,
		separator = "",
		separator_highlight = "GalaxySection2Edge",
		highlight = "GalaxySection2",
	},
}

gls.mid[1] = { -- file icon
	FileIcon = {
		provider = function()
			return ' ' .. fileinfo.get_file_icon()
		end,
		highlight = "GalaxyFileIcon",
	},
}

gls.mid[2] = { -- filename
	CurrentFile = {
		provider = function()
			local path = vim.fn.expand('%:p')
			if not path or path == '' then
				path = "[No Name]"
			end
			return path
		end,
		highlight = "GalaxyMidText",
	},
}

gls.mid[3] = { -- ~ separator
	Tilde = {
		provider = function()
			local file_size = fileinfo.get_file_size()
			if file_size and file_size ~= '' then
				return '  ~ '
			else -- don't show ~ because there is no size following
				return ' ' -- for spacing edit icon
			end
		end,
		highlight = "GalaxyEditIcon",
	},
}

gls.mid[4] = { -- file size
	FileSize = {
		provider = fileinfo.get_file_size,
		highlight = "GalaxyMidText",
	},
}

gls.mid[5] = { -- modified/special icons
	Modified = {
		provider = function()
			if vim.bo.readonly then
				return ' '
			end
			if not vim.bo.modifiable then
				return ' '
			end
			if vim.bo.modified then
				return ' '
			end
		end,
		highlight = "GalaxyEditIcon",
	},
}

gls.right[9] = { -- trailing indicator
	Whitespace = {
		provider = function()
			local trailing = check_trailing()
			if trailing ~= '' then
				return "  tr " .. trailing .. ' '
			end
		end,
		highlight = "GalaxyTrailing",
	},
}

gls.right[8] = { -- trailing edge
	WhitespaceEdge = {
		provider = function()
			local trailing = check_trailing()
			if trailing ~= '' then
				return ''
			end
		end,
		highlight = "GalaxyTrailingEdge",
	},
}

gls.right[7] = { -- search indicator
	Search = {
		provider = function()
			local search_count = vim.fn.searchcount({
				recompute = 1,
				maxcount = -1,
			})
			local active_result = vim.v.hlsearch == 1 and search_count.total > 0
			if active_result then
				return '   ' .. search_count.current .. '/' .. search_count.total .. ' '
			end
		end,
		highlight = "GalaxySearchResult",
	},
}

gls.right[6] = { -- search edge
	SearchEdge = {
		provider = function()
			if search_results_available() then
				return ''
			end
		end,
		highlight = "GalaxySearchResultEdge",
	},
}

gls.right[5] = { -- file percent
	Percent = {
		provider = function()
			return fileinfo.current_line_percent()
		end,
		highlight = "GalaxySection1",
		separator = "",
		separator_highlight = "GalaxyInnerSeparator1",
	},
}

gls.right[4] = { -- line & column
	LineColumn = {
		provider = function()
			local mode = vim.fn.mode()
			if mode == 'v' or mode == 'V' or mode == "" then -- visual mode (show selection)
				local lstart = vim.fn.line("v")
				local lend = vim.fn.line(".")
				local cstart = vim.fn.col("v")
				local cend = vim.fn.col(".")
				return '  ' .. lstart .. ':' .. lend .. '/' .. vim.fn.line('$') .. '  ' .. cstart .. ':' .. cend .. '/' .. vim.fn.col('$') .. ' '
			else
				return '  ' .. vim.fn.line(".") .. '/' .. vim.fn.line('$') .. '  ' .. vim.fn.col(".") .. '/' .. vim.fn.col('$') .. ' '
			end
		end,
		highlight = "GalaxySection1",
		separator = "",
		separator_highlight = "GalaxySection1Edge",
	},
}

gls.right[3] = { -- encoding (eg. utf-8)
	Encode = {
		provider = function()
			local encoding = vim.bo.fenc
			if encoding and encoding ~= '' then
				return ' ' .. encoding .. ' '
			end
		end,
		highlight = "GalaxySection2",
	},
}

gls.right[2] = { -- format (eg. unix)
	Format = {
		provider = function()
			local fformat = vim.bo.fileformat
			local icon
			if fformat == "unix" then
				icon = ''
			elseif fformat == "dos" then
				icon = ''
			elseif fformat == "mac" then
				icon = ''
			end
			return ' ' .. icon .. ' '
		end,
		highlight = "GalaxySection2Bright",
	},
}

gls.right[1] = { -- filetype (eg. python)
	FileType = {
		provider = function()
			local filetype = vim.bo.filetype
			if filetype and filetype ~= '' then
				return ' ' .. filetype .. ' '
			end
		end,
		highlight = "GalaxySection2",
		separator = "",
		separator_highlight = "GalaxySection2Edge",
	},
}
