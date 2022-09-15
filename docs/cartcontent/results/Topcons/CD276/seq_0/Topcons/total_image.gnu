set style line 11 lt 1 lw 1 lc rgb "blue"
set encoding iso_8859_1
set yrange [0:50]
set xrange [1:534]
set y2range [-2:38.8]
set autoscale xfix
set ter png enh interlace size 2400,1680 font 'Nimbus,40'
set y2label '{/Symbol D}G (kcal/mol)                                             ' tc lt 3
set ytics scale 1,0.0 nomirror ("2m59A" 26.9 0, "SPOCTOPUS" 32.9 0, "SCAMPI" 35.9 0, "PolyPhobius" 38.9 0, "Philius" 41.9 0, "OCTOPUS" 44.9 0, "TOPCONS" 47.9 0)
set y2tics nomirror -3,2,16
set out '/big/server/web_common_backend/proj/pred/static/tmp/tmp_YxTMW6/rst_r11GAq//seq_0///Topcons/total_image.large.png'
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
set object 6 rect from 100.5,27.2 to 164.5,27.4 fc rgb "blue" fs noborder
set object 7 rect from 165.5,27.2 to 180.5,27.4 fc rgb "blue" fs noborder
set object 8 rect from 181.5,27.2 to 194.5,27.4 fc rgb "blue" fs noborder
set object 9 rect from 199.5,27.2 to 200.5,27.4 fc rgb "blue" fs noborder
set object 10 rect from 202.5,27.2 to 256.5,27.4 fc rgb "blue" fs noborder
set object 11 rect from 258.5,27.2 to 277.5,27.4 fc rgb "blue" fs noborder
set object 12 rect from 279.5,27.2 to 289.5,27.4 fc rgb "blue" fs noborder
set object 13 rect from 487.5,32.4 to 534.5,32.6 fc rgb "red" fs noborder
set object 14 rect from 30.5,33.2 to 466.5,33.4 fc rgb "blue" fs noborder
set object 15 rect from 466.5,32.4 to 487.5,33.4 fc rgb "white"
set object 16 rect from 466.5,32.4 to 487.5,33.4 fc rgb "white"
set object 17 rect from 0.5,32.4 to 30.5,33.4 fc rgb "black" fs noborder
set object 18 rect from 0.5,35.4 to 8.5,35.6 fc rgb "red" fs noborder
set object 19 rect from 488.5,35.4 to 534.5,35.6 fc rgb "red" fs noborder
set object 20 rect from 29.5,36.2 to 467.5,36.4 fc rgb "blue" fs noborder
set object 21 rect from 8.5,35.4 to 29.5,36.4 fc rgb "grey" fs noborder
set object 22 rect from 467.5,35.4 to 488.5,36.4 fc rgb "white"
set object 23 rect from 8.5,35.4 to 29.5,36.4 fc rgb "grey" fs noborder
set object 24 rect from 467.5,35.4 to 488.5,36.4 fc rgb "white"
set object 25 rect from 488.5,38.4 to 534.5,38.6 fc rgb "red" fs noborder
set object 26 rect from 28.5,39.2 to 465.5,39.4 fc rgb "blue" fs noborder
set object 27 rect from 465.5,38.4 to 488.5,39.4 fc rgb "white"
set object 28 rect from 465.5,38.4 to 488.5,39.4 fc rgb "white"
set object 29 rect from 0.5,38.4 to 28.5,39.4 fc rgb "black" fs noborder
set object 30 rect from 488.5,41.4 to 534.5,41.6 fc rgb "red" fs noborder
set object 31 rect from 28.5,42.2 to 465.5,42.4 fc rgb "blue" fs noborder
set object 32 rect from 465.5,41.4 to 488.5,42.4 fc rgb "white"
set object 33 rect from 465.5,41.4 to 488.5,42.4 fc rgb "white"
set object 34 rect from 0.5,41.4 to 28.5,42.4 fc rgb "black" fs noborder
set object 35 rect from 487.5,44.4 to 534.5,44.6 fc rgb "red" fs noborder
set object 36 rect from 0.5,45.2 to 466.5,45.4 fc rgb "blue" fs noborder
set object 37 rect from 466.5,44.4 to 487.5,45.4 fc rgb "white"
set object 38 rect from 466.5,44.4 to 487.5,45.4 fc rgb "white"
set object 39 rect from 487.5,47.4 to 534.5,47.6 fc rgb "red" fs noborder
set object 40 rect from 28.5,48.2 to 466.5,48.4 fc rgb "blue" fs noborder
set object 41 rect from 466.5,47.4 to 487.5,48.4 fc rgb "white"
set object 42 rect from 466.5,47.4 to 487.5,48.4 fc rgb "white"
set object 43 rect from 0.5,47.4 to 28.5,48.4 fc rgb "black" fs noborder
plot '/big/server/web_common_backend/proj/pred/static/tmp/tmp_YxTMW6/rst_r11GAq//seq_0///DG1.txt' axes x1y2 w l t '' lt 3 lw 4
exit
