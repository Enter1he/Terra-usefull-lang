<!-- global.md -->

# global.t - Language to handle globals

## Global language is made with to ideas:
    1) Manage global variables in Lua
    2) Create easy interface for declaring Terra globals

First one is achieved by creating keyword global

'''Terra
    global a = "b"
'''

Then this value can be used as a normal lua value
'''Terra
    print(a) -- b
    terra main()
        c.printf("%s", a) -- b
    end
'''

However you can't declare same variable again
'''Terra
    global a; -- error! variable redeclaration! 
'''

Global.t uses additional table for tracking all variables declared with keyword

The more usefull feature of global.t is to declare Terra variables

'''Terra
    gvar b : int32 = 42
'''

This statement will declare normal Terra global variable

'''Terra
    terra main()
        c.printf("%d", b) -- 42
    end
'''

The gvar can be decalred without any value

'''Terra
    gvar c : int8; 
'''

Or without type:

'''Terra
    gvar d = 12.5
'''
