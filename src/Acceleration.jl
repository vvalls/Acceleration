module Acceleration

    using Clp
    using Ipopt

    function __init__()

    end

    include("first_order_algorithms.jl")
    include("datasets.jl")
    include("libsvm_datasets.jl")

    include("linear_regression.jl")
    include("logistic_regression.jl")
    include("svm.jl")
    include("perceptron.jl")
    include("rand_psd.jl")

    ### Algorithms functions
    export MD
    export GD
    export PGD_avg
    export AMD_plus
    export μAMD_plus
    export ufom
    export ACGD
    export μACGD
    export Nesterov83

    ### Dataset functions
    export load_dataset
    export load_libsvm_dataset

    ### ML models
    # Linear regression
    export linear_regression
    export linear_regression_compute_optval

    # SVM
    export svm_setup
    export svm_compute_optval
    export svm_plot

    # Perceptron
    export perceptron_setup
    export perceptron_compute_optval
    export perceptron_plot

    # Logistic linear_regression
    export logistic_regression
    export logistic_regression_compute_optval

    # Random PSD
    export rand_psd
    export rand_psd_compute_optval
end # module
