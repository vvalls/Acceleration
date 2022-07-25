# Acceleration.jl

This repository contains a Julia package with multiple first-order methods (FOMs) to solve convex programs. The package allows users to load a convex program and choose the subroutines that estimates gradients (e.g., data sampling).

$$
\text{\textbf{First-Ordet Method} (Objective, Oracle, Parameters)}
$$

* ***Objective***: This is the mathematical function to optimize. The meaning of the function depends on the context; for example, a loss function in learning problems, or a utility function in network resource allocation. 
* ***Oracle:*** This is the subroutine that estimates gradients. The choice of subroutine is problem dependent and affects the *total* running time of the numerical method. 
* ***Parameters:*** These are problem and optimization parameters (e.g., the smoothness of the objective or the termination criteria of the numerical method). 


### Quick example

```julia
# Linear regression problem with CIFAR-10 dataset
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

## 1. Loading programs

The following are a few examples of how to create problems models. Some functions take as input a ```data``` matrix and a vector of ```labels```. 

### Quadratic program

The function ```quadratic_program``` generates a quadratic function $f(x) = x^T A^T A x$ where $A \in \mathbf R^{m \times n}$ matrix. The entries of $A$ are generated uniformly at random. 

```julia
f,oracle,∇ϕ_cjg,σ,L,μ  = quadratic_program(m,n)
```
where ```m``` and ```n``` are integers.

### Linear regression

The function ```linear_regression``` generates a loss function of the form $f(x) = || Ax - b \||^2$ where $A$ is the input data matrix, and $b$ the labels.
```julia
f,oracle,∇ϕ_cjg,σ,L,μ  = linear_regression(data,labels)
```
### Logistic regression
```julia
f,oracle,∇ϕ_cjg,σ,L,μ = logistic_regression(data,labels,λ);
```
where ```data``` is an ```m``` by ```n``` data matrix, ```labels``` a ```n```-dimensional vector, and ```λ``` a non-negative scalar. 

### Datasets

Image datasets:

```julia 
data, labels, m, n = load_dataset(dataset,labels,num_samples,num_features);
```
where ```dataset ∈ {"MNIST", "FashionMNIST", "CIFAR-10"}```. It is possible to select the ```labels``` to use in the data set, and the number of samples ```m``` and features ```n``` to load (i.e., we may load just a few data samples from the data set). 

The LIBSVM datasets:

```julia
data, labels = load_libsvm_dataset("mushrooms",1000);
``` 
where ```dataset ∈ {"mushrooms", "a5a"}```. The original mushroom and a5a datasets (https://www.csie.ntu.edu.tw/~cjlin/libsvmtools/datasets/) have been formtted in a matrix form. 



## 2. First-Order Methods

The package contains multiple first-order methods. The algorithms' inputs are:

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

### (μ)Accelerated Mirror Descent
This algorithm was proposed by Cohen et al. at ICML 2018 ([link](http://proceedings.mlr.press/v80/cohen18a/cohen18a.pdf)) for miniming L-smooth convex functions. 
```julia
AMD_plus(f,oracle,∇ϕ_cjg,x_0,σ,L,k)
```
For L-smooth and μ-strongly convex function the algorithm is:
```julia
μAMD_plus(f,oracle,∇ϕ_cjg,x_0,L,μ,k)
```

### Accelerated Gradient Method
```julia
AGM(f,oracle,∇ϕ_cjg,x_0,σ,L,μ,k)
```
## 3. Oracles
We can load different oracles:
1.  Gaussian Noise
2.  Random Sparsification
3.  Random Dithering
4.  Natural Compression

Load the oracle with: 
```julia
include("../src/oracles.jl");
```
and set the oracles directly:   
```
oracle_fun = random_sparsification; # random_sparsification
oracle_fun = oracle; # exact gradients
oracle_fun = dithering; # random dithering
oracle_fun = natural_compression; # natural compression
```
Call the first-order method in the example above with: 
```
f_star = AGM(f,oracle_fun,∇ϕ_cjg,x_0,σ,L,μ,3*k);
```


# Acknowledgements

This work has received funding from the European Union’s Horizon 2020 research and innovation programme under the Marie Skłodowska-Curie grant agreement No. 795244.
