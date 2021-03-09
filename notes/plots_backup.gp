reset

load 'lum.pal'
load 'grid.cfg'

set xtics 100
set xrange [1:500]
set logscale y
set format y "10^{%L}"
set xlabel "k"
set ylabel "f(y_k) - f^*"
set yrange [1e-6:1e4]

set terminal pdfcairo size 6cm, 5cm enhanced font 'Verdana,10'

####### ROUNDS
### MUSHROOM DATASET
set title "Random sparsification"
set output "figures/mushrooms_random_sparsification.pdf"
plot    "logs/mushrooms_random_sparsification.txt" every 1 using 1:4 with lines title 'ADCG (comp. grad)' ls 5 lw 3, \
        "logs/mushrooms_random_sparsification.txt" every 1 using 1:6 with lines title 'Alg. 3 (comp. grad)' ls 6 lw 3, \
        "logs/mushrooms_exact_gradient.txt" every 1 using 1:4 with lines notitle ls 9 lw 3, \
        "logs/mushrooms_exact_gradient.txt" every 1 using 1:6 with lines notitle ls 1 lw 3, \

set title "Random dithering"
set output "figures/mushrooms_dithering.pdf"
plot    "logs/mushrooms_dithering.txt" every 1 using 1:4 with lines notitle 'ADCG' ls 5 lw 3, \
        "logs/mushrooms_dithering.txt" every 1 using 1:6 with lines notitle 'This paper' ls 6 lw 3, \
        "logs/mushrooms_exact_gradient.txt" every 1 using 1:4 with lines title 'ADCG (exact grad)' ls 9 lw 3, \
        "logs/mushrooms_exact_gradient.txt" every 1 using 1:6 with lines title 'Alg. 3 (exact grad)' ls 1 lw 3, \

set title "Natural compression"
set output "figures/mushrooms_natural_compression.pdf"
plot    "logs/mushrooms_natural_compression.txt" every 1 using 1:4 with lines notitle 'ADCG' ls 5 lw 3, \
        "logs/mushrooms_natural_compression.txt" every 1 using 1:6 with lines notitle 'This paper' ls 6 lw 3, \
        "logs/mushrooms_exact_gradient.txt" every 1 using 1:4 with lines notitle ls 9 lw 3, \
        "logs/mushrooms_exact_gradient.txt" every 1 using 1:6 with lines notitle ls 1 lw 3, \

set xlabel "Total size of communicated gradients (bits)"
set xtics 1000000
set xrange [1:5000000]
set format x "%2.0t{/Symbol \327}10^{%L}"

####### BITS
### MUSHROOM DATASET
set output "figures/mushrooms_random_sparsification_bits.pdf"
set title "Random sparsification"
plot    "logs/mushrooms_random_sparsification.txt" every 1 using 3:4 with lines notitle 'ADCG' ls 5 lw 3, \
        "logs/mushrooms_random_sparsification.txt" every 1 using 3:6 with lines notitle 'This paper' ls 6 lw 3, \
        "logs/mushrooms_exact_gradient.txt" every 1 using 2:4 with lines notitle ls 9 lw 3, \
        "logs/mushrooms_exact_gradient.txt" every 1 using 2:6 with lines notitle ls 1 lw 3, \

set title "Random dithering"
set output "figures/mushrooms_dithering_bits.pdf"
plot    "logs/mushrooms_dithering.txt" every 1 using 3:4 with lines notitle 'ADCG' ls 5 lw 3, \
        "logs/mushrooms_dithering.txt" every 1 using 3:6 with lines notitle 'This paper' ls 6 lw 3, \
        "logs/mushrooms_exact_gradient.txt" every 1 using 2:4 with lines notitle ls 9 lw 3, \
        "logs/mushrooms_exact_gradient.txt" every 1 using 2:6 with lines notitle ls 1 lw 3, \

set title "Natural compression"
set output "figures/mushrooms_natural_compression_bits.pdf"
plot    "logs/mushrooms_natural_compression.txt" every 1 using 3:4 with lines notitle 'ADCG' ls 5 lw 3, \
        "logs/mushrooms_natural_compression.txt" every 1 using 3:6 with lines notitle 'This paper' ls 6 lw 3, \
        "logs/mushrooms_exact_gradient.txt" every 1 using 2:4 with lines notitle ls 9 lw 3, \
        "logs/mushrooms_exact_gradient.txt" every 1 using 2:6 with lines notitle ls 1 lw 3, \
