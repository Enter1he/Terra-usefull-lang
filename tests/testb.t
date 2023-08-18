-- testb.t
import "lib.use"
local function prinT(t) -- for debug
    for k, v in pairs(t) do
        print(k,v)
    end
end
local c = terralib.includecstring[[
    #include <stdio.h>
]]
use c

local b = {}

terra b.ret()
    printf"retrun\n"
end
-- _G = nil

return b