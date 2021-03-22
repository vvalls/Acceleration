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

## Package functions

### Datasets

#### Image datasets
```julia
data, labels, m, n = load_dataset(dataset,labels,m,n);
```
where 
```dataset ∈ {"MNIST", "FashionMNIST", "CIFAR-10"}```. It is possible to select the ```labels``` to use in the data set, and the number of samples ```m``` and features ```n```.

#### LIBSVM datasets

```julia
data, labels = load_libsvm_dataset("mushrooms",1000);
```
where ```dataset ∈ {"mushrooms", "a5a"}```.

### Problem models

#### Linear regression

```julia
f,oracle,∇ϕ_cjg,σ,L,μ  = linear_regression(data,labels)
```
#### Logistic regression
```julia
f,oracle,∇ϕ_cjg,σ,L,μ = logistic_regression(data,labels,λ);
```

### First-Order algorithms
The algorithms return an object ```Sequence```. The optimal value can be accessed through the field ```optval```. The sequence of approximate solutions can be accessed through the field ``fs``.
#### Mirror-Descent
```julia
MD(f,oracle,∇ϕ_cjg,x_0,σ,L,k)
```
#### Accelerated Mirror Descent
This algorithm was proposed by Cohen et al. at ICML 2018 ([paper](http://proceedings.mlr.press/v80/cohen18a/cohen18a.pdf)).
```julia
AMD_plus(f,oracle,∇ϕ_cjg,x_0,σ,L,k)
```

#### μAccelerated Mirror Descent (μ-strongly convex objectives)
```julia
μAMD_plus(f,oracle,∇ϕ_cjg,x_0,L,μ,k)
```

#### Accelerated Gradient Method 
```julia
AGM(f,oracle,∇ϕ_cjg,x_0,σ,L,μ,k)
```
