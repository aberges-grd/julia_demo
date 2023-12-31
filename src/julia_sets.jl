using Images
using ColorSchemes

module JuliaSets

export f_c, escape_time

f_c(c::Complex) = z::Complex -> z^2 + c

function escape_time(f::Function, z::Complex, maxiter::Int64=10^3)::Int64
    for n = 1:maxiter
        if (abs(z) > 2)
            return n
        end
        z = f(z)
    end
    return maxiter
end

end

parameters = (
    n=1600 * 2, # 3200
    m=925 * 2, # 1850
    c=-0.77146 - 0.10119im,
    N=3000,
    width=[-1.65 1.65],
)

using .JuliaSets

function main(parameters::NamedTuple)::Nothing
    n, m, c, N, width = parameters
    height = width * m / n

    complex_grid = [complex(a, b)
                    for a in range(width[1], length=n, stop=width[2]),
                    b in range(height[1], length=m, stop=height[2])]

    # compute
    f = f_c(c)
    @time J_f = (complex_grid .|> z -> escape_time(f, z, N))'
    
    cs = ColorSchemes.diverging_rainbow_bgymr_45_85_c67_n256
    scale(X) = X / maximum(X)
 
    save("julia_set.png", J_f .|> log1p |> scale .|> x -> ifelse(x == 1, RGB(0, 0, 0), get(cs, x)))
    nothing
end

main(parameters)