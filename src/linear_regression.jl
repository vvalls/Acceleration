using LinearAlgebra

function linear_regression(data,labels)

    m = size(data,1)
    n = size(data,2)

    A = data; b = labels;

    # f(x) = |Ax - b|^2
    function f(x)
        return 0.5*(A*x-b)'*(A*x-b)
    end

    function ∇f(x)
        return (A'*A)*x - A'*b;
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
