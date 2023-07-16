using Images

f_c(c::Complex) = z::Complex -> z^2 + c

n = 1600 * 2 # 3200
m = 925 * 2 # 1850
c = -0.77146 - 0.10119im
N = 1000
width = [-1.65 1.65]
height = width * m / n

complex_grid = [complex(a, b)
                for a in range(width[1], length=n, stop=width[2]),
                b in range(height[1], length=m, stop=height[2])];

function julia_set(f::Function, grid, maxiter=10^3)
    n_matrix = zeros(size(grid))
    p = 0
    for point in grid
        p += 1
        n = 0
        while (abs(point) <= 2 && n < maxiter)
            point = f(point)
            n += 1
        end
        n_matrix[p] = n
    end
    return n_matrix
end

# compute
J_f = julia_set(f_c(c), complex_grid, N)'

save("julia_set.png", (J_f .% 10) ./ 10)