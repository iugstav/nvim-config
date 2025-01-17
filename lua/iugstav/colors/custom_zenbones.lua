local lush = require("lush")
local zenbones = require("zenbones")

local theme = lush.extends({ zenbones }).with(function()
	return {
		Normal({ bg = "#0c0a03", fg = zenbones.Normal.fg.lighten(40).hex }), -- Fundo e texto
		Keyword({ fg = lush.hsluv("#c99bab").lighten(10).hex, gui = "bold" }), -- Palavras-chave em magenta
		Statement({ fg = zenbones.Statement.fg.lighten(20).hex, gui = "bold" }),
		Identifier({ fg = zenbones.Identifier.fg.lighten(30).hex }),
		Type({ fg = zenbones.Type.fg.lighten(10).hex }),

		WarningMsg({ fg = zenbones.WarningMsg.fg.lighten(40).hex }),
		ErrorMsg({ fg = zenbones.ErrorMsg.fg.lighten(40).hex }),

		StatusLine({ bg = "#000000", fg = zenbones.StatusLine.fg }),
	}
end)

return theme
