A = data; b = labels;
ψ = zeros(n,m)
θ = 1

for i=1:m
   lbl = b[i]
   dat = A[i,:]
   ψ[:,i] = exp(-lbl*dat'*x_0)/(1 .+ exp(-lbl*dat'*x_0))*(-lbl.*dat)
end

function full_gradient(x)
    indexes = Int16.(ceil.(rand(mini_batch)*m));
    grad = zeros(n);
    for j=1:m
        lbl = b[j]
        dat = A[j,:]
        grad_j = exp(-lbl*dat'*x)/(1 .+ exp(-lbl*dat'*x))*(-lbl.*dat);
        grad = grad + grad_j
    end
    return grad + θ*x
end

function mini_batch_gradient(x)
    indexes = Int16.(ceil.(rand(mini_batch)*m));
    grad = zeros(n);
    for j in indexes
        lbl = b[j]
        dat = A[j,:]
        grad_j = exp(-lbl*dat'*x)/(1 .+ exp(-lbl*dat'*x))*(-lbl.*dat);
        grad = grad + (m/mini_batch)*grad_j
    end
    return grad + θ*x
end



function ∇fvr(x)
    indexes = Int16.(ceil.(rand(mini_batch)*m));
    grad = zeros(n)
    sum_ψ = zeros(n)
    for l=1:m
        sum_ψ = sum_ψ + ψ[:,l]
    end
    for j in indexes
        lbl = b[j]
        dat = A[j,:]
        grad_j = exp(-lbl*dat'*x)/(1 .+ exp(-lbl*dat'*x))*(-lbl.*dat)
        grad = grad + (m/mini_batch)*(grad_j - ψ[:,j])
        ψ[:,j] = grad_j
    end
    grad = grad + sum_ψ
    return grad + θ*x
end
