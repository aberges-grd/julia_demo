using Images  # for RGB
using ColorSchemes

using JLD2


function render_2d()
    # cs = ColorSchemes.diverging_rainbow_bgymr_45_85_c67_n256
    # colorizer(x) = cs[x]
    ϵ = 0.0058
    scaler(X) = (X .- minimum(X))/(maximum(X) - minimum(X))
    colorizer(x) = ifelse(x < ϵ, RGB(0, 0, 0), RGB(1,1,1)) # B/N
    J = load("julia_sets.jld", "J_f")
    save("julia_set.png", J .|> colorizer)
end

render_2d()