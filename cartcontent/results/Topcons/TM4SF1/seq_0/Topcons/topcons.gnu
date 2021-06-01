set encoding iso_8859_1
set xrange [1:202]
set yrange [0.83:1.1]
set autoscale xfix
set ter png enh interlace size 2400,840 font 'Nimbus,40'
set xlabel 'Position'
set ylabel 'Reliability           ' 
set ytics nomirror 0.8,0.1,1
set out '/static/tmp/tmp_rncf27/rst_AwPISd/seq_0///Topcons/topcons.large.png'
set tmargin 1.3
set lmargin 11.5
set rmargin 6.5
set label 'TOPCONS' font 'Nimbus,42' at screen 0.022,0.775
set object 1 rect from 0.5,1.04 to 8.5,1.04325 fc rgb "red" fs noborder
set object 2 rect from 67.5,1.04 to 91.5,1.04325 fc rgb "red" fs noborder
set object 3 rect from 180.5,1.04 to 202.5,1.04325 fc rgb "red" fs noborder
set object 4 rect from 29.5,1.05425 to 46.5,1.0575 fc rgb "blue" fs noborder
set object 5 rect from 112.5,1.05425 to 159.5,1.0575 fc rgb "blue" fs noborder
set object 6 rect from 8.5,1.04 to 29.5,1.0575 fc rgb "grey" fs noborder
set object 7 rect from 46.5,1.04 to 67.5,1.0575 fc rgb "white"
set object 8 rect from 91.5,1.04 to 112.5,1.0575 fc rgb "grey" fs noborder
set object 9 rect from 159.5,1.04 to 180.5,1.0575 fc rgb "white"
set object 10 rect from 8.5,1.04 to 29.5,1.0575 fc rgb "grey" fs noborder
set object 11 rect from 46.5,1.04 to 67.5,1.0575 fc rgb "white"
set object 12 rect from 91.5,1.04 to 112.5,1.0575 fc rgb "grey" fs noborder
set object 13 rect from 159.5,1.04 to 180.5,1.0575 fc rgb "white"
plot '/static/tmp/tmp_rncf27/rst_AwPISd/seq_0///Topcons/reliability.final' w l t '' lc rgb "black" lw 4
exit
