set encoding iso_8859_1
set xrange [1:440]
set yrange [0.83:1.25]
set autoscale xfix
set ter png enh interlace size 2400,840 font 'Nimbus,40'
set xlabel 'Position'
set ylabel 'Reliability           ' 
set ytics nomirror 0.5,0.1,1
set out '/static/tmp/tmp_j5ZKmt/rst_9wdQtz/seq_0///Topcons/topcons.large.png'
set tmargin 1.3
set lmargin 11.5
set rmargin 6.5
set label 'TOPCONS' font 'Nimbus,42' at screen 0.022,0.775
set object 1 rect from 0.5,1.1 to 33.5,1.108125 fc rgb "red" fs noborder
set object 2 rect from 233.5,1.1 to 440.5,1.108125 fc rgb "red" fs noborder
set object 3 rect from 54.5,1.135625 to 212.5,1.14375 fc rgb "blue" fs noborder
set object 4 rect from 33.5,1.1 to 54.5,1.14375 fc rgb "grey" fs noborder
set object 5 rect from 212.5,1.1 to 233.5,1.14375 fc rgb "white"
set object 6 rect from 33.5,1.1 to 54.5,1.14375 fc rgb "grey" fs noborder
set object 7 rect from 212.5,1.1 to 233.5,1.14375 fc rgb "white"
plot '/static/tmp/tmp_j5ZKmt/rst_9wdQtz/seq_0///Topcons/reliability.final' w l t '' lc rgb "black" lw 4
exit
