reset

load 'dark2.pal'
load 'grid.cfg'

set xtics 250
set xrange [1:1000]
set logscale y
set format y "10^{%L}"
set xlabel "training rounds (k)"
set ylabel "f(y_k) - f^*"

set terminal pdfcairo size 9cm, 8cm

####### ROUNDS
### MUSHROOM DATASET
set title "Random sparsification"
set output "figures/mushrooms_rs.pdf"
plot    "logs/mushrooms_exact_gradient.txt" every 1 using 1:4 with lines title 'ADCG (ICML 2020). Exact gradients' ls 1 lw 2, \
        "logs/mushrooms_exact_gradient.txt" every 1 using 1:6 with lines title 'New algorithm. Exact gradients' ls 4 lw 2 , \
        "logs/mushrooms_random_sparsification.txt" every 1 using 1:4 with lines title 'ADCG (ICML 2020). Compressed gradients' ls 1 lw 2 dashtype '.', \
        "logs/mushrooms_random_sparsification.txt" every 1 using 1:6 with lines title 'New algorithm. Compressed gradients' ls 4 lw 2 dashtype '.', \

set xlabel "Bits"
set xtics 250000
set xrange [1:1000000]
set format x "%2.0t{/Symbol \327}10^{%L}"

####### BITS
### MUSHROOM DATASET
set output "figures/mushrooms_rs_bits.pdf"
set title "Random sparsification"
plot    "logs/mushrooms_random_sparsification.txt" every 1 using 3:4 with lines title 'ADCG (ICML 2020). Exact gradients' ls 1 lw 2 dashtype '.', \
        "logs/mushrooms_random_sparsification.txt" every 1 using 3:6 with lines title 'New algorithm. Exact gradients' ls 4 lw 2 dashtype '.', \
        "logs/mushrooms_exact_gradient.txt" every 1 using 2:4 with lines title 'ADCG (ICML 2020). Compressed gradients' ls 1 lw 2, \
        "logs/mushrooms_exact_gradient.txt" every 1 using 2:6 with lines title 'New algorithm. Compressed gradients' ls 4 lw 2, \
