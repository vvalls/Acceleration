using LinearAlgebra
using Convex
using SCS
using Plots

function perceptron_setup(data,labels,λ)

    m = size(data,1)
    n = size(data,2)

    A = data; b = labels;

    # f(x) = |Ax - b|^2
    function f(x)
        return (λ/2)*x'*x + inv(m)*sum(max(0,data[i,:]*x[i] - b[i]) for i=1:length(labels))
        #return 0.5*(A*x-b)'*(A*x-b)
    end

    function ∇f(x)
        v = Int16.(0 .<= (data*x - labels))
        return λ*x + inv(m)*sum(v[i]*(data[i,:]) for i=1:length(labels))
        #return (A'*A)*x - A'*b;
    end

    # ϕ = 0.5*|z|^2
    function ∇ϕ_cjg(z)
        return z;
    end

    σ = 1;

    return f,∇f,∇ϕ_cjg,σ,0,0

end


function perceptron_compute_optval(data,labels,λ)

    n = size(data,2)
    m = length(labels)

    x = Variable(n)

    #problem = minimize( inv(m) * sumsquares(data*x-labels))
    problem = minimize((λ/2)*sumsquares(x) + inv(m)*sum(max(0,data*x-labels)))
    solve!(problem, SCS.Optimizer(verbose=false))

    return x.value;
end


function perceptron_plot(data,labels,x_opt,x_num)

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

    xx_axis = collect(minx:1:maxx)
    yy_opt = -(x_opt[1]/x_opt[2])*xx_axis
    yy = -(x_num[1,end]/x_num[2,end])*xx_axis

    plot(fig,ylims=(miny,maxy))
    plot!(xx_opt,yy_opt,linewidth=5)
    plot!(xx,yy,linewidth=5)
    plot(fig,label=["Data A" "Data B" "Opt. classifier" "Num. classifier"])

    return fig;

end
