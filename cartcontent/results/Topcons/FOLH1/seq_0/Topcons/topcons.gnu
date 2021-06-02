set encoding iso_8859_1
set xrange [1:750]
set yrange [0.83:1.05]
set autoscale xfix
set ter png enh interlace size 2400,840 font 'Nimbus,40'
set xlabel 'Position'
set ylabel 'Reliability           ' 
set ytics nomirror 0.9,0.1,1
set out '/static/tmp/tmp_ZwIR5L/rst_cXNlun/seq_0///Topcons/topcons.large.png'
set tmargin 1.3
set lmargin 11.5
set rmargin 6.5
set label 'TOPCONS' font 'Nimbus,42' at screen 0.022,0.775
set object 1 rect from 0.5,1.02 to 19.5,1.021625 fc rgb "red" fs noborder
set object 2 rect from 40.5,1.027125 to 750.5,1.02875 fc rgb "blue" fs noborder
set object 3 rect from 19.5,1.02 to 40.5,1.02875 fc rgb "grey" fs noborder
set object 4 rect from 19.5,1.02 to 40.5,1.02875 fc rgb "grey" fs noborder
plot '/static/tmp/tmp_ZwIR5L/rst_cXNlun/seq_0///Topcons/reliability.final' w l t '' lc rgb "black" lw 4
exit
