set encoding iso_8859_1
set xrange [1:281]
set yrange [0.83:1.1]
set autoscale xfix
set ter png enh interlace size 2400,840 font 'Nimbus,40'
set xlabel 'Position'
set ylabel 'Reliability           ' 
set ytics nomirror 0.8,0.1,1
set out '/static/tmp/tmp_47FL_U/rst_qoJFNj/seq_0///Topcons/topcons.large.png'
set tmargin 1.3
set lmargin 11.5
set rmargin 6.5
set label 'TOPCONS' font 'Nimbus,42' at screen 0.022,0.775
set object 1 rect from 0.5,1.04 to 13.5,1.04325 fc rgb "red" fs noborder
set object 2 rect from 78.5,1.04 to 85.5,1.04325 fc rgb "red" fs noborder
set object 3 rect from 263.5,1.04 to 281.5,1.04325 fc rgb "red" fs noborder
set object 4 rect from 34.5,1.05425 to 57.5,1.0575 fc rgb "blue" fs noborder
set object 5 rect from 106.5,1.05425 to 242.5,1.0575 fc rgb "blue" fs noborder
set object 6 rect from 13.5,1.04 to 34.5,1.0575 fc rgb "grey" fs noborder
set object 7 rect from 57.5,1.04 to 78.5,1.0575 fc rgb "white"
set object 8 rect from 85.5,1.04 to 106.5,1.0575 fc rgb "grey" fs noborder
set object 9 rect from 242.5,1.04 to 263.5,1.0575 fc rgb "white"
set object 10 rect from 13.5,1.04 to 34.5,1.0575 fc rgb "grey" fs noborder
set object 11 rect from 57.5,1.04 to 78.5,1.0575 fc rgb "white"
set object 12 rect from 85.5,1.04 to 106.5,1.0575 fc rgb "grey" fs noborder
set object 13 rect from 242.5,1.04 to 263.5,1.0575 fc rgb "white"
plot '/static/tmp/tmp_47FL_U/rst_qoJFNj/seq_0///Topcons/reliability.final' w l t '' lc rgb "black" lw 4
exit
