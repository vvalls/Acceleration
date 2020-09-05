module Acceleration

    using Clp
    using Ipopt

    function __init__()

    end

    include("first_order_algorithms.jl")
    include("linear_regression.jl")
    include("datasets.jl")
    
    export mirror_descent
    export gradient_descent
    export accelerated_mirror_descent
    export SCVX_AMD
    export linear_regression
    export load_dataset

end # module
