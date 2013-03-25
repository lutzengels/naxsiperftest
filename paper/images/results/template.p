# output as png image
set terminal png
 
# save file to "output.png"
set output "output.png"
 
# nicer aspect ratio for image size
set size 1,0.7
 
# y-axis grid
set grid y
 
# x-axis label
set xlabel "parameters"
 
# y-axis label
set ylabel "response time (ms)"
 
set style line 1 lt 1 linecolor rgb "#ff0000"

plot "results.csv" using 1 ls 1 smooth sbezier with lines title ""
