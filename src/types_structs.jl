x::Int8 = 10 # la sintaxis '::' sirve para declarar el tipo de una
# variable, parámetro o función.
struct Foo
    bar  # por defecto, su tipo será "Any"
    baz::Int
    qux::Float64
end

foo = Foo(:anything, 1, 1.0)
foo.bar
foo.bar = "something else" # error!

# tipo mutable (con un campo inmutable)
mutable struct Bar
    baz
    const qux::Float64
end
# tipo paramétrico
struct Point{T}
    x::T
    y::T
end
# Otro constructor para Point:
Point(x) = Point(x, x)
# uniones de tipos
IntOrString = Union{Int,AbstractString}

# más sobre constructores
struct OrderedPair
    x::Real
    y::Real
    OrderedPair(x, y) = x > y ? error("out of order") : new(x, y)
end

struct OurRational{T<:Integer} <: Real
    num::T
    den::T
    function OurRational{T}(num::T, den::T) where {T<:Integer}
        if num == 0 && den == 0
            error("invalid rational: 0//0")
        end
        num = flipsign(num, den)
        den = flipsign(den, den)
        g = gcd(num, den)
        num = div(num, g)
        den = div(den, g)
        new(num, den)
    end
end
