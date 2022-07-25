module Acceleration

    using Clp
    using Ipopt

    function __init__()

    end

    include("first_order_algorithms.jl")



    #include("oracles.jl")
    include("libsvm_datasets.jl")
    include("logistic_regression.jl")
    include("linear_regression.jl")

    ### Algorithms functions
    export MD
    export GD
    export PGD_avg
    export AMD_plus
    export μAMD_plus
    export AGM
    export ACGD
    export μACGD
    export Nesterov83
    export VBS19


    ### oracles
    #export exact_oracle
    #export stochastic_oracle

    ### Dataset functions
    export load_dataset
    export load_libsvm_dataset

    ### ML models
    # Linear regression
    export linear_regression
    export logistic_regression


end # module
