using LinearAlgebra
using Convex
using SCS
using Plots

function svm_setup(data,labels,λ)

    m = size(data,1) # number of samples
    n = size(data,2) # number of features

    # f(x) = λ * |β|^2 + (1/m) * Σ max(0, 1 - a'*β - β0)
    function f(x)
        β = x[1:end-1];
        β0 = x[end];
        return λ * β'*β + inv(m) * sum(max(0, 1 - labels[i]*(data[i,:]'*β-β0)) for i=1:length(labels))
    end

    function ∇f(x)
        β = x[1:end-1];
        β0 = x[end];
        v = Int16.(0 .<= 1 .- labels.*(data*β .- β0));
        grad_β = 2*λ*β + inv(m) * sum(-v[i]*labels[i]*data[i,:] for i=1:length(labels))
        grad_β0 = inv(m) * sum(v[i]*labels[i] for i=1:length(labels))
        grad = vcat(grad_β, grad_β0);
        return grad
    end

    # ϕ = 0.5*|z|^2
    function ∇ϕ_cjg(z)
        return z;
    end

    σ = 1

    return f,∇f,∇ϕ_cjg,σ,0,0

end


function svm_compute_optval(λ,data,labels)

    n = size(data,2)
    m = length(labels)

    β = Variable(n)
    β0 = Variable(1)

    problem = minimize(λ * sumsquares(β) + (1/m) * sum(max(0, 1 - Diagonal(labels)*data*β + labels*β0)))
    solve!(problem, SCS.Optimizer(verbose=false))

    return [β.value; β0.value];

end


function svm_plot(data,labels,x_opt,x_num)

    data0 = [];
    data1 = [];

    for i=1:length(labels)
        if(labels[i] < 0)
            data0 = vcat(data0,data[i,:])
        else
            data1 = vcat(data1,data[i,:])
        end
    end

    data0 = reshape(data0, 2, :)
    data1 = reshape(data1, 2, :)

    fig = plot()

    plot!(data0[1,:], data0[2,:], seriestype=:scatter)
    plot!(data1[1,:], data1[2,:], seriestype=:scatter)


    minx = minimum(data[:,1])
    maxx = maximum(data[:,1])
    miny = minimum(data[:,2])
    maxy = maximum(data[:,2])

    xx_opt = collect(minx:1:maxx)
    yy_opt = -(x_opt[1]*xx_opt .- x_opt[end])./x_opt[2]
    xx = collect(minx:1:maxx)
    yy = -(x_num[1,end]*xx .- x_num[end,end])./x_num[2,end]

    plot(fig,ylims=(miny,maxy))
    plot!(xx_opt,yy_opt,linewidth=5)
    plot!(xx,yy,linewidth=5)
    plot(fig,label=["Data A" "Data B" "Opt. classifier" "Num. classifier"])

    return fig;

end
