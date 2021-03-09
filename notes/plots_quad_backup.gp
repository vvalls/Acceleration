################## QUADRATIC ##################

reset

load 'lum.pal'
load 'grid.cfg'

set xtics 500
set xrange [1:3000]
set yrange [1e-6:1e1]
set logscale y
set format y "10^{%L}"
set xlabel "k"
set ylabel "f(y_k)- f^*"


set terminal pdfcairo size 6cm, 5cm enhanced font 'Verdana,10'
set key out horiz
set key top center
set key off

set output "figures/quadratic_exact_gradient.pdf"
plot    "logs/PSD_exact_gradient.txt" every 1 using 1:9 with lines title 'N83' ls 2 lw 3, \
        "logs/PSD_exact_gradient.txt" every 1 using 1:5 with lines title 'AMD+ ' ls 3 lw 3, \
        "logs/PSD_exact_gradient.txt" every 1 using 1:6 with lines title 'μAMD+' ls 4 lw 3, \
        "logs/PSD_exact_gradient.txt" every 1 using 1:7 with lines title 'ACGD ' ls 5 lw 3, \
        "logs/PSD_exact_gradient.txt" every 1 using 1:4 with lines title 'Algorithm 1' ls 6 lw 3, \
        #"logs/PSD_exact_gradient.txt" every 1 using 1:10 with lines title 'Alg. 3 (p=5)' ls 7 lw 2, \

set key off
set terminal pdfcairo size 6cm, 5cm
set yrange [1e-3:10]
set output "figures/quadratic_noisy_gradient.pdf"
plot    "logs/PSD_noisy_gradient.txt" every 1 using 1:9 with lines notitle 'Nes. 83' ls 2 lw 3, \
        "logs/PSD_noisy_gradient.txt" every 1 using 1:5 with lines notitle 'AMD+ ' ls 3 lw 3, \
        "logs/PSD_noisy_gradient.txt" every 1 using 1:6 with lines notitle 'μAMD+' ls 4 lw 3, \
        "logs/PSD_noisy_gradient.txt" every 1 using 1:7 with lines notitle 'ACGD ' ls 5 lw 3, \
        "logs/PSD_noisy_gradient.txt" every 1 using 1:4 with lines notitle 'Algorithm 1' ls 6 lw 3, \
        #"logs/PSD_noisy_gradient.txt" every 1 using 1:10 with lines notitle 'Alg. 3' ls 7 lw 3, \
