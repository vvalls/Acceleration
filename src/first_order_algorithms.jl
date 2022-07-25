mutable struct Sequences
    L
    μ
    σ
    x
    y
    α
    s
    A
    AX
    X
    fs
    optval
    norm_∇f
end

### Mirror descent
function MD(f,oracle,∇ϕ_cjg,x_0,σ,L,k);
    n = length(x_0)
    x = x_0;
    s = zeros(n);
    A = 0;
    seq = Sequences(L,0,σ,zeros(n,k),zeros(n,k),zeros(k),0,0,zeros(n),zeros(n),Inf*ones(k),Inf,0)

    for i=1:k
        α = (σ/L)*inv(sqrt(i));
        A = A + α;
        ∇f = oracle(x)
        s = s - α*∇f;
        x = ∇ϕ_cjg(seq);
        y = x;

        seq.x[:,i] = x; seq.y[:,i] = y; seq.α[i] = α; seq.s = s;
        seq.A = A; seq.AX = seq.AX + α*x; seq.X = seq.X + x;
        seq.fs[i] = f(y); seq.optval = f(y); seq.norm_∇f = ∇f'*∇f;
    end
    return seq;
end


### Gradient descent
function GD(f,oracle,x_0,σ,L,k)
    n = length(x_0)
    x = x_0;
    seq = Sequences(L,0,σ,zeros(n,k),zeros(n,k),zeros(k),0,0,zeros(n),zeros(n),Inf*ones(k),Inf,0)

    for i=1:k
        α = (σ/L);
        ∇f = oracle(x)
        x = x - α*∇f;
        s = x;
        y = x;

        seq.x[:,i] = x; seq.y[:,i] = y; seq.α[i] = α; seq.s = s;
        seq.A = A; seq.AX = seq.AX + α*x; seq.X = seq.X + x;
        seq.fs[i] = f(y); seq.optval = f(y);
    end

    return seq;
end


### Accelerated mirror descent (ICML 2018)
function AMD_plus(f,oracle,∇ϕ_cjg,x_0,σ,L,k)
    n = length(x_0)
    x = x_0;
    y = x_0;
    z = zeros(n);
    A = 0;

    seq = Sequences(L,0,σ,zeros(n,k),zeros(n,k),zeros(k),0,0,zeros(n),zeros(n),Inf*ones(k),Inf,0)

    for i=1:k
        α = (σ/L)*(i+1)/2;
        A = A + α;
        seq.α[i] = α; seq.A = A;

        x = (A-α)*inv(A)*y + α*inv(A)*∇ϕ_cjg(seq);
        ∇f = oracle(x)
        z = z - α*∇f;
        seq.x[:,i] = x; seq.s = z; seq.AX = seq.AX + α*x; seq.X = seq.X + x;

        y = (A-α)*inv(A)*y + α*inv(A)*∇ϕ_cjg(seq);
        seq.y[:,i] = y; seq.fs[i] = f(y); seq.optval = f(y); seq.norm_∇f = ∇f'*∇f;
    end

    return seq;
end



### AMD with a strongly convex objective
function μAMD_plus(f,oracle,∇ϕ_cjg,x_0,L,μ,k)
    n = length(x_0)
    x = x_0;
    y = zeros(n);
    z = zeros(n);
    v = zeros(n);
    A = 0;
    AX = zeros(n);
    σ = L - μ;
    α = 1;

    seq = Sequences(L,μ,σ,zeros(n,k),zeros(n,k),zeros(k),0,0,zeros(n),zeros(n),Inf*ones(k),Inf,0)

    for i=1:k

        if(i >= 2)
            α = sqrt(μ/L)*inv(1-sqrt(μ/L))*A;
        end

        A = A + α;
        θ = α * inv(A);
        x = inv(1+θ)*y + θ*inv(1+θ)*v;
        AX = AX + α*x;
        ∇f = oracle(x);
        z = z - α*∇f ;
        v = (z + μ*AX)*inv((L-μ) + μ*A);
        y = (1-θ)*y + θ*v;

        seq.x[:,i] = x; seq.y[:,i] = y; seq.α[i] = α; seq.s = z;
        seq.A = A; seq.AX = seq.AX + α*x; seq.X = seq.X + x;
        seq.fs[i] = f(y); seq.optval = f(y); seq.norm_∇f = ∇f'*∇f;
    end

    return seq;
end

### Unified accelerated algorithm
function AGM(f,oracle,∇ϕ_cjg,x_0,σ,L,μ,k,λ,p)
    n = length(x_0)
    x = x_0;
    y = zeros(n);
    s = zeros(n);
    v = zeros(n);
    A = 0;
    α = 0;
    AX = zeros(n);

    seq = Sequences(L,μ,σ,zeros(n,k),zeros(n,k),zeros(k),0,0,zeros(n),zeros(n),Inf*ones(k),Inf,0)

    for i=1:k
        λ2 = λ * min(L*p^2  / (μ * i^2) ,1);
        β = λ2*(μ*(A-α) + σ/2);
        α = inv(L-μ) * (β + sqrt(β^2 + (L-μ)*λ2*(μ*(A-α)^2 + σ*(A-α))));
        A = A + α;
        seq.α[i] = α; seq.A = A;

        x = (μ*A + σ)*(A-α) / (μ*(A-α)*(A+α) + σ*A) * y + (μ*(A-α) + σ)*α / (μ*(A-α)*(A+α) + σ*A) * v;
        AX = AX + α*x;
        ∇f = oracle(x);
        s = s - α*∇f;
        seq.x[:,i] = x; seq.s = s; seq.AX = seq.AX + α*x; seq.X = seq.X + x;

        v = ∇ϕ_cjg(seq);
        y = (A-α)*inv(A)*y + α*inv(A)*v;
        seq.y[:,i] = y; seq.fs[i] = f(y); seq.optval = min(seq.optval,f(y)); seq.norm_∇f = ∇f'*∇f;
    end

    return seq;
end

#### ACGD Algorithm (ICML 2020)
function ACGD(f,oracle,x_0,L,k,ω)
    n = length(x_0)
    x = zeros(n);
    y = zeros(n);
    z = zeros(n);

    f_val = zeros(k);

    for i=1:k
        η = 1/L;
        p = 1 + ω;
        θ = i / (i+2);
        β = 0;
        γ = 2*p / (i+2);

        x = θ*y + (1-θ)*z;
        ∇f = oracle(x)
        y = x - (η/p)*∇f;
        z = (1/γ)*y + (1/p - 1/γ)*y + (1-1/p)*(1-β)*z + (1-1/p)*β*x;
        f_val[i] = f(x)
    end

    return f_val;
end

#### ACGD Algorithm (ICML 2020) for strongly convex objective
function μACGD(f,oracle,x_0,L,μ,k,ω)
    n = length(x_0)
    x = zeros(n);
    y = zeros(n);
    z = zeros(n);

    f_val = zeros(k);

    for i=1:k
        η = 1/L;
        p = 1 + ω;
        θ = p / (p + sqrt(μ/L));
        β = sqrt(μ/L)/p
        γ = sqrt(μ/L)

        x = θ*y + (1-θ)*z;
        ∇f = oracle(x)
        y = x - (η/p)*∇f;
        z = (1/γ)*y + (1/p - 1/γ)*y + (1-1/p)*(1-β)*z + (1-1/p)*β*x;
        f_val[i] = f(y)
    end

    return f_val;
end


# Original Nesterov's AGD
function Nesterov83(f,oracle,x_0,k)

    n = length(x_0);
    f_val = zeros(k);

    y = x_0;
    a = 1;
    x = y;
    z = rand(n);
    α = norm(y.-z,2) / norm(oracle(y).-oracle(z),2)

    for i=1:k

        lo = 0.0;
        up = Inf;
        j = lo
        grad = oracle(y);
        e = 1;

        t = 0;
        # Subroutine for computing the index in the update
        while(abs(e)<1e-8)
            t = t + 1;
            e = f(y) - f(y .- 2^(-j).*α.*grad) - 2^(-j-1)*α*norm(grad,2)^2
            if(e < 0)
                lo = j;
                if(up == Inf)
                    j = 2.0^t;
                else
                    j = (up+lo)/2;
                end
            else
                up = j;
                j = (up+lo)/2;
            end
        end

        α = 2.0^(-j)*α;
        x_past = x;
        x = y - α.*grad;
        a = (1 .+ sqrt(4*a^2 + 1))/2
        y = x .+ (a-1)*(x - x_past)./a;
        f_val[i] = f(x)
    end

    return f_val
end

####
function VBS19(f,oracle,x_0,L,μ,k,ρ)
    n = length(x_0)
    w = zeros(n);
    v = zeros(n);

    f_val = zeros(k);

    for i=1:k
        η = 1 / (ρ*L)
        γ = 1 / (sqrt(μ*η*ρ));
        β = 1 - sqrt((μ*η)/ρ);
        b = sqrt(μ)/(β^((k+1)/2));
        a = 1 / (β^((k+1)/2));
        α = (γ*β*b^2*η)/(γ*β*b^2*η+a^2);

        ζ = α*v +(1-α)*w;
        ∇f = oracle(ζ)
        w = ζ - η*∇f;
        v = β*v +(1-β)*ζ - γ*η*∇f;
        f_val[i] = f(w)
    end

    return f_val;
end
