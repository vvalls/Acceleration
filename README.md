# Acceleration.jl

This repository contains a Julia package with multiple first-order algorithms for convex programs. The following is quick example of how to use the packaget to solve a linear regression problem:

```julia
using Acceleration

num_samples = 500;  # number of data samples
num_features = 20;  # number of variables/features

labels = [0,1]
dataset = "CIFAR-10"
data, labels, m, n = load_dataset(dataset,labels,num_samples,num_features);

f,oracle,∇ϕ_cjg,σ,L,μ  = linear_regression(data,labels);
x_0 = zeros(n);
k = 1000;

f_star = AGM(f,oracle,∇ϕ_cjg,x_0,σ,L,μ,3*k).optval;
p = AGM(f,oracle,∇ϕ_cjg,x_0,σ,L,μ,k).fs .-f_star;

using Plots
plot(max.(p,1e-12), yaxis=:log, xlabel="k", ylabel="f(y)- f*")
```

# Functions

## Problem Models

The following are a few examples of how to create problems models. Some models take as input a ```data``` matrix and a vector of ```labels```. 

### Unconstrained quadratic program
```julia
f,oracle,∇ϕ_cjg,σ,L,μ  = quadratic_program(m,n)
```

### Linear regression

```julia
f,oracle,∇ϕ_cjg,σ,L,μ  = linear_regression(data,labels)
```
### Logistic regression
```julia
f,oracle,∇ϕ_cjg,σ,L,μ = logistic_regression(data,labels,λ);
```

***Image datasets:*** ```data, labels, m, n = load_dataset(dataset,labels,num_samples,num_features);```
where ```dataset ∈ {"MNIST", "FashionMNIST", "CIFAR-10"}```. It is possible to select the ```labels``` to use in the data set, and the number of samples ```m``` and features ```n```.

***LIBSVM datasets:*** ```data, labels = load_libsvm_dataset("mushrooms",1000);``` where ```dataset ∈ {"mushrooms", "a5a"}```.



## First-Order Algorithms
The algorithms take as ***inputs***:
1. ```f```: The objective function to minimize
2. ```oracle```: A procedure that returns a (sub)gradient of ```f``` at the queried point
3. ```∇ϕσ_cjg```: The dual projection function. 
4. ```x_0```: The initial vector
5. ```σ```: The strong convexity parameter of the prox-function ϕ
6. ```L```: Smoothness parameter of the objective function
7. ```μ```: Strong-convexity parameter of the objective function
8. ```k```: The number of iterations the algorithm will run

The algorithms ***output*** is an object of the type ```Sequence```. The optimal value can be accessed through the field ```optval```. The sequence of approximate solutions can be accessed through the field ``fs``.
### Mirror-Descent
```julia
MD(f,oracle,∇ϕ_cjg,x_0,σ,L,k)
```

### Accelerated Mirror Descent
This algorithm was proposed by Cohen et al. at ICML 2018 ([link](http://proceedings.mlr.press/v80/cohen18a/cohen18a.pdf)) for miniming L-smooth convex functions. 
```julia
AMD_plus(f,oracle,∇ϕ_cjg,x_0,σ,L,k)
```

### μAccelerated Mirror Descent
```julia
μAMD_plus(f,oracle,∇ϕ_cjg,x_0,L,μ,k)
```

### Accelerated Gradient Method
```julia
AGM(f,oracle,∇ϕ_cjg,x_0,σ,L,μ,k)
```
## Oracles
We can load different oracles that use the ```oracle``` defined earlier. 
```julia
include "oracles.jl"
```
1.  Gaussian Noise
2.  Random Sparsification
3.  Random Dithering
4.  Natural Compression
