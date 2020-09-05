### Dual averaging
function mirror_descent(f,∇f,∇ϕ_cjg,x_ini,σ,L,k);
    n = length(x_ini)
    x = x_ini;
    z = zeros(n);
    sumx = zeros(n);
    A = 0;

    xks = zeros(n,k);

    for i=1:k
        α = (σ/L)*inv(sqrt(i));
        A = A + α;
        z = z - α*∇f(x);
        x = ∇ϕ_cjg(z);
        sumx = sumx + α*x;

        xks[:,i] = sumx/A
    end

    return xks;
end

### Gradient descent
function gradient_descent(f,∇f,∇ϕ_cjg,x_ini,σ,L,k)
    n = length(x_ini)
    x = x_ini;
    z = zeros(n);
    sumx = zeros(n);
    A = 0;

    xks = zeros(n,k);

    for i=1:k
        α = (σ/L);
        A = A + α;
        z = z - α*∇f(x);
        x = ∇ϕ_cjg(z);
        sumx = sumx + α*x;

        xks[:,i] = sumx/A
    end

    return xks;
end


### Accelerated mirror descent
function accelerated_mirror_descent(f,∇f,∇ϕ_cjg,x_ini,σ,L,k)
    n = length(x_ini)
    x = x_ini;
    y = zeros(n);
    z = zeros(n);
    A = 0;

    yks = zeros(n,k);

    for i=1:k
        α = (σ/L)*(i+1)/2;
        A = A + α;
        x = (A-α)*inv(A)*y + α*inv(A)*∇ϕ_cjg(z);
        z = z - α*∇f(x);
        y = (A-α)*inv(A)*y + α*inv(A)*∇ϕ_cjg(z); # Nesterov's update: y = x - inv(L)*∇f(x);

        yks[:,i] = y;
    end

    return yks;
end



### AMD with a strongly convex objective
function SCVX_AMD(f,∇f,∇ϕ_cjg,x_ini,σ,L,μ,k)
    n = length(x_ini)
    x = x_ini;
    y = zeros(n);
    z = zeros(n);
    v = zeros(n);
    A = 0;
    AX = zeros(n);

    α = 1;

    yks = zeros(n,k);

    for i=1:k

        if(i >= 2)
            α = sqrt(μ/L)*inv(1-sqrt(μ/L))*A;
        end

        A = A + α;
        θ = α * inv(A);
        x = inv(1+θ)*y + θ*inv(1+θ)*v;
        AX = AX + α*x;
        z = z - α*∇f(x);
        v = (μ*AX + z)*inv(μ*A+2);
        y = (1-θ)*y + θ*v;

        yks[:,i] = y;
    end

    return yks;
end
