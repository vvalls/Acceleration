using LinearAlgebra
using JuMP
using Ipopt
using SCS
using Convex

function logistic_regression_vr(data,labels,λ,mini_batch)

    m = size(data,1)
    n = size(data,2)

    A = data; b = labels;

    function f(x)
        return sum(log.(1 .+ exp.(-b.*(A*x)))) + (λ/2)*norm(x,2)^2
    end

    function ∇f(x)
        indexes = Int16.(ceil.(rand(mini_batch)*m));
        grad = zeros(n);
        for i=1:mini_batch
            lbl = indexes[i]
            dat = A[i,:]
            grad = grad + exp(-lbl*dat'*x)/(1 .+ exp(-lbl*dat'*x))*(-lbl.*dat);
        end
        return grad + λ*x;
    end

    # ϕ = 0.5*|z|^2
    function ∇ϕ_cjg(seq)
        return (seq.s .+ seq.μ*seq.AX)*inv(seq.σ + seq.μ*seq.A);
    end

    L = eigvals(A'*A)[n];         # largest eigenvalue
    μ = eigvals(A'*A)[1];         # smallest eigenvalue
    σ = 1;

    return f,∇f,∇ϕ_cjg,σ,L,μ

end

function logistic_regression_compute_optval_vr(A,b,λ)

    # solve the logistic regression problem
    m, n = size(A)
    x = Variable(n)
    problem = minimize(logisticloss(-b.*(A*x)) + (λ/2)*sumsquares(x))
    solve!(problem, SCS.Optimizer(verbose=false))

    return x.value;

end
