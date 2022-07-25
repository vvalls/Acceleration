using LinearAlgebra

function stochastic_oracle(x)
    n = size(x,1);
    ξ = 1/2;
    noise = randn(n);
    noise = noise / norm(noise,2);
    noise = noise*ξ;
    return (oracle(x) + noise)
end

function binary_oracle(x)
    η = -∇f(x) + sign.(oracle(x)) .* (abs.(oracle(x)) .> norm(oracle(x),Inf)/2) .* norm(oracle(x),Inf)/2;
    return oracle(x) + η
end

function random_sparsification(x)
    grad = oracle(x)
    n = size(grad,1)
    r = 1/4
    mask = Float64.(rand(n) .< r)
    rs_gradient = (1/r)*grad.*mask
    return rs_gradient
end

function dithering(x)
    q = Inf;
    grad = oracle(x)
    n = size(grad,1)
    levels = 10;
    leveled_gradient = sign.(grad).*(levels/norm(grad,q)).*grad/2
    base = floor.(leveled_gradient)
    rv = Float64.(rand(n) .> (leveled_gradient .- floor.(leveled_gradient)))
    quantized_gradient = sign.(grad).*(base .+ rv)*norm(grad,q)/levels*2;

    return quantized_gradient
end

function natural_compression(x)

    grad = oracle(x)
    n = size(grad,1)
    nat_grad = sign.(grad).*2.0.^(floor.(log2.(abs.(grad)))).*(1 .+ rand(n))

    return nat_grad
end
