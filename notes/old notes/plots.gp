reset

load 'dark2.pal'
load 'grid.cfg'

set output "ps.tex"

set xtics 250
set yrange [1e-6:10]
set logscale y
set format y "10^{%L}"
set xlabel "Rounds"
set ylabel "Loss"

set terminal pdfcairo size 8.1cm, 5cm
set output "figures/ps.pdf"

plot    "logs/1.0.txt" every 1 using 1:2 with lines title 'p=1' ls 1 lw 2, \
        "logs/2.0.txt" every 1 using 1:2 with lines title 'p=2' ls 2 lw 2, \
        "logs/3.0.txt" every 1 using 1:2 with lines title 'p=3' ls 3 lw 2, \
        "logs/4.0.txt" every 1 using 1:2 with lines title 'p=4' ls 4 lw 2, \
        "logs/5.0.txt" every 1 using 1:2 with lines title 'p=5' ls 5 lw 2, \
        "logs/1000.0.txt" every 1 using 1:2 with lines title 'p=∞' ls 6 lw 2, \
      #  "logs/10.txt" every 1 using 1:2 with lines title 'λ=1/10' ls 7 lw 2, \


####

set terminal pdfcairo size 8.1cm, 5cm
set output "figures/psvar.pdf"

set yrange [1e-6:100]
set xlabel "Rounds"
set ylabel "Robustness"

plot    "logs/1.0.txt" every 1 using 1:3 with lines title 'p=1' ls 1 lw 2, \
        "logs/2.0.txt" every 1 using 1:3 with lines title 'p=2' ls 2 lw 2, \
        "logs/3.0.txt" every 1 using 1:3 with lines title 'p=3' ls 3 lw 2, \
        "logs/4.0.txt" every 1 using 1:3 with lines title 'p=4' ls 4 lw 2, \
        "logs/5.0.txt" every 1 using 1:3 with lines title 'p=5' ls 5 lw 2, \
        "logs/1000.0.txt" every 1 using 1:3 with lines title 'p=∞' ls 6 lw 2, \
      #  "logs/10.txt" every 1 using 1:3 with lines title 'λ=1/10' ls 7 lw 2, \
