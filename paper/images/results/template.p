# output as png image
set terminal png
 
# save file to "output.png"
set output "output.png"
 
# nicer aspect ratio for image size
set size 1,0.7
 
# y-axis grid
set grid y
 
# x-axis label
set xlabel "concurrent requests"
 
# y-axis label
set ylabel "response time (ms)"
 
# set style line 1 lt 1 linecolor rgb "#0000ff"
# set style line 2 lt 1 linecolor rgb "#000000"

plot "results.csv" using 8 smooth sbezier with lines title ""
