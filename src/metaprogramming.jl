# Al igual que LISP, julia representa su propio código como una estructura de datos
# en el propio lenguaje (homoicónico). Esto permite que el código de julia sea 
# manipulado por los propios programas, permitiendo la metaprogramación.
a = :s
ex1 = :(a+b)
ex2 = Expr(:call, :+, :a, :b) # :(a+b)
ex1 == ex2 # true

typeof(a)  # Symbol
typeof(ex) # Expr

dump(ex1)

ex3 = quote
    x = 1
    y = 2
    x+y
end

# se pueden interpolar valores en expresiones
a = 1
ex = :($a + b) # :(1+b)

# nuestra primera macro!
macro sayhello(name)
    return :( println("Hello, $name") )
end

@sayhello("human")  # Hello, human

macro assert(ex)
    return :( $ex ? nothing : throw(AssertionError($(string(ex)))))
end

@assert 1 == 0