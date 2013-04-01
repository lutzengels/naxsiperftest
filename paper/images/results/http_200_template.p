# output as png image
set terminal png
 
# save file to "output.png"
set output "output.png"
 
# graph a title
 
# nicer aspect ratio for image size
set size 1,0.7
 
# y-axis grid
set grid y
 
# x-axis label
set xlabel "parameters"
 
# y-axis label
set ylabel "requests per second"

set datafile separator ","

set style line 1 lt 1 linecolor rgb "#c0c0c0"
set style line 2 lt 1 linecolor rgb "#ff0000"

plot "results.csv" title "low-avg-high" ls 1 with errorbars, "" smooth csplines ls 2 t "average"
