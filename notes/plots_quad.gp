################## QUADRATIC ##################

reset

load 'lum.pal'
load 'grid.cfg'

set xtics 750
set xrange [0:3000]
set yrange [1e-16:1e1]
set logscale y
set format y "$10^{%L}$"
set xlabel "$k$"
set ylabel '$f(y_k)- \hat f^{\star}$'
set title "negative offset" offset 0,-1


set terminal pdfcairo size 6cm, 5cm enhanced font 'Verdana,10'
set key out horiz
set key top center
set key off
set terminal epslatex size 7.5cm, 6cm
set title '$\nu = 0$'

set output "figures/quadratic_exact_gradient.tex"
plot    "logs/PSD_exact_gradient.txt" every 1 using 1:9 with lines title 'N83' ls 2 lw 7, \
        "logs/PSD_exact_gradient.txt" every 1 using 1:5 with lines title 'AMD+ ' ls 3 lw 7, \
        "logs/PSD_exact_gradient.txt" every 1 using 1:6 with lines title 'μAMD+' ls 4 lw 7, \
        "logs/PSD_exact_gradient.txt" every 1 using 1:7 with lines title 'ACGD ' ls 5 lw 7, \
        "logs/PSD_exact_gradient.txt" every 1 using 1:4 with lines title 'Algorithm 1' ls 6 lw 7, \
        #"logs/PSD_exact_gradient.txt" every 1 using 1:10 with lines title 'Alg. 3 (p=5)' ls 7 lw 2, \

set key off
#set terminal pdfcairo size 6cm, 5cm
set terminal epslatex size 7.5cm, 6cm
set title '$\nu = {1}/{10}$'

set yrange [1e-6:10]
set output "figures/quadratic_noisy_gradient.tex"
plot    "logs/PSD_noisy_gradient.txt" every 1 using 1:9 with lines notitle 'Nes. 83' ls 2 lw 7, \
        "logs/PSD_noisy_gradient.txt" every 1 using 1:5 with lines notitle 'AMD+ ' ls 3 lw 7, \
        "logs/PSD_noisy_gradient.txt" every 1 using 1:6 with lines notitle 'μAMD+' ls 4 lw 7, \
        "logs/PSD_noisy_gradient.txt" every 1 using 1:7 with lines notitle 'ACGD ' ls 5 lw 7, \
        "logs/PSD_noisy_gradient.txt" every 1 using 1:4 with lines notitle 'Algorithm 1' ls 6 lw 7, \
        #"logs/PSD_noisy_gradient.txt" every 1 using 1:10 with lines notitle 'Alg. 3' ls 7 lw 7, \


set key default
set key bottom right
set yrange [1e-6:10]
set title '$\nu = 1$'
set output "figures/quadratic_noisy_gradient2.tex"
plot    "logs/PSD_noisy_gradient2.txt" every 1 using 1:9 with lines title 'N83' ls 2 lw 7, \
        "logs/PSD_noisy_gradient2.txt" every 1 using 1:5 with lines title 'AMD+' ls 3 lw 7, \
        "logs/PSD_noisy_gradient2.txt" every 1 using 1:6 with lines title '$\mu$AMD+' ls 4 lw 7, \
        "logs/PSD_noisy_gradient2.txt" every 1 using 1:7 with lines title 'ACGD' ls 5 lw 7, \
        "logs/PSD_noisy_gradient2.txt" every 1 using 1:4 with lines title 'Alg. 1' ls 6 lw 7, \
        #"logs/PSD_noisy_gradient2.txt" every 1 using 1:10 with lines title 'Alg. 3' ls 7 lw 7, \
