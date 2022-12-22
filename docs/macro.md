<!-- macro.md -->

# macro.t - a language for macro definition

It is a big problem to define macro in Terra. For creating  macro 
we have to rely on lengthy sequence:

'''Terra
    local a = macro( 
    function() 
        return quote 
            c.printf"Hello" 
        end
    end)
'''
To add macro to methods of struct we have to rely on even longer sequence:

'''Terra
    struct T{
        a : int;
    }
    T.methods.print = macro(function(self)
        return quote
            c.printf("%d", self.a)
        end
    end)
'''
It's very long and unreadable and that is not a problem with macro.t! By using the language extension we can shorten
macro declaration and make it more readable!

'''Terra
    local macro a()
        return quote
            c.printf"Hello"
        end
    end
'''

Also we can define macros in tables

'''Terra
    local P = {
    }
    macro P.print()
        return quote
            c.printf("%f ", 3.14)
        end
    end
'''

Or define methods with method operator!

'''Terra
    local P = {
        e = 2.73
    }
    macro P:print()
        return quote
            c.printf("%f ", self.e)
        end
    end
'''

Now we don't need to rely on verbose definition! However we still have to return 
quote don't forget about it!

'''Terra
    macro b()
        c.printf("b") -- will return error
    end
'''

