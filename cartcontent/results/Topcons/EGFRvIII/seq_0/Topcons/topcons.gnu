set encoding iso_8859_1
set xrange [1:705]
set yrange [0.83:1.1]
set autoscale xfix
set ter png enh interlace size 2400,840 font 'Nimbus,40'
set xlabel 'Position'
set ylabel 'Reliability           ' 
set ytics nomirror 0.5,0.1,0.9
set out '/static/tmp/tmp_MmRuxl/rst_QZWg9t/seq_0///Topcons/topcons.large.png'
set tmargin 1.3
set lmargin 11.5
set rmargin 6.5
set label 'TOPCONS' font 'Nimbus,42' at screen 0.022,0.775
set object 1 rect from 24.5,1.0085 to 705.5,1.015 fc rgb "blue" fs noborder
set object 2 rect from 0.5,0.98 to 24.5,1.015 fc rgb "black" fs noborder
plot '/static/tmp/tmp_MmRuxl/rst_QZWg9t/seq_0///Topcons/reliability.final' w l t '' lc rgb "black" lw 4
exit
