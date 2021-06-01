set encoding iso_8859_1
set xrange [1:943]
set yrange [0.83:1.3]
set autoscale xfix
set ter png enh interlace size 2400,840 font 'Nimbus,40'
set xlabel 'Position'
set ylabel 'Reliability           ' 
set ytics nomirror 0.4,0.1,1
set out '/static/tmp/tmp_ydMW1X/rst_qppjw0/seq_0///Topcons/topcons.large.png'
set tmargin 1.3
set lmargin 11.5
set rmargin 6.5
set label 'TOPCONS' font 'Nimbus,42' at screen 0.022,0.775
set object 1 rect from 426.5,1.12 to 943.5,1.12975 fc rgb "red" fs noborder
set object 2 rect from 30.5,1.16275 to 405.5,1.1725 fc rgb "blue" fs noborder
set object 3 rect from 405.5,1.12 to 426.5,1.1725 fc rgb "white"
set object 4 rect from 405.5,1.12 to 426.5,1.1725 fc rgb "white"
set object 5 rect from 0.5,1.12 to 30.5,1.1725 fc rgb "black" fs noborder
plot '/static/tmp/tmp_ydMW1X/rst_qppjw0/seq_0///Topcons/reliability.final' w l t '' lc rgb "black" lw 4
exit
