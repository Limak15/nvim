local ls = require('luasnip')

local test = ls.parser.parse_snippet({
  trig = "for",
  dscr = "For loop",
  wordTriggers = { "for" },
  desc = "Simple for loop template"
},
  [[
for (int ${1:i} = 0; ${1:i} < ${2:n}; ++${1:i}) {
    ${3:// code}
}
]]
)
ls.add_snippets("cpp", { test }) 

