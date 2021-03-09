reset

load 'dark2.pal'
load 'grid.cfg'

set xrange [1:1000]
set logscale y
#set logscale x

set format y "$10^{%L}$"
#set format x "$10^{%L}$"
set xlabel "$k$"
set xtics 250
set ylabel '$f(y_k) - \hat f^{\star}$' offset 1,0,0

set yrange [1e-16:1e4]

set terminal epslatex size 24cm, 12cm
set title "negative offset" offset 0,-1

set output "figures/multiplot.tex"

set key out vert
set key top right
set key default
set key at 1000,10e9

set tmargin 4
set bmargin 0.5
set rmargin 1

 new = "-"
set multiplot layout 2,3 rowsfirst
### MUSHROOM DATASET
####### ROUNDS
set title 'Na\"ive random sparsification'
set label 1 '\large a' at graph 0.92,0.9 font ',8'
plot    "logs/mushrooms_random_sparsification.txt" every 1 using 1:4 with lines title 'ADCG (compressed grad.)' ls 1 lw 6 dt 3, \
        "logs/mushrooms_random_sparsification.txt" every 1 using 1:6 with lines notitle 'Alg. 3 (compressed grad.)' ls 4 lw 6 dt 3, \
        "logs/mushrooms_random_sparsification.txt" every 1 using 1:7 with linespoints notitle 'Alg. 3 (compressed grad.)' ls 4 lw 6 pt 3 pi 100 ps 1.5, \
        "logs/mushrooms_exact_gradient.txt" every 1 using 1:4 with lines title 'ADCG (exact grad.)' ls 1 lw 6, \
        "logs/mushrooms_exact_gradient.txt" every 1 using 1:6 with lines notitle 'Algorithm 1 (centralized)' ls 4 lw 6, \

set title "Random dithering"
set label 1 '\large b' at graph 0.92,0.9 font ',8'
plot    "logs/mushrooms_dithering.txt" every 1 using 1:4 with lines notitle 'ADCG (compressed grad.)' ls 1 lw 6 dt 3, \
        "logs/mushrooms_dithering.txt" every 1 using 1:6 with lines title 'Algorithm 3a (compressed grad.)' ls 4 lw 6 dt 3, \
        "logs/mushrooms_dithering.txt" every 1 using 1:7 with linespoints notitle 'Algorithm 3c (compressed grad.)' ls 4 lw 6 pt 3 pi 100 ps 1.5, \
        "logs/mushrooms_exact_gradient.txt" every 1 using 1:4 with lines notitle 'ADCG (exact grad.)' ls 1 lw 6, \
        "logs/mushrooms_exact_gradient.txt" every 1 using 1:6 with lines title 'Algorithm 1 (exact grad.)' ls 4 lw 6, \

set title "Natural compression"
set label 1 '\large c' at graph 0.92,0.9 font ',8'
plot    "logs/mushrooms_natural_compression.txt" every 1 using 1:4 with lines notitle 'ADCG (compressed grad.)' ls 1 lw 6 dt 3, \
        "logs/mushrooms_natural_compression.txt" every 1 using 1:6 with lines notitle 'Alg. 3 (compressed grad.)' ls 4 lw 6 dt 3, \
        "logs/mushrooms_natural_compression.txt" every 1 using 1:7 with linespoints title 'Algorithm 3c (compressed grad.)' ls 4 lw 6 pt 3 pi 100 ps 1.5, \
        "logs/mushrooms_exact_gradient.txt" every 1 using 1:4 with lines notitle 'ADCG (exact grad.)' ls 1 lw 6, \
        "logs/mushrooms_exact_gradient.txt" every 1 using 1:6 with lines notitle 'Algorithm 1 (centralized)' ls 4 lw 6, \

####### BITS

set xlabel "Total size of communicated gradients (Mbits)"
set autoscale x
set xrange [0:12]
set xtics 1

### MUSHROOM DATASET
set title 'Na\"ive random sparsification'
set label 1 '\large d' at graph 0.92,0.9 font ',8'
plot    "logs/mushrooms_random_sparsification.txt" every 1 using ($3/1000000):4 with lines notitle 'ADCG (compressed grad.)' ls 1 lw 6 dt 3, \
        "logs/mushrooms_random_sparsification.txt" every 1 using ($3/1000000):6 with lines notitle 'Alg. 3 (compressed grad.)' ls 4 lw 6 dt 3, \
        "logs/mushrooms_random_sparsification.txt" every 1 using ($3/1000000):7 with linespoints notitle 'Alg. 3 (compressed grad.)' ls 4 lw 6 pt 3 pi 100 ps 1.5, \
        "logs/mushrooms_exact_gradient.txt" every 1 using ($2/1000000):4 with lines notitle 'ADCG (exact grad.)' ls 1 lw 6, \
        "logs/mushrooms_exact_gradient.txt" every 1 using ($2/1000000):6 with lines notitle 'Algorithm 1 (centralized)' ls 4 lw 6, \

set title "Random dithering"
set label 1 '\large e' at graph 0.92,0.9 font ',8'
plot    "logs/mushrooms_dithering.txt" every 1 using ($3/1000000):4 with lines notitle 'ADCG (compressed grad.)' ls 1 lw 6 dt 3, \
        "logs/mushrooms_dithering.txt" every 1 using ($3/1000000):6 with lines notitle 'Alg. 3 (compressed grad.)' ls 4 lw 6 dt 3, \
        "logs/mushrooms_dithering.txt" every 1 using ($3/1000000):7 with linespoints notitle 'Alg. 3 (compressed grad.)' ls 4 lw 6 pt 3 pi 200 ps 1.5, \
        "logs/mushrooms_exact_gradient.txt" every 1 using ($2/1000000):4 with lines notitle 'ADCG (exact grad.)' ls 1 lw 6, \
        "logs/mushrooms_exact_gradient.txt" every 1 using ($2/1000000):6 with lines notitle 'Algorithm 1 (centralized)' ls 4 lw 6, \

set title "Natural compression"
set label 1 '\large f' at graph 0.92,0.9 font ',8'
plot    "logs/mushrooms_natural_compression.txt" every 1 using ($3/1000000):4 with lines notitle 'ADCG (compressed grad.)' ls 1 lw 6 dt 3, \
        "logs/mushrooms_natural_compression.txt" every 1 using ($3/1000000):6 with lines notitle 'Alg. 3 (compressed grad.)' ls 4 lw 6 dt 3, \
        "logs/mushrooms_natural_compression.txt" every 1 using ($3/1000000):7 with linespoints notitle 'Alg. 3 (compressed grad.)' ls 4 lw 6 pt 3 pi 100 ps 1.5, \
        "logs/mushrooms_exact_gradient.txt" every 1 using ($2/1000000):4 with lines notitle 'ADCG (exact grad.)' ls 1 lw 6, \
        "logs/mushrooms_exact_gradient.txt" every 1 using ($2/1000000):6 with lines notitle 'Algorithm 1 (centralized)' ls 4 lw 6, \

unset multiplot







################## LEAST SQUARES ##################

reset
load 'dark2.pal'
load 'grid.cfg'

set xtics 750
set xrange [0:3000]
set yrange [1e-16:1e1]
set logscale y
set format y '$10^{%L}$'
set xlabel '$k$'
set ylabel '$f(y_k)- \hat f^{\star}$'
set title "negative offset" offset 0,-1
set terminal epslatex size 25cm, 6cm

set key out vert
set key top center

set tmargin 4
set bmargin 0

set output "figures/least_squares.tex"
set multiplot layout 1,3 rowsfirst

set title '$\nu = 0$'
set label 1 '\large a' at graph 0.92,0.9 font ',8'
plot    "logs/PSD_exact_gradient.txt" every 1 using 1:9 with lines title '\cite{Nes83}' ls 6 lw 6, \
        "logs/PSD_exact_gradient.txt" every 1 using 1:5 with lines title '\textsc{AMD+} \cite{CDO18}' ls 3 lw 6, \
        "logs/PSD_exact_gradient.txt" every 1 using 1:10 with linespoints notitle 'Alg. 3 (p=5)' ls 4 lw 6 pt 3 pi 300 ps 1.5, \
        "logs/PSD_exact_gradient.txt" every 1 using 1:7 with lines notitle 'ACGD' ls 1 lw 6, \
        "logs/PSD_exact_gradient.txt" every 100 using 1:4 with lines notitle 'Algorithm 1' ls 4 lw 6, \
        "logs/PSD_exact_gradient.txt" every 150 using 1:6 with points notitle '$\mu$AMD+' ls 3 lw 6 ps 1.5, \



set title '$\nu = 10^{-1}$'
set label 1 '\large b' at graph 0.92,0.9 font ',8'
set yrange [1e-6:10]
plot    "logs/PSD_noisy_gradient.txt" every 1 using 1:9 with lines notitle 'Nes. 83' ls 6 lw 6, \
        "logs/PSD_noisy_gradient.txt" every 1 using 1:5 with lines notitle 'AMD+ ' ls 3 lw 6, \
        "logs/PSD_noisy_gradient.txt" every 1 using 1:10 with linespoints notitle 'Alg. 3' ls 4 lw 6 pt 3 pi 300 ps 1.5, \
        "logs/PSD_noisy_gradient.txt" every 1 using 1:7 with lines title '\textsc{ACGD} \cite{LKQ+20}' ls 1 lw 6, \
        "logs/PSD_noisy_gradient.txt" every 100 using 1:4 with lines notitle 'Algorithm 1' ls 4 lw 6, \
        "logs/PSD_noisy_gradient.txt" every 150 using 1:6 with points title '$\mu$\textsc{AMD+} \cite{CDO18}' ls 3 lw 6 ps 1.5, \



set yrange [1e-5:10]
set title '$\nu = 1$'
set label 1 '\large c' at graph 0.92,0.9 font ',8'
set label 6 at 1500, 7e-4 '{\small Alg. 3c slows down to $O(1/k)$}' center rotate by -8 front
plot    "logs/PSD_noisy_gradient2.txt" every 1 using 1:9 with lines notitle 'N83' ls 6 lw 6, \
        "logs/PSD_noisy_gradient2.txt" every 1 using 1:5 with lines notitle 'AMD+' ls 3 lw 6, \
        "logs/PSD_noisy_gradient2.txt" every 1 using 1:10 with linespoints title 'Algorithm 3c ($p=5$)' ls 4 lw 6 pt 3 pi 300 ps 1.5, \
        "logs/PSD_noisy_gradient2.txt" every 1 using 1:7 with lines notitle 'ACGD' ls 1 lw 6, \
        "logs/PSD_noisy_gradient2.txt" every 100 using 1:4 with lines title 'Algorithm 1' ls 4 lw 6, \
        "logs/PSD_noisy_gradient2.txt" every 150 using 1:6 with points notitle '$\mu$AMD+' ls 3 lw 6 ps 1.5, \
