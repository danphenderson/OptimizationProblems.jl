export hs60

function hs60(; n::Int = default_nvar, type::Type{T} = Float64, kwargs...) where {T}
  function f(x)
    n = length(x)
    return (x[1] - 1)^2 + (x[1] - x[2])^2 + (x[2] - x[3])^4
  end
  x0 = 2 * ones(T, 3)
  lvar = -10 * ones(T, 3)
  uvar = 10 * ones(T, 3)
  function c!(cx, x)
    cx[1] = x[1] * (1 + x[2]^2) + x[3]^4 - 4 - 3 * sqrt(2)
    return cx
  end
  lcon = ucon = T[0]
  return ADNLPModels.ADNLPModel!(f, x0, lvar, uvar, c!, lcon, ucon, name = "hs60"; kwargs...)
end
