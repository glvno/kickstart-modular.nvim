local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  -- Map skeleton
  s(';kvm', {
    t { '%{', '\t' },
    i(1),
    t { '', '}' },
  }),

  s(';kvms', {
    t { '%' },
    i(1),
    t { '{', '\t' },
    i(2),
    t { '', '}' },
  }),

  -- String key-value pair
  s(';kvs', {
    t '"',
    i(1, 'key'),
    t '" => ',
    i(2, 'value'),
    t ',',
  }),

  -- Atom key-value pair
  s(';kva', {
    i(1, 'key'),
    t ': ',
    i(2, 'value'),
    t ',',
  }),

  s(';ok', {
    t { '{:ok, ' },
    i(1),
    t { '}' },
  }),

  s(';err', {
    t { '{:error, ' },
    i(1),
    t { '}' },
  }),
}
