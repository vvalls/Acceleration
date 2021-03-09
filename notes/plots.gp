reset

load 'lum.pal'
load 'grid.cfg'

#set xtics 2500
set xrange [1:100000]
set logscale y
set logscale x

set format y "$10^{%L}$"
set format x "$10^{%L}$"
set xlabel "$k$"
set ylabel '$f(y_k) - \hat f^{\star}$'
set yrange [1e-12:1e4]

#set terminal pdfcairo size 6cm, 5cm enhanced font 'Verdana,10'
set terminal epslatex size 7.5cm, 6cm
set title "negative offset" offset 0,-1
set key out horiz
set key top center

####### ROUNDS
### MUSHROOM DATASET
set title 'Na\"ive random sparsification'
set output "figures/mushrooms_random_sparsification.tex"
plot    "logs/mushrooms_random_sparsification.txt" every 1 using 1:4 with lines title 'ADCG (determnistic)' ls 5 lw 7, \
        "logs/mushrooms_random_sparsification.txt" every 1 using 1:6 with lines notitle 'Alg. 3 (CG)' ls 6 lw 7, \
        "logs/mushrooms_random_sparsification.txt" every 1 using 1:7 with lines notitle 'Alg. 3 (CG)' ls 3 lw 7, \
        "logs/mushrooms_exact_gradient.txt" every 1 using 1:4 with lines title 'ADCG (mini-bathc + comp.)' ls 9 lw 7, \
        "logs/mushrooms_exact_gradient.txt" every 1 using 1:6 with lines notitle 'Alg 1. (EG)' ls 1 lw 7, \

set title "Random dithering"
set output "figures/mushrooms_dithering.tex"
plot    "logs/mushrooms_dithering.txt" every 1 using 1:4 with lines notitle 'ADCG' ls 5 lw 7, \
        "logs/mushrooms_dithering.txt" every 1 using 1:6 with lines title 'Algorithm 3 (CG; $\lambda_0$)' ls 6 lw 7, \
        "logs/mushrooms_dithering.txt" every 1 using 1:7 with lines title 'Algorithm 3 (CG; $p=5$)' ls 3 lw 7, \
        "logs/mushrooms_exact_gradient.txt" every 1 using 1:4 with lines notitle 'ADCG (EG)' ls 9 lw 7, \
        "logs/mushrooms_exact_gradient.txt" every 1 using 1:6 with lines notitle 'Algorithm 1 (EG)' ls 1 lw 7, \

set title "Natural compression"
set output "figures/mushrooms_natural_compression.tex"
plot    "logs/mushrooms_natural_compression.txt" every 1 using 1:4 with lines notitle 'ADCG (CG)' ls 5 lw 7, \
        "logs/mushrooms_natural_compression.txt" every 1 using 1:6 with lines notitle 'Alg. 3 (CG; $\lambda_0$)' ls 6 lw 7, \
        "logs/mushrooms_natural_compression.txt" every 1 using 1:7 with lines notitle 'Alg. 3 (CG; $p=5$)' ls 3 lw 7, \
        "logs/mushrooms_exact_gradient.txt" every 1 using 1:4 with lines notitle 'ADCG (EG)' ls 9 lw 7, \
        "logs/mushrooms_exact_gradient.txt" every 1 using 1:6 with lines title 'Algorithm 1 (EG)' ls 1 lw 7, \

set xlabel "Total size of communicated gradients (Mbits)"
set autoscale x
set xrange [0.1:300]
#set format x "$%2.0t{/Symbol \327}10^{%L}$"
#set format x "$10^{%L}$"

set terminal epslatex size 7.5cm, 5.5cm

####### BITS
### MUSHROOM DATASET
set output "figures/mushrooms_random_sparsification_bits.tex"
set title 'Na\"ive random sparsification'
plot    "logs/mushrooms_random_sparsification.txt" every 1 using ($3/1000000):4 with lines notitle 'ADCG (CG)' ls 5 lw 7, \
        "logs/mushrooms_random_sparsification.txt" every 1 using ($3/1000000):6 with lines notitle 'Alg. 3 (CG)' ls 6 lw 7, \
        "logs/mushrooms_random_sparsification.txt" every 1 using ($3/1000000):7 with lines notitle 'Alg. 3 (CG; $p=5$)' ls 3 lw 7, \
        "logs/mushrooms_exact_gradient.txt" every 1 using ($2/1000000):4 with lines notitle 'ADCG (EG)' ls 9 lw 7, \
        "logs/mushrooms_exact_gradient.txt" every 1 using ($2/1000000):6 with lines notitle 'Alg. 1 (EG)' ls 1 lw 7, \

set title "Random dithering"
set output "figures/mushrooms_dithering_bits.tex"
plot    "logs/mushrooms_dithering.txt" every 1 using ($3/1000000):4 with lines notitle 'ADCG (CG)' ls 5 lw 7, \
        "logs/mushrooms_dithering.txt" every 1 using ($3/1000000):6 with lines notitle 'Algorithm 3 (CG)' ls 6 lw 7, \
        "logs/mushrooms_dithering.txt" every 1 using ($3/1000000):7 with lines notitle 'Algorithm 3 (CG; $p=5$)' ls 3 lw 7, \
        "logs/mushrooms_exact_gradient.txt" every 1 using ($2/1000000):4 with lines notitle 'ADCG (EG)' ls 9 lw 7, \
        "logs/mushrooms_exact_gradient.txt" every 1 using ($2/1000000):6 with lines notitle 'Alg. 1 (EG)' ls 1 lw 7, \

set title "Natural compression"
set output "figures/mushrooms_natural_compression_bits.tex"
plot    "logs/mushrooms_natural_compression.txt" every 1 using ($3/1000000):4 with lines notitle 'ADCG (CG)' ls 5 lw 7, \
        "logs/mushrooms_natural_compression.txt" every 1 using ($3/1000000):6 with lines notitle 'Alg. 3 (CG)' ls 6 lw 7, \
        "logs/mushrooms_natural_compression.txt" every 1 using ($3/1000000):7 with lines notitle 'Alg. 3 (CG; $p=5$)' ls 3 lw 7, \
        "logs/mushrooms_exact_gradient.txt" every 1 using ($2/1000000):4 with lines notitle 'ADCG (EG)' ls 9 lw 7, \
        "logs/mushrooms_exact_gradient.txt" every 1 using ($2/1000000):6 with lines notitle 'Alg. 1 (EG)' ls 1 lw 7, \


##########
