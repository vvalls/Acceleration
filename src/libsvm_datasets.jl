using MLDatasets
using DataFrames
using RDatasets
using DelimitedFiles

function load_libsvm_dataset(dataset_name, num_samples)

    loaded_data = []; loaded_labels = [];

    if(dataset_name == "a5a") # Number of samples not applied here. Add as optional in the function argument
        loaded_data = readdlm("../datasets/a5a_data.txt", Float64);
        loaded_labels = readdlm("../datasets/a5a_labels.txt", Float64);
    elseif(dataset_name == "mushrooms") # Number of samples not applied here. Add as optional in the function argument
        loaded_data = readdlm("../datasets/mushrooms_data.txt", Float64);
        loaded_labels = readdlm("../datasets/mushrooms_labels.txt", Float64);
    else
        @warn("Dataset doesn't exists.")
    end

    m,n = size(loaded_data);
    n_samples = min(m,num_samples)
    data = loaded_data[1:n_samples,:];
    labels = loaded_labels[1:n_samples];

    @info(string("Loading dataset ",dataset_name," with ", n_samples, " samples (out ouf ", m ,") and ", n ," features"))

    return data, labels

end
