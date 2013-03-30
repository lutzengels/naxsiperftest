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
 
#plot "results.csv" using 1 smooth sbezier with lines title ""
plot "results.csv" using 1 with lines title ""