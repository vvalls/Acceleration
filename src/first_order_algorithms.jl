### Mirror descent
function MD(f,∇f,∇ϕ_cjg,x_ini,σ,L,k);
    n = length(x_ini)
    x = x_ini;
    z = zeros(n);
    sumx = zeros(n);
    A = 0;

    f_val = zeros(k);

    for i=1:k
        α = (σ/L)*inv(sqrt(i));
        A = A + α;
        gradient, ξ = ∇f(x)
        z = z - α*gradient;
        x = ∇ϕ_cjg(z);
        sumx = sumx + α*x;

        f_val[i] = f(sumx/A)
    end

    return f_val;
end

### Projected gradient descent (with averaging)
function PGD_avg(f,∇f,∇ϕ_cjg,x_ini,σ,L,k)
    n = length(x_ini)
    x = x_ini;
    z = zeros(n);
    sumx = zeros(n);
    A = 0;

    f_val = zeros(k);

    for i=1:k
        α = (σ/L);
        A = A + α;
        gradient, ξ = ∇f(x)
        z = z - α*gradient;
        x = ∇ϕ_cjg(z);
        sumx = sumx + α*x;

        f_val[i] = f(sumx/A)
    end

    return f_val;
end

### Gradient descent (with averaging)
function GD(f,∇f,x_ini,σ,L,k)
    n = length(x_ini)
    x = x_ini;
    f_val = zeros(k);

    for i=1:k
        α = (σ/L);
        gradient, ξ = ∇f(x)
        x = x - α*gradient;

        f_val[i] = f(sumx/A)
    end

    return f_val;
end


### Accelerated mirror descent + (ICML 2018)
function AMD_plus(f,∇f,∇ϕ_cjg,x_ini,σ,L,k)
    n = length(x_ini)
    x = x_ini;
    y = zeros(n);
    z = zeros(n);
    A0 = 0;
    A = A0;

    f_val = zeros(k);

    for i=1:k
        α = (σ/L)*(i+1)/2;
        A = A + α;
        x = (A-α)*inv(A)*y + α*inv(A)*∇ϕ_cjg(z);
        gradient, ξ = ∇f(x)
        z = z - α*gradient;
        y = (A-α)*inv(A)*y + α*inv(A)*∇ϕ_cjg(z); # Nesterov's update: y = x - inv(L)*∇f(x);

        f_val[i] = f(y)
    end

    return f_val;
end



### AMD with a strongly convex objective
function μAMD_plus(f,∇f,∇ϕ_cjg,x_ini,L,μ,k)
    n = length(x_ini)
    x = x_ini;
    y = zeros(n);
    z = zeros(n);
    v = zeros(n);
    A0 = 0;
    A = A0;
    AX = zeros(n);
    σ = L - μ;
    α = 1;

    f_val = zeros(k);

    for i=1:k

        if(i >= 2)
            α = sqrt(μ/L)*inv(1-sqrt(μ/L))*A;
        end

        A = A + α;
        θ = α * inv(A);
        x = inv(1+θ)*y + θ*inv(1+θ)*v;
        AX = AX + α*x;
        gradient, ξ = ∇f(x);
        z = z - α*gradient;
        v = (z + μ*AX)*inv((L-μ) + μ*(A-A0));
        y = (1-θ)*y + θ*v;

        f_val[i] = f(y)
    end

    return f_val;
end

### Unified accelerated algorithm
function ufom(f,∇f,∇ϕ_cjg,x_ini,σ,L,μ,k,p,adaptive)
    n = length(x_ini)
    x = x_ini;
    y = zeros(n);
    z = zeros(n);
    v = zeros(n);
    A0 = σ/(2*L)
    A =  A0;
    AX = zeros(n);

    f_val = zeros(k);

    for i=1:k
        λ = min(L/μ *(p/i)^2,1);
        a = L-μ; b = -λ*(μ*A + σ); c = -λ*(μ*A^2 + σ*A);
        α = (-b + sqrt(b^2 - 4*a*c)) / (2*a);
        A = A + α;
        x = (A-α)*inv(A)*y + α*inv(A)*v;
        AX = AX + α*x;
        gradient, ξ = ∇f(x)
        z = z - α*gradient;
        v_past = v;
        v = (z + μ*AX)*inv(1 + μ*(A-A0));
        y = (A-α)*inv(A)*y + α*inv(A)*v; # Nesterov's update for l_2 and C = R^n: y = x - inv(L)*∇f(x);
        if(adaptive)
            p = max(1,k * sqrt(μ/L)*sqrt(max(0,1 - α^2/(μ*(A-α) + σ)^2 * ξ^2 / norm(v-v_past,2)^2)))
        end
        #if(ξ > sqrt(1-λ)*(μ*A + σ)/α * (v-v_past)'*(v-v_past))
        #    y = x;
        #end
        f_val[i] = f(y)
    end

    return f_val;
end

#### ACGD Algorithm (ICML 2020)
function ACGD(f,∇f,x_ini,L,k,ω)
    n = length(x_ini)
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
        g, ξ = ∇f(x)
        y = x - (η/p)*g;
        z = (1/γ)*y + (1/p - 1/γ)*y + (1-1/p)*(1-β)*z + (1-1/p)*β*x;
        f_val[i] = f(x)
    end

    return f_val;
end

#### ACGD Algorithm (ICML 2020) for strongly convex objective
function μACGD(f,∇f,x_ini,L,μ,k,ω)
    n = length(x_ini)
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
        g, ξ = ∇f(x)
        y = x - (η/p)*g;
        z = (1/γ)*y + (1/p - 1/γ)*y + (1-1/p)*(1-β)*z + (1-1/p)*β*x;
        f_val[i] = f(y)
    end

    return f_val;
end


# Original Nesterov's AGD
function AGD(f,∇f,x_ini,k)

    n = length(x_ini);
    f_val = zeros(k);

    y = x_ini;
    a = 1;
    x = y;
    z = rand(n);
    α = norm(y.-z,2) / norm(∇f(y).-∇f(z),2)

    for i=1:k

        lo = 0.0;
        up = Inf;
        j = lo
        grad, ξ = ∇f(y);
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
