local ls = Prequire("luasnip")

local function snip_merge(filetype)
  local snipp = Prequire('ay_snip.' .. filetype)
  if snipp == nil then
    print("no sniipet here")
    return
  end
  ls.add_snippets(filetype, Prequire('ay_snip.' .. filetype))
end

snip_merge('c')
-- -- snip_merge('cpp')
-- -- snip_merge('go')
-- print("fin")
