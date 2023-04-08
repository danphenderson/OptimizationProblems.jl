export biggs5

function biggs5(;
  n::Int = default_nvar,
  type::Val{T} = Val(Float64),
  m::Int = 13,
  kwargs...,
) where {T}
  m = max(6, m)
  z = [i // 10 for i = 1:m]
  y = T[exp(-zi) - 5 * exp(-10 * zi) + 3 * exp(-4 * zi) for zi in z]
  function f(x; m = m, z = z, y = y)
    si = sum(y[i] for i = 1:m)
    return sum(
      +x[3] * exp(-x[1] * z[i]) - x[4] * exp(-x[2] * z[i]) + 3 * exp(-x[5] * z[i]) for i = 1:m
    ) - eltype(x)(si)
  end
  x0 = ones(T, 5)
  x0[2] = 2
  lvar = vcat(-T(Inf) * ones(T, 5), T(3))
  uvar = vcat(T(Inf) * ones(T, 5), T(3))
  return ADNLPModels.ADNLPModel(f, x0, lvar, uvar, name = "biggs5"; kwargs...)
end