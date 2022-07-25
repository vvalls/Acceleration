using MLDatasets
using DataFrames
using RDatasets
using DelimitedFiles

function load_dataset(dataset, labels_subset, num_samples, num_features)

    loaded_data = []; loaded_labels = [];

    if(dataset == "MNIST")
        loaded_data, loaded_labels = MNIST.traindata()
    elseif(dataset == "FashionMNIST")
        loaded_data, loaded_labels = FashionMNIST.traindata()
    elseif(dataset == "CIFAR-10")
        loaded_data, loaded_labels = CIFAR10.traindata()
    elseif(dataset == "CIFAR-100")
        loaded_data, loaded_labels = CIFAR100.traindata()
    elseif(dataset == "SVHN-2")
        loaded_data, loaded_labels = SVHN2.traindata()
    elseif(dataset == "Iris") # Number of samples not applied here. Add as optional in the function argument
        iris = RDatasets.dataset("datasets", "iris")
        labels = [species == "versicolor" ? 1.0 : -1.0 for species in iris.Species]
        data = hcat(ones(size(iris, 1)), iris.SepalLength, iris.SepalWidth, iris.PetalLength, iris.PetalWidth);
        return data, labels
    elseif(dataset == "a5a") # Number of samples not applied here. Add as optional in the function argument
        data = readdlm("../datasets/a5a_data.txt", Float64);
        labels = readdlm("../datasets/a5a_labels.txt", Float64);
        #iris = RDatasets.dataset("datasets", "iris")
        #labels = [species == "versicolor" ? 1.0 : -1.0 for species in iris.Species]
        #data = hcat(ones(size(iris, 1)), iris.SepalLength, iris.SepalWidth, iris.PetalLength, iris.PetalWidth);
        return data, labels, m, n
    else
        loaded_data, loaded_labels = MNIST.traindata()
        @warn("Dataset doesn't exists. Loading MNIST instead.")
    end

    filtered_data = []; filtered_labels = [];
    total_samples = size(loaded_data)[end]
    loaded_data = reshape(loaded_data,:,total_samples)

    @info(string("Loading dataset ",dataset," with ", size(loaded_data,2), " samples and ", size(loaded_data,1) ," features"))

    for i=1:min(num_samples,total_samples)
        if(loaded_labels[i] in labels_subset)
            filtered_data = vcat(filtered_data, loaded_data[:,i])
            filtered_labels = vcat(filtered_labels,loaded_labels[i])
        end
    end

    n = length(filtered_labels);
    samples = reshape(filtered_data,:,n)
    labels = Float64.(filtered_labels)
    labels = sign.(labels .- sum(labels_subset)/2);

    ### PCA for dimensionality reduction
    X = samples .- (1/n)*sum(samples, dims=2);
    F = svd(1/(n-1) * X*X')
    E = F.Vt
    PC = E[1:num_features,:]'
    data = Float64.(PC'*samples)'

    m, n =  size(data)

    return data, labels, m, n

end
