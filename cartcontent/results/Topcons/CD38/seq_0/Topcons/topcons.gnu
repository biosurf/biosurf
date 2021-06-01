set encoding iso_8859_1
set xrange [1:300]
set yrange [0.83:1.15]
set autoscale xfix
set ter png enh interlace size 2400,840 font 'Nimbus,40'
set xlabel 'Position'
set ylabel 'Reliability           ' 
set ytics nomirror 0.7,0.1,1
set out '/static/tmp/tmp_Nt32Z2/rst_hygdDv/seq_0///Topcons/topcons.large.png'
set tmargin 1.3
set lmargin 11.5
set rmargin 6.5
set label 'TOPCONS' font 'Nimbus,42' at screen 0.022,0.775
set object 1 rect from 0.5,1.06 to 22.5,1.064875 fc rgb "red" fs noborder
set object 2 rect from 43.5,1.081375 to 300.5,1.08625 fc rgb "blue" fs noborder
set object 3 rect from 22.5,1.06 to 43.5,1.08625 fc rgb "grey" fs noborder
set object 4 rect from 22.5,1.06 to 43.5,1.08625 fc rgb "grey" fs noborder
plot '/static/tmp/tmp_Nt32Z2/rst_hygdDv/seq_0///Topcons/reliability.final' w l t '' lc rgb "black" lw 4
exit
