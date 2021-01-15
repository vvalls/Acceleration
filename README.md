# Acceleration.jl

This repository contains a Julia package with multiple accelerated algorithms for distributed learning. The following is quick example of how to use the package:

```julia
using Acceleration

num_samples = 1000;
num_features = 100;
labels = [0,1]
dataset = "CIFAR-10" #MNIST, FashionMNIST, CIFAR-10

data, labels = load_dataset(dataset,labels,num_samples,num_features);
f,∇f,∇ϕ_cjg,σ,L,μ  = linear_regression(data,labels);

k = 1000
x_ini = zeros(num_features)

function gradient_fun(x)
    return ∇f(x), 0
end

@time f_y = ufom(f,gradient_fun,∇ϕ_cjg,x_ini,σ,L,μ,k,Inf,false)[end]
```

See the Jupyter notebook "ICML Experiments" for several examples on how to use the accelerated algorithms with different ML models and datasets.
