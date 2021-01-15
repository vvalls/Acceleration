using LinearAlgebra
using JuMP
using Ipopt
using SCS
using Convex

function logistic_regression(data,labels,λ)

    m = size(data,1)
    n = size(data,2)

    A = data; b = labels;

    # f(x) = |Ax - b|^2
    function f(x)
        return sum(log.(1 .+ exp.(-b.*(A*x)))) + (λ/2)*norm(x,2)^2
    end

    function ∇f(x)
        return ((exp.(-b.*A*x) ./ (1 .+ exp.(-b.*A*x)) )'*(-b.*A))'[:,1] + λ*x
    end

    # ϕ = 0.5*|z|^2
    function ∇ϕ_cjg(z)
        return z;
    end

    L = eigvals(A'*A)[n];         # largest eigenvalue
    μ = eigvals(A'*A)[1];         # smallest eigenvalue
    σ = 1;

    return f,∇f,∇ϕ_cjg,σ,L,μ

end

function logistic_regression_compute_optval(A,b,λ)

    # solve the logistic regression problem
    m, n = size(A)
    x = Variable(n)
    problem = minimize(logisticloss(-b.*(A*x)) + (λ/2)*sumsquares(x))
    solve!(problem, SCS.Optimizer(verbose=false))

    return x.value;

end
