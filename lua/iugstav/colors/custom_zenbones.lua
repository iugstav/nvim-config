local lush = require("lush")
local zenbones = require("zenbones")

local theme = lush.extends({ zenbones }).with(function()
	return {
		Normal({ bg = zenbones.Normal.bg, fg = zenbones.Normal.fg.lighten(60) }), -- Fundo e texto
		Keyword({ fg = lush.hsluv("#c99bab").lighten(10), gui = "bold" }), -- Palavras-chave em magenta
		Statement({ fg = zenbones.Statement.fg.lighten(40).hex, gui = "bold" }),
		Identifier({ fg = zenbones.Identifier.fg.lighten(50).hex }),
		Type({ fg = zenbones.Type.fg.lighten(30).hex }),

		WarningMsg({ fg = zenbones.WarningMsg.fg.lighten(40).hex }),
		ErrorMsg({ fg = zenbones.ErrorMsg.fg.lighten(40).hex }),

		StatusLine({ bg = "#000000", fg = zenbones.StatusLine.fg }),
	}
end)

return theme
