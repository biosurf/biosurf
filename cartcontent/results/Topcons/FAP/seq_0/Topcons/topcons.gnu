set encoding iso_8859_1
set xrange [1:760]
set yrange [0.83:1.15]
set autoscale xfix
set ter png enh interlace size 2400,840 font 'Nimbus,40'
set xlabel 'Position'
set ylabel 'Reliability           ' 
set ytics nomirror 0.4,0.1,0.9
set out '/static/tmp/tmp_ldfeXy/rst_yLOAEE/seq_0///Topcons/topcons.large.png'
set tmargin 1.3
set lmargin 11.5
set rmargin 6.5
set label 'TOPCONS' font 'Nimbus,42' at screen 0.022,0.775
set object 1 rect from 28.5,1.035625 to 760.5,1.04375 fc rgb "blue" fs noborder
set object 2 rect from 0.5,1 to 28.5,1.04375 fc rgb "black" fs noborder
plot '/static/tmp/tmp_ldfeXy/rst_yLOAEE/seq_0///Topcons/reliability.final' w l t '' lc rgb "black" lw 4
exit
