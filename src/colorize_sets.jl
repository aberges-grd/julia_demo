using Images  # for RGB
using ColorSchemes

using JLD2


function render_2d()
    cs = ColorSchemes.curl
    scaler(X) = (X .- minimum(X))/(maximum(X) - minimum(X))
    colorizer(x) = ifelse(x == 1.0, RGB(0, 0, 0), cs[x]) # B/N
    J = load("mandelbrot_set.jld", "J_f")
    save("mandelbrot_set.png", J  .|> log1p |> scaler .|> colorizer)
end

render_2d()