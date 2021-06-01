set encoding iso_8859_1
set xrange [1:856]
set yrange [0.83:1.25]
set autoscale xfix
set ter png enh interlace size 2400,840 font 'Nimbus,40'
set xlabel 'Position'
set ylabel 'Reliability           ' 
set ytics nomirror 0.5,0.1,1
set out '/big/server/web_common_backend/proj/pred/static/tmp/tmp__R3H40/rst_UItgsq//seq_0///Topcons/topcons.large.png'
set tmargin 1.3
set lmargin 11.5
set rmargin 6.5
set label 'TOPCONS' font 'Nimbus,42' at screen 0.022,0.775
set object 1 rect from 121.5,1.1 to 148.5,1.108125 fc rgb "red" fs noborder
set object 2 rect from 447.5,1.1 to 477.5,1.108125 fc rgb "red" fs noborder
set object 3 rect from 804.5,1.1 to 856.5,1.108125 fc rgb "red" fs noborder
set object 4 rect from 21.5,1.135625 to 100.5,1.14375 fc rgb "blue" fs noborder
set object 5 rect from 169.5,1.135625 to 426.5,1.14375 fc rgb "blue" fs noborder
set object 6 rect from 498.5,1.135625 to 783.5,1.14375 fc rgb "blue" fs noborder
set object 7 rect from 100.5,1.1 to 121.5,1.14375 fc rgb "white"
set object 8 rect from 148.5,1.1 to 169.5,1.14375 fc rgb "grey" fs noborder
set object 9 rect from 426.5,1.1 to 447.5,1.14375 fc rgb "white"
set object 10 rect from 477.5,1.1 to 498.5,1.14375 fc rgb "grey" fs noborder
set object 11 rect from 783.5,1.1 to 804.5,1.14375 fc rgb "white"
set object 12 rect from 100.5,1.1 to 121.5,1.14375 fc rgb "white"
set object 13 rect from 148.5,1.1 to 169.5,1.14375 fc rgb "grey" fs noborder
set object 14 rect from 426.5,1.1 to 447.5,1.14375 fc rgb "white"
set object 15 rect from 477.5,1.1 to 498.5,1.14375 fc rgb "grey" fs noborder
set object 16 rect from 783.5,1.1 to 804.5,1.14375 fc rgb "white"
set object 17 rect from 0.5,1.1 to 21.5,1.14375 fc rgb "black" fs noborder
plot '/big/server/web_common_backend/proj/pred/static/tmp/tmp__R3H40/rst_UItgsq//seq_0///Topcons/reliability.final' w l t '' lc rgb "black" lw 4
exit
