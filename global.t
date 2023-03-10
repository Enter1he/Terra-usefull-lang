-- global.t
local function prinT(t) -- for debug
    for k, v in pairs(t) do
        print(k,v)
    end
end

local function resolveType(val)
    local ty;
    local t = type(val)
    if t == "string" then
        ty = &int8
    elseif t == "number" then
        ty = terralib.isintegral(val) and int or double
    end
    return ty
end

local globals = {}
return {
    name = "global";
    entrypoints = {"gvar", "global"};
    keywords = {};
    statement = function(self, lex)
        if lex:nextif"gvar" then
            local name = lex:expect(lex.name).value
            local ty
            local val
            if lex:nextif":" then
                ty = lex:luaexpr()
            end
            if lex:nextif"=" then
                val = lex:luaexpr()
            end
            if not ty and not val then
                error"at least value must be supplied to gvar!"
            end
            return function(env_fn)
                if val then
                    val = val(_G)
                    if not ty then
                        ty = resolveType(val)
                    end
                    return global(ty, val)
                else
                    ty = ty(_G)
                    return global(ty)
                end
            end, {name}
        elseif lex:nextif"global" then
            local token = lex:expect(lex.name)
            local name = token.value
            local val
            
            if globals[name] then 
                error(token.filename.." redeclaration of global variable "..name.." on line "..tostring(token.linenumber))
            end
            globals[name] = name
            if lex:nextif"=" then
                val = lex:luaexpr()
            end
            return function(env_fn)
                if val then
                    return val
                else
                    return nil
                end
            end, {name}
        end
    end;
}