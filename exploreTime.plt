#LKB(c) 2014
#plots LGO observation file, after processing through python using PlotLGO_obs.bat
#IN cols are: Point Id,Hz,3.V,Height Diff.,5.Slope Dist.,Date/Time (corrected),7.Geometric PPM,Atmospheric PPM

#gnuplot -e "InFilename='AfterBridge.csv'" exploreTime.plt


#clean all
#reset
#set data
set datafile separator ","
set key top left samplen 3 spacing 1.2 font "Arial,12"
set style data points


##########################
#MAIN code
#########################


# print to the file
# with multiplot replot wont work 
#pngcairo support dashed, png does not
set terminal pngcairo dashed size 1920,1080 enhanced font 'Arial,20'
#1920,1080 #3840,2160
set output sprintf("%s.png",InFilename)
#set terminal wxt 0 dashed size 1620,900

#for equal axis but it seems not to work
#set size square
set grid
#set ylabel "Time as well?"

set ytics 100
set mytics 10 #minor
set xtics 1
set mxtics 6 #minor

set xdata time
set timefmt "%H:%M:%S"
set format x "%H:%M:%S"
set xtics out rotate by -90

set title sprintf("Nivel220 output using av %s settings",InFilename)

#set xrange ["3/12/2014 15:37:50":"3/12/2014 15:38:10"] #after reestablishing station
#set xrange ["20:12:50":"22:38:10"]
set xrange ["10:08:29":"10:08:41"]
set yrange [3318800:3319800]
set format y "%.0f"

# PLOT DATA
plot InFilename u 2:1 w p notitle 
#plot InFilename.csv u 2:($1/100) w p notitle 
#t "Compare times"
#,\

#Plot on Screen
#set terminal wxt 0 size 1620,900 
#replot

##########################
#END of scipt
#########################

#for non-batch running use pause to see results
#pause -1 "PRESS ENTER TO EXIT PROGRAMME LKB(c)"