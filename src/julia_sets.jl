import Pkg;
Pkg.instantiate();
using JLD2

module JuliaSets

export f, f_prime, escape_time, set_distance

# f_c(c::Complex) = z::Complex -> z^2 + c
f(z::Complex, c::Complex) = z^2 + c
f_prime(z::Complex, dz::Complex) = 2 * z * dz

function escape_time(f::Function, z::Complex, maxiter::Int64=10^3)::Int64
    for n = 1:maxiter
        if (abs(z) > 2)
            return n
        end
        z = f(z)
    end
    return maxiter
end

function set_distance(f::Function, fprime::Function, z0::Complex, maxiter::Int64=1000)
    dz = 1.0 + 0.0im
    z = z0
    for _ = 1:maxiter
        z, dz = f(z), fprime(z, dz)
        if abs(z) > 2
            break
        end
    end

    h = 0.5 * log(abs(z)) * sqrt(abs(z) / abs(dz))
    return clamp(h*250, 0.0, 1.0)
end

end

parameters = (
    n=1600 * 2, # 3200
    m=925 * 2, # 1850
    c=-0.770826391 + 0.115528513im,
    N=600,
    width=[-1.65 1.65],
)

using .JuliaSets

function main(parameters::NamedTuple)::Nothing
    n, m, c, N, width = parameters
    height = width * m / n

    complex_grid = [complex(a, b)
                    for a in range(width[1], length=n, stop=width[2]),
                    b in range(height[1], length=m, stop=height[2])]

    # precompile
    @time (complex_grid[1:5, 1:5] .|> z -> set_distance(z -> f(z, c), f_prime, z, N))'
    # compute
    @time J_f = (complex_grid .|> z -> set_distance(z -> f(z, c), f_prime, z, N))'

    print("\nmax = $(maximum(J_f)) \n min = $(minimum(J_f))")
    jldsave("julia_sets.jld"; J_f)
    nothing
end

main(parameters)