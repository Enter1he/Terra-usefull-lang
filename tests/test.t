-- test.t
local function prinT(t) -- for debug
    for k, v in pairs(t) do
        print(k,v)
    end
end
local c = terralib.includecstring[[
    #include <stdio.h>
    #include <stdlib.h>
]]

local b = global(&int)

import"lib.global"
import"lib.use"
-- print(_G)
local a;
local a;
use c

use "testb"

terra main()
    printf("F\n")
    ret()
end
main()
-- terralib.saveobj("test.exe", {main = main})