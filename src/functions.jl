function f(x, y)
    x + y  # por defecto se devuelve la última expresión de la función.
    # Puede usarse la palabra clave `return`.
end

∑(x, y) = x + y
f₂ = (x, y) -> x + y # más usado con funciones anónimas (lambdas)

arcane_computation(x, y, z) = begin
    # increiblemente complejo...
    nothing
end

"""
Las docstrings van encima de la función.

Podemos indicar el tipo de salida con '::'
"""
function g(a::Int64)::Float32
    Float32(a)
end

# multiple dispatch
function g(x::String)::String
    x + "!"
end

# broadcasting
A = [1 2 3 4]
B = [5 6 7 8]
A .+ B # suma elemento a elemento
sin.(A) # función 'sin' aplicada sobre cada elemento de A

# composición y canalización
f(x) = 2*x # no dará error, multiple dispatch!
(sqrt ∘ +)(3, 6) == 3.0
A |> f .|> sin === sin.(f(A))

# desestructuración
minmax(x, y) = (y < x) ? (y, x) : (x, y)
gap((min, max)) = max - min

using Test
@test gap(minmax(2, 10)) == 8
# argumentos variables
h(a, b, c...) = (a,b,c)

# tuplas
x = (1, "2", 3)
x = 1, "2", 3 # es lo mismo
x[2] == "2" # true
x = (a="foo", b="bar") # named tuple
x.a # "foo"
