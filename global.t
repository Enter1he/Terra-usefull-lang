-- global.t
local function prinT(t)
    for k, v in pairs(t) do
        print(k,v)
    end
end

local globals = {}
return {
    entrypoints = {"gvar", "global"};
    keywords = {};
    statement = function(self, lex)
        if lex:nextif"gvar" then
            local name = lex:expect(lex.name).value
            lex:expect":"
            local ty = lex:luaexpr()
            local val
            if lex:nextif"=" then
                val = lex:terraexpr()
                print(val(_G))
            end
            return function(env_fn)
                ty = ty(_G)
                if val then
                    return global(ty, val(_G))
                else
                    return global(ty)
                end
            end, {name}
        elseif lex:nextif"global" then
            local token = lex:expect(lex.name)
            local name = token.value
            local val
            
            if globals[name] then 
                error("redeclaration of global variable "..name.." on line "..tostring(token.linenumber))
            end
            globals[name] = name
            if lex:nextif"=" then
                val = lex:luaexpr()
            end
            return function(env_fn)
                if val then
                    return val
                else
                    return false
                end
            end, {name}
        end
    end;
}