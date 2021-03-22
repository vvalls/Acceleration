# Acceleration.jl

This repository contains a Julia package with multiple first-order algorithms for convex programs. The following is quick example of how to use the package:

```julia
using Acceleration

m = 500; # number of samples
n = 20;  # number of variables/features

labels = [0,1]
dataset = "CIFAR-10" #MNIST, FashionMNIST, CIFAR-10
data, labels, m, n = load_dataset(dataset,labels,m,n);

f,oracle,∇ϕ_cjg,σ,L,μ  = linear_regression(data,labels);
x_0 = zeros(n);
k = 1000;

f_star = AGM(f,oracle,∇ϕ_cjg,x_0,σ,L,μ,3*k).optval;
p = AGM(f,oracle,∇ϕ_cjg,x_0,σ,L,μ,k).fs .-f_star;

using Plots
plot(max.(p,1e-12), yaxis=:log, xlabel="k", ylabel="f(y)- f*")
```

## Functions

### Loading datasets
```julia
data, labels, m, n = load_dataset(dataset,labels,m,n);
```
where ```dataset ∈ {MNIST, FashionMNIST, CIFAR-10}```.  
