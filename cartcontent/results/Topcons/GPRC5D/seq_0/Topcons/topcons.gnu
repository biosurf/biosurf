set encoding iso_8859_1
set xrange [1:345]
set yrange [0.83:1.1]
set autoscale xfix
set ter png enh interlace size 2400,840 font 'Nimbus,40'
set xlabel 'Position'
set ylabel 'Reliability           ' 
set ytics nomirror 0.8,0.1,1
set out '/static/tmp/tmp_ZnE0xm/rst_4wTEwB/seq_0///Topcons/topcons.large.png'
set tmargin 1.3
set lmargin 11.5
set rmargin 6.5
set label 'TOPCONS' font 'Nimbus,42' at screen 0.022,0.775
set object 1 rect from 44.5,1.04 to 60.5,1.04325 fc rgb "red" fs noborder
set object 2 rect from 113.5,1.04 to 125.5,1.04325 fc rgb "red" fs noborder
set object 3 rect from 190.5,1.04 to 203.5,1.04325 fc rgb "red" fs noborder
set object 4 rect from 261.5,1.04 to 345.5,1.04325 fc rgb "red" fs noborder
set object 5 rect from 0.5,1.05425 to 23.5,1.0575 fc rgb "blue" fs noborder
set object 6 rect from 81.5,1.05425 to 92.5,1.0575 fc rgb "blue" fs noborder
set object 7 rect from 146.5,1.05425 to 169.5,1.0575 fc rgb "blue" fs noborder
set object 8 rect from 224.5,1.05425 to 240.5,1.0575 fc rgb "blue" fs noborder
set object 9 rect from 23.5,1.04 to 44.5,1.0575 fc rgb "white"
set object 10 rect from 60.5,1.04 to 81.5,1.0575 fc rgb "grey" fs noborder
set object 11 rect from 92.5,1.04 to 113.5,1.0575 fc rgb "white"
set object 12 rect from 125.5,1.04 to 146.5,1.0575 fc rgb "grey" fs noborder
set object 13 rect from 169.5,1.04 to 190.5,1.0575 fc rgb "white"
set object 14 rect from 203.5,1.04 to 224.5,1.0575 fc rgb "grey" fs noborder
set object 15 rect from 240.5,1.04 to 261.5,1.0575 fc rgb "white"
set object 16 rect from 23.5,1.04 to 44.5,1.0575 fc rgb "white"
set object 17 rect from 60.5,1.04 to 81.5,1.0575 fc rgb "grey" fs noborder
set object 18 rect from 92.5,1.04 to 113.5,1.0575 fc rgb "white"
set object 19 rect from 125.5,1.04 to 146.5,1.0575 fc rgb "grey" fs noborder
set object 20 rect from 169.5,1.04 to 190.5,1.0575 fc rgb "white"
set object 21 rect from 203.5,1.04 to 224.5,1.0575 fc rgb "grey" fs noborder
set object 22 rect from 240.5,1.04 to 261.5,1.0575 fc rgb "white"
plot '/static/tmp/tmp_ZnE0xm/rst_4wTEwB/seq_0///Topcons/reliability.final' w l t '' lc rgb "black" lw 4
exit
