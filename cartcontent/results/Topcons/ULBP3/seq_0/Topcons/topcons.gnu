set encoding iso_8859_1
set xrange [1:244]
set yrange [0.83:1.1]
set autoscale xfix
set ter png enh interlace size 2400,840 font 'Nimbus,40'
set xlabel 'Position'
set ylabel 'Reliability           ' 
set ytics nomirror 0.5,0.1,0.9
set out '/static/tmp/tmp_STZMA6/rst_eH6UOW/seq_0///Topcons/topcons.large.png'
set tmargin 1.3
set lmargin 11.5
set rmargin 6.5
set label 'TOPCONS' font 'Nimbus,42' at screen 0.022,0.775
set object 1 rect from 243.5,0.98 to 244.5,0.9865 fc rgb "red" fs noborder
set object 2 rect from 26.5,1.0085 to 222.5,1.015 fc rgb "blue" fs noborder
set object 3 rect from 222.5,0.98 to 243.5,1.015 fc rgb "white"
set object 4 rect from 222.5,0.98 to 243.5,1.015 fc rgb "white"
set object 5 rect from 0.5,0.98 to 26.5,1.015 fc rgb "black" fs noborder
plot '/static/tmp/tmp_STZMA6/rst_eH6UOW/seq_0///Topcons/reliability.final' w l t '' lc rgb "black" lw 4
exit