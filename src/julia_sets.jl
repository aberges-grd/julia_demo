using JLD2

module JuliaSets

export f, f_prime, escape_time, set_distance

# f_c(c::Complex) = z::Complex -> z^2 + c
f(z::Complex, c::Complex) = z^2 + c
f_prime(z::Complex, dz::Complex) = 2 * z * dz + 1

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
    for n = 1:maxiter
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
    m=1000 * 2,
    N=1000,
    width=[-2.5 1],
    height=[-1.25 1.25]
)

using .JuliaSets

function main(parameters::NamedTuple)::Nothing
    n, m, N, width, height = parameters
    # height = width * m / n

    zero = 0.0 + 0.0im
    complex_grid = [complex(a, b)
                    for a in range(width[1], length=n, stop=width[2]),
                    b in range(height[1], length=m, stop=height[2])]

    # precompile
    # @time (complex_grid[1:5, 1:5] .|> z -> set_distance(z -> f(zero, z), f_prime, z, N))'
    # compute
    # @time J_f = (complex_grid .|> c -> set_distance(z -> f(z, c), f_prime, zero, N))'
    @time J_f = (complex_grid .|> c -> escape_time(z -> f(z, c), zero, N))'

    jldsave("mandelbrot_set.jld"; J_f)
    nothing
end

main(parameters)