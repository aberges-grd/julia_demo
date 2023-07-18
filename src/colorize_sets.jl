using Images  # for RGB
using ColorSchemes

using JLD2


function render_2d()
    ϵ = 0.0058
    cs = ColorSchemes.curl
    colorizer(x) = ifelse(x < ϵ, RGB(0, 0, 0), cs[x])
    # scaler(X) = (X .- minimum(X))/(maximum(X) - minimum(X))
    scaler(x) = 0.6 + 0.4 * cos(log(log1p(x)) * 0.5)
    # colorizer(x) = ifelse(x < ϵ, RGB(0, 0, 0), RGB(1,1,1)) # B/N
    J = load("julia_sets.jld", "J_f")
    save("julia_set_d.png", J)
end

render_2d()