# Acceleration.jl

This repository contains a Julia package with multiple first-order algorithms for solving (non)-convex programs. The following is quick example of how to use the package:

```julia
using Acceleration

num_samples = 500;
num_features = 20;
labels = [0,1]
dataset = "CIFAR-10" #MNIST, FashionMNIST, CIFAR-10
data, labels, m, n = load_dataset(dataset,labels,num_samples,num_features);

f,oracle,∇ϕ_cjg,σ,L,μ  = linear_regression(data,labels);
x_0 = zeros(n);
k = 10000;

f_star = AGM(f,oracle,∇ϕ_cjg,x_0,σ,L,2*k).optval;
p = AGM(f,oracle,∇ϕ_cjg,x_0,σ,L,μ,k).fs .-f_star;

using Plots
plot(p, yaxis=:log, xlabel="k", ylabel="f(y)- f*")
```

See the Jupyter notebook "ICML Experiments" for several examples on how to use the algorithms with different ML models and datasets.
