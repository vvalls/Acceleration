using MLDatasets

function load_dataset(dataset, labels_subset, num_samples, num_features)

    loaded_data, loaded_labels = FashionMNIST.traindata()
    loaded_data = reshape(loaded_data, :, size(loaded_data)[end])

    #==>
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
    else
        loaded_data, loaded_labels = MNIST.traindata()
    end
    <==#

    #loaded_data = readdlm("data/mnist_data.txt")[:,1:num_samples];
    #loaded_labels = Int16.(readdlm("data/mnist_labels.txt"));

    filtered_data = []; filtered_labels = [];

    for i=1:num_samples
        if(loaded_labels[i] in labels_subset)
            filtered_data = vcat(filtered_data, loaded_data[:,i])
            filtered_labels = vcat(filtered_labels,loaded_labels[i])
        end
    end

    n = length(filtered_labels);
    samples = reshape(filtered_data,:,n)
    labels = Float64.(filtered_labels)

    ### PCA for dimensionality reduction
    X = samples .- (1/n)*sum(samples, dims=2);
    F = svd(1/(n-1) * X*X')
    E = F.Vt
    PC = E[1:num_features,:]'
    data = Float64.(PC'*samples)'

    return data, labels

end
