
local ls_ok, ls = pcall(require, "luasnip")
if not ls_ok then
  print "ls not loading"
end

ls.snippet ={
  lua = {
    ls.parser.parse_snippet("lf","local $1 = funcion($2)\n  $0\nend")
  }
}
