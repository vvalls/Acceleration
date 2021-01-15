reset

load 'dark2.pal'
load 'grid.cfg'

set xtics 250
set xrange [1:1000]
set logscale y
set format y "10^{%L}"
set xlabel "training rounds (k)"
set ylabel "f(y_k) - f^*"

set terminal pdfcairo size 6cm, 5cm

####### ROUNDS
### MUSHROOM DATASET
set title "Random sparsification"
set output "figures/mushrooms_random_sparsification.pdf"
plot    "logs/mushrooms_random_sparsification.txt" every 1 using 1:4 with lines title 'ADCG' ls 1 lw 2, \
        "logs/mushrooms_random_sparsification.txt" every 1 using 1:5 with lines title 'AMD+' ls 2 lw 2, \
        "logs/mushrooms_random_sparsification.txt" every 1 using 1:6 with lines title 'This paper' ls 3 lw 2, \
        "logs/mushrooms_exact_gradient.txt" every 1 using 1:4 with lines notitle ls 1 lw 2 dashtype '.-_', \
        "logs/mushrooms_exact_gradient.txt" every 1 using 1:5 with lines notitle ls 2 lw 2 dashtype '.-_', \
        "logs/mushrooms_exact_gradient.txt" every 1 using 1:6 with lines notitle ls 3 lw 2 dashtype '.-_', \

set title "Random dithering"
set output "figures/mushrooms_dithering.pdf"
plot    "logs/mushrooms_dithering.txt" every 1 using 1:4 with lines title 'ADCG' ls 1 lw 2, \
        "logs/mushrooms_dithering.txt" every 1 using 1:5 with lines title 'AMD+' ls 2 lw 2, \
        "logs/mushrooms_dithering.txt" every 1 using 1:6 with lines title 'This paper' ls 3 lw 2, \
        "logs/mushrooms_exact_gradient.txt" every 1 using 1:4 with lines notitle ls 1 lw 2 dashtype '.-_', \
        "logs/mushrooms_exact_gradient.txt" every 1 using 1:5 with lines notitle ls 2 lw 2 dashtype '.-_', \
        "logs/mushrooms_exact_gradient.txt" every 1 using 1:6 with lines notitle ls 3 lw 2 dashtype '.-_', \

set title "Natural compression"
set output "figures/mushrooms_natural_compression.pdf"
plot    "logs/mushrooms_natural_compression.txt" every 1 using 1:4 with lines title 'ADCG' ls 1 lw 2, \
        "logs/mushrooms_natural_compression.txt" every 1 using 1:5 with lines title 'AMD+' ls 2 lw 2, \
        "logs/mushrooms_natural_compression.txt" every 1 using 1:6 with lines title 'This paper' ls 3 lw 2, \
        "logs/mushrooms_exact_gradient.txt" every 1 using 1:4 with lines notitle ls 1 lw 2 dashtype '.-_', \
        "logs/mushrooms_exact_gradient.txt" every 1 using 1:5 with lines notitle ls 2 lw 2 dashtype '.-_', \
        "logs/mushrooms_exact_gradient.txt" every 1 using 1:6 with lines notitle ls 3 lw 2 dashtype '.-_', \

### A5A DATASET
set title "Random sparsification"
set output "figures/a5a_random_sparsification.pdf"
plot    "logs/a5a_random_sparsification.txt" every 1 using 1:4 with lines title 'ADCG' ls 1 lw 2, \
        "logs/a5a_random_sparsification.txt" every 1 using 1:5 with lines title 'AMD+' ls 2 lw 2, \
        "logs/a5a_random_sparsification.txt" every 1 using 1:6 with lines title 'This paper' ls 3 lw 2, \
        "logs/a5a_exact_gradient.txt" every 1 using 1:4 with lines notitle ls 1 lw 2 dashtype '.-_', \
        "logs/a5a_exact_gradient.txt" every 1 using 1:5 with lines notitle ls 2 lw 2 dashtype '.-_', \
        "logs/a5a_exact_gradient.txt" every 1 using 1:6 with lines notitle ls 3 lw 2 dashtype '.-_', \

set title "Random dithering"
set output "figures/a5a_dithering.pdf"
plot    "logs/a5a_dithering.txt" every 1 using 1:4 with lines title 'ADCG' ls 1 lw 2, \
        "logs/a5a_dithering.txt" every 1 using 1:5 with lines title 'AMD+' ls 2 lw 2, \
        "logs/a5a_dithering.txt" every 1 using 1:6 with lines title 'This paper' ls 3 lw 2, \
        "logs/a5a_exact_gradient.txt" every 1 using 1:4 with lines notitle ls 1 lw 2 dashtype '.-_', \
        "logs/a5a_exact_gradient.txt" every 1 using 1:5 with lines notitle ls 2 lw 2 dashtype '.-_', \
        "logs/a5a_exact_gradient.txt" every 1 using 1:6 with lines notitle ls 3 lw 2 dashtype '.-_', \

set title "Natural compression"
set output "figures/a5a_natural_compression.pdf"
plot    "logs/a5a_natural_compression.txt" every 1 using 1:4 with lines title 'ADCG' ls 1 lw 2, \
        "logs/a5a_natural_compression.txt" every 1 using 1:5 with lines title 'AMD+' ls 2 lw 2, \
        "logs/a5a_natural_compression.txt" every 1 using 1:6 with lines title 'This paper' ls 3 lw 2, \
        "logs/a5a_exact_gradient.txt" every 1 using 1:4 with lines notitle ls 1 lw 2 dashtype '.-_', \
        "logs/a5a_exact_gradient.txt" every 1 using 1:5 with lines notitle ls 2 lw 2 dashtype '.-_', \
        "logs/a5a_exact_gradient.txt" every 1 using 1:6 with lines notitle ls 3 lw 2 dashtype '.-_', \


set xlabel "Bits"
set xtics 250000
set xrange [1:1000000]
set format x "%2.0t{/Symbol \327}10^{%L}"

####### BITS
### MUSHROOM DATASET
set output "figures/mushrooms_random_sparsification_bits.pdf"
set title "Random sparsification"
plot    "logs/mushrooms_random_sparsification.txt" every 1 using 3:4 with lines title 'ADCG' ls 1 lw 2, \
        "logs/mushrooms_random_sparsification.txt" every 1 using 3:5 with lines title 'AMD+' ls 2 lw 2, \
        "logs/mushrooms_random_sparsification.txt" every 1 using 3:6 with lines title 'This paper' ls 3 lw 2, \
        "logs/mushrooms_exact_gradient.txt" every 1 using 2:4 with lines notitle ls 1 lw 2 dashtype '.-_', \
        "logs/mushrooms_exact_gradient.txt" every 1 using 2:5 with lines notitle ls 2 lw 2 dashtype '.-_', \
        "logs/mushrooms_exact_gradient.txt" every 1 using 2:6 with lines notitle ls 3 lw 2 dashtype '.-_', \

set title "Random dithering"
set output "figures/mushrooms_dithering_bits.pdf"
plot    "logs/mushrooms_dithering.txt" every 1 using 3:4 with lines title 'ADCG' ls 1 lw 2, \
        "logs/mushrooms_dithering.txt" every 1 using 3:5 with lines title 'AMD+' ls 2 lw 2, \
        "logs/mushrooms_dithering.txt" every 1 using 3:6 with lines title 'This paper' ls 3 lw 2, \
        "logs/mushrooms_exact_gradient.txt" every 1 using 2:4 with lines notitle ls 1 lw 2 dashtype '.-_', \
        "logs/mushrooms_exact_gradient.txt" every 1 using 2:5 with lines notitle ls 2 lw 2 dashtype '.-_', \
        "logs/mushrooms_exact_gradient.txt" every 1 using 2:6 with lines notitle ls 3 lw 2 dashtype '.-_', \

set title "Natural compression"
set output "figures/mushrooms_natural_compression_bits.pdf"
plot    "logs/mushrooms_natural_compression.txt" every 1 using 3:4 with lines title 'ADCG' ls 1 lw 2, \
        "logs/mushrooms_natural_compression.txt" every 1 using 3:5 with lines title 'AMD+' ls 2 lw 2, \
        "logs/mushrooms_natural_compression.txt" every 1 using 3:6 with lines title 'This paper' ls 3 lw 2, \
        "logs/mushrooms_exact_gradient.txt" every 1 using 2:4 with lines notitle ls 1 lw 2 dashtype '.-_', \
        "logs/mushrooms_exact_gradient.txt" every 1 using 2:5 with lines notitle ls 2 lw 2 dashtype '.-_', \
        "logs/mushrooms_exact_gradient.txt" every 1 using 2:6 with lines notitle ls 3 lw 2 dashtype '.-_', \

### A5A DATASET
set title "Random sparsification"
set output "figures/a5a_random_sparsification_bits.pdf"
plot    "logs/a5a_random_sparsification.txt" every 1 using 3:4 with lines title 'ADCG' ls 1 lw 2, \
        "logs/a5a_random_sparsification.txt" every 1 using 3:5 with lines title 'AMD+' ls 2 lw 2, \
        "logs/a5a_random_sparsification.txt" every 1 using 3:6 with lines title 'This paper' ls 3 lw 2, \
        "logs/a5a_exact_gradient.txt" every 1 using 2:4 with lines notitle ls 1 lw 2 dashtype '.-_', \
        "logs/a5a_exact_gradient.txt" every 1 using 2:5 with lines notitle ls 2 lw 2 dashtype '.-_', \
        "logs/a5a_exact_gradient.txt" every 1 using 2:6 with lines notitle ls 3 lw 2 dashtype '.-_', \

set title "Random dithering"
set output "figures/a5a_dithering_bits.pdf"
plot    "logs/a5a_dithering.txt" every 1 using 3:4 with lines title 'ADCG' ls 1 lw 2, \
        "logs/a5a_dithering.txt" every 1 using 3:5 with lines title 'AMD+' ls 2 lw 2, \
        "logs/a5a_dithering.txt" every 1 using 3:6 with lines title 'This paper' ls 3 lw 2, \
        "logs/a5a_exact_gradient.txt" every 1 using 2:4 with lines notitle ls 1 lw 2 dashtype '.-_', \
        "logs/a5a_exact_gradient.txt" every 1 using 2:5 with lines notitle ls 2 lw 2 dashtype '.-_', \
        "logs/a5a_exact_gradient.txt" every 1 using 2:6 with lines notitle ls 3 lw 2 dashtype '.-_', \

set title "Natural compression"
set output "figures/a5a_natural_compression_bits.pdf"
plot    "logs/a5a_natural_compression.txt" every 1 using 3:4 with lines title 'ADCG' ls 1 lw 2, \
        "logs/a5a_natural_compression.txt" every 1 using 3:5 with lines title 'AMD+' ls 2 lw 2, \
        "logs/a5a_natural_compression.txt" every 1 using 3:6 with lines title 'This paper' ls 3 lw 2, \
        "logs/a5a_exact_gradient.txt" every 1 using 2:4 with lines notitle ls 1 lw 2 dashtype '.-_', \
        "logs/a5a_exact_gradient.txt" every 1 using 2:5 with lines notitle ls 2 lw 2 dashtype '.-_', \
        "logs/a5a_exact_gradient.txt" every 1 using 2:6 with lines notitle ls 3 lw 2 dashtype '.-_', \



################## QUADRATIC ##################

reset

load 'dark2.pal'
load 'grid.cfg'

set xtics 250
set xrange [1:1000]
set yrange [1e-8:1e2]
set logscale y
set format y "10^{%L}"
set xlabel "training rounds (k)"
set ylabel "f(y_k) - f^*"

set terminal pdfcairo size 7cm, 5cm
set key bottom right
set key off

set output "figures/quadratic_exact_gradient.pdf"
set title "Exact gradients"
plot    "logs/MNIST_exact_gradient.txt" every 1 using 1:2 with lines title 'Mirror descent' ls 1 lw 2, \
        "logs/MNIST_exact_gradient.txt" every 1 using 1:3 with lines title 'Gradient descent' ls 2 lw 2, \
        "logs/MNIST_exact_gradient.txt" every 1 using 1:4 with lines title 'New algorithm' ls 3 lw 2, \
        "logs/MNIST_exact_gradient.txt" every 1 using 1:5 with lines title 'AMD+ (ICML 18)' ls 4 lw 2, \
        "logs/MNIST_exact_gradient.txt" every 1 using 1:6 with lines title 'muAMD+ (ICML 18)' ls 5 lw 2, \
        "logs/MNIST_exact_gradient.txt" every 1 using 1:7 with lines title 'ACGD (ICML 20)' ls 6 lw 2, \
        "logs/MNIST_exact_gradient.txt" every 1 using 1:8 with lines title 'muACGD (ICML 20)' ls 7 lw 2, \

set key on
set output "figures/quadratic_noisy_gradient.pdf"
set title "Noisy gradients"
plot    "logs/MNIST_noisy_gradient.txt" every 1 using 1:2 with lines title 'Mirror descent' ls 1 lw 2, \
        "logs/MNIST_noisy_gradient.txt" every 1 using 1:3 with lines title 'Gradient descent' ls 2 lw 2, \
        "logs/MNIST_noisy_gradient.txt" every 1 using 1:4 with lines title 'New algorithm' ls 3 lw 2, \
        "logs/MNIST_noisy_gradient.txt" every 1 using 1:5 with lines title 'AMD+ (ICML 18)' ls 4 lw 2, \
        "logs/MNIST_noisy_gradient.txt" every 1 using 1:6 with lines title 'muAMD+ (ICML 18)' ls 5 lw 2, \
        "logs/MNIST_noisy_gradient.txt" every 1 using 1:7 with lines title 'ACGD (ICML 20)' ls 6 lw 2, \
        "logs/MNIST_noisy_gradient.txt" every 1 using 1:8 with lines title 'muACGD (ICML 20)' ls 7 lw 2, \
