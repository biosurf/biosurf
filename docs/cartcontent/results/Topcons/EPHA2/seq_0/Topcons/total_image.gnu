set style line 11 lt 1 lw 1 lc rgb "blue"
set encoding iso_8859_1
set yrange [0:50]
set xrange [1:976]
set y2range [-2:35.4]
set autoscale xfix
set ter png enh interlace size 2400,1680 font 'Nimbus,40'
set y2label '{/Symbol D}G (kcal/mol)                                             ' tc lt 3
set ytics scale 1,0.0 nomirror ("2k9yA" 26.9 0, "SPOCTOPUS" 32.9 0, "SCAMPI" 35.9 0, "PolyPhobius" 38.9 0, "Philius" 41.9 0, "OCTOPUS" 44.9 0, "TOPCONS" 47.9 0)
set y2tics nomirror -2,2,15
set out '/static/tmp/tmp_hQtgBN/rst_FsgAFJ/seq_0///Topcons/total_image.large.png'
set lmargin 13.5
set rmargin 6.5
set tmargin 1.3
set object 1 rect from screen 0.19,0.986 to screen 0.21,0.992 fc rgb "red" fs noborder
set label 'Inside' font 'Nimbus,30' at screen 0.215,0.982
set object 2 rect from screen 0.28,0.986 to screen 0.30,0.992 fc rgb "blue" fs noborder
set label 'Outside' font 'Nimbus,30' at screen 0.305,0.982
set object 3 rect from screen 0.38,0.978 to screen 0.40,1 fc rgb "grey" fs noborder
set label 'TM-helix (IN->OUT)' font 'Nimbus,30' at screen 0.405,0.982
set object 4 rect from screen 0.57,0.978 to screen 0.59,1 fc rgb "white"
set label 'TM-helix (OUT->IN)' font 'Nimbus,30' at screen 0.595,0.982
set object 5 rect from screen 0.76,0.978 to screen 0.78,1 fc rgb "black"
set label 'Signal peptide' font 'Nimbus,30' at screen 0.785,0.982
set ytic scale 0
set object 6 rect from 558.5,26.4 to 976.5,26.6 fc rgb "red" fs noborder
set object 7 rect from 0.5,27.2 to 542.5,27.4 fc rgb "blue" fs noborder
set object 8 rect from 542.5,26.4 to 558.5,27.4 fc rgb "white"
set object 9 rect from 542.5,26.4 to 558.5,27.4 fc rgb "white"
set object 10 rect from 556.5,32.4 to 976.5,32.6 fc rgb "red" fs noborder
set object 11 rect from 22.5,33.2 to 535.5,33.4 fc rgb "blue" fs noborder
set object 12 rect from 535.5,32.4 to 556.5,33.4 fc rgb "white"
set object 13 rect from 535.5,32.4 to 556.5,33.4 fc rgb "white"
set object 14 rect from 0.5,32.4 to 22.5,33.4 fc rgb "black" fs noborder
set object 15 rect from 24.5,35.4 to 177.5,35.6 fc rgb "red" fs noborder
set object 16 rect from 558.5,35.4 to 710.5,35.6 fc rgb "red" fs noborder
set object 17 rect from 0.5,36.2 to 3.5,36.4 fc rgb "blue" fs noborder
set object 18 rect from 198.5,36.2 to 537.5,36.4 fc rgb "blue" fs noborder
set object 19 rect from 731.5,36.2 to 976.5,36.4 fc rgb "blue" fs noborder
set object 20 rect from 3.5,35.4 to 24.5,36.4 fc rgb "white"
set object 21 rect from 177.5,35.4 to 198.5,36.4 fc rgb "grey" fs noborder
set object 22 rect from 537.5,35.4 to 558.5,36.4 fc rgb "white"
set object 23 rect from 710.5,35.4 to 731.5,36.4 fc rgb "grey" fs noborder
set object 24 rect from 3.5,35.4 to 24.5,36.4 fc rgb "white"
set object 25 rect from 177.5,35.4 to 198.5,36.4 fc rgb "grey" fs noborder
set object 26 rect from 537.5,35.4 to 558.5,36.4 fc rgb "white"
set object 27 rect from 710.5,35.4 to 731.5,36.4 fc rgb "grey" fs noborder
set object 28 rect from 558.5,38.4 to 976.5,38.6 fc rgb "red" fs noborder
set object 29 rect from 23.5,39.2 to 535.5,39.4 fc rgb "blue" fs noborder
set object 30 rect from 535.5,38.4 to 558.5,39.4 fc rgb "white"
set object 31 rect from 535.5,38.4 to 558.5,39.4 fc rgb "white"
set object 32 rect from 0.5,38.4 to 23.5,39.4 fc rgb "black" fs noborder
set object 33 rect from 558.5,41.4 to 976.5,41.6 fc rgb "red" fs noborder
set object 34 rect from 24.5,42.2 to 534.5,42.4 fc rgb "blue" fs noborder
set object 35 rect from 534.5,41.4 to 558.5,42.4 fc rgb "white"
set object 36 rect from 534.5,41.4 to 558.5,42.4 fc rgb "white"
set object 37 rect from 0.5,41.4 to 24.5,42.4 fc rgb "black" fs noborder
set object 38 rect from 556.5,44.4 to 976.5,44.6 fc rgb "red" fs noborder
set object 39 rect from 0.5,45.2 to 535.5,45.4 fc rgb "blue" fs noborder
set object 40 rect from 535.5,44.4 to 556.5,45.4 fc rgb "white"
set object 41 rect from 535.5,44.4 to 556.5,45.4 fc rgb "white"
set object 42 rect from 556.5,47.4 to 976.5,47.6 fc rgb "red" fs noborder
set object 43 rect from 23.5,48.2 to 535.5,48.4 fc rgb "blue" fs noborder
set object 44 rect from 535.5,47.4 to 556.5,48.4 fc rgb "white"
set object 45 rect from 535.5,47.4 to 556.5,48.4 fc rgb "white"
set object 46 rect from 0.5,47.4 to 23.5,48.4 fc rgb "black" fs noborder
plot '/static/tmp/tmp_hQtgBN/rst_FsgAFJ/seq_0///DG1.txt' axes x1y2 w l t '' lt 3 lw 4
exit
