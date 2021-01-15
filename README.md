# Acceleration

This repository contains the Julia implementation of multiple accelerated algorithms used for distributed learning. The following is quick example on how to use the package:

```julia
using Acceleration
data, labels = load_dataset("MNIST",[0,1],1000,100);
f,∇f,∇ϕ_cjg,σ,L,μ  = linear_regression(data,labels);

k = 1000
m,n = size(data)
x_ini = zeros(n)

function gradient_fun(x)
    return ∇f(x), 0
end

@time opt_val = ufom(f,gradient_fun,∇ϕ_cjg,x_ini,σ,L,μ,k,Inf,false)[end]
```



See the Jupyter notebook "ICML Experiments" for several examples of using the different algorithms with different ML models and datasets.
