set encoding iso_8859_1
set xrange [1:865]
set yrange [0.83:1.25]
set autoscale xfix
set ter png enh interlace size 2400,840 font 'Nimbus,40'
set xlabel 'Position'
set ylabel 'Reliability           ' 
set ytics nomirror 0.5,0.1,1
set out '/static/tmp/tmp_IxEurd/rst_LcbiDo/seq_0///Topcons/topcons.large.png'
set tmargin 1.3
set lmargin 11.5
set rmargin 6.5
set label 'TOPCONS' font 'Nimbus,42' at screen 0.022,0.775
set object 1 rect from 127.5,1.1 to 157.5,1.108125 fc rgb "red" fs noborder
set object 2 rect from 456.5,1.1 to 485.5,1.108125 fc rgb "red" fs noborder
set object 3 rect from 813.5,1.1 to 865.5,1.108125 fc rgb "red" fs noborder
set object 4 rect from 21.5,1.135625 to 106.5,1.14375 fc rgb "blue" fs noborder
set object 5 rect from 178.5,1.135625 to 435.5,1.14375 fc rgb "blue" fs noborder
set object 6 rect from 506.5,1.135625 to 792.5,1.14375 fc rgb "blue" fs noborder
set object 7 rect from 106.5,1.1 to 127.5,1.14375 fc rgb "white"
set object 8 rect from 157.5,1.1 to 178.5,1.14375 fc rgb "grey" fs noborder
set object 9 rect from 435.5,1.1 to 456.5,1.14375 fc rgb "white"
set object 10 rect from 485.5,1.1 to 506.5,1.14375 fc rgb "grey" fs noborder
set object 11 rect from 792.5,1.1 to 813.5,1.14375 fc rgb "white"
set object 12 rect from 106.5,1.1 to 127.5,1.14375 fc rgb "white"
set object 13 rect from 157.5,1.1 to 178.5,1.14375 fc rgb "grey" fs noborder
set object 14 rect from 435.5,1.1 to 456.5,1.14375 fc rgb "white"
set object 15 rect from 485.5,1.1 to 506.5,1.14375 fc rgb "grey" fs noborder
set object 16 rect from 792.5,1.1 to 813.5,1.14375 fc rgb "white"
set object 17 rect from 0.5,1.1 to 21.5,1.14375 fc rgb "black" fs noborder
plot '/static/tmp/tmp_IxEurd/rst_LcbiDo/seq_0///Topcons/reliability.final' w l t '' lc rgb "black" lw 4
exit
