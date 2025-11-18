set style line 11 lt 1 lw 1 lc rgb "blue"
set encoding iso_8859_1
set yrange [0:50]
set xrange [1:630]
set y2range [-2:30.8]
set autoscale xfix
set ter png enh interlace size 2400,1680 font 'Nimbus,40'
set y2label '{/Symbol D}G (kcal/mol)                                             ' tc lt 3
set ytics scale 1,0.0 nomirror ("PDB-homology" 26.9 0, "SPOCTOPUS" 32.9 0, "SCAMPI" 35.9 0, "PolyPhobius" 38.9 0, "Philius" 41.9 0, "OCTOPUS" 44.9 0, "TOPCONS" 47.9 0)
set y2tics nomirror 0,2,14
set out '/static/tmp/tmp_PxXSud/rst_R4wyer/seq_0///Topcons/total_image.large.png'
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
set label "***No homologous TM proteins detected***" at 10, 26.4 font "Nimbus,35"
set object 6 rect from 629.5,32.4 to 630.5,32.6 fc rgb "red" fs noborder
set object 7 rect from 36.5,33.2 to 608.5,33.4 fc rgb "blue" fs noborder
set object 8 rect from 608.5,32.4 to 629.5,33.4 fc rgb "white"
set object 9 rect from 608.5,32.4 to 629.5,33.4 fc rgb "white"
set object 10 rect from 0.5,32.4 to 36.5,33.4 fc rgb "black" fs noborder
set object 11 rect from 33.5,35.4 to 608.5,35.6 fc rgb "red" fs noborder
set object 12 rect from 0.5,36.2 to 12.5,36.4 fc rgb "blue" fs noborder
set object 13 rect from 629.5,36.2 to 630.5,36.4 fc rgb "blue" fs noborder
set object 14 rect from 12.5,35.4 to 33.5,36.4 fc rgb "white"
set object 15 rect from 608.5,35.4 to 629.5,36.4 fc rgb "grey" fs noborder
set object 16 rect from 12.5,35.4 to 33.5,36.4 fc rgb "white"
set object 17 rect from 608.5,35.4 to 629.5,36.4 fc rgb "grey" fs noborder
set object 18 rect from 629.5,38.4 to 630.5,38.6 fc rgb "red" fs noborder
set object 19 rect from 30.5,39.2 to 614.5,39.4 fc rgb "blue" fs noborder
set object 20 rect from 614.5,38.4 to 629.5,39.4 fc rgb "white"
set object 21 rect from 614.5,38.4 to 629.5,39.4 fc rgb "white"
set object 22 rect from 0.5,38.4 to 30.5,39.4 fc rgb "black" fs noborder
set object 23 rect from 38.5,42.2 to 630.5,42.4 fc rgb "blue" fs noborder
set object 24 rect from 0.5,41.4 to 38.5,42.4 fc rgb "black" fs noborder
set object 25 rect from 0.5,45.2 to 630.5,45.4 fc rgb "blue" fs noborder
set object 26 rect from 629.5,47.4 to 630.5,47.6 fc rgb "red" fs noborder
set object 27 rect from 30.5,48.2 to 608.5,48.4 fc rgb "blue" fs noborder
set object 28 rect from 608.5,47.4 to 629.5,48.4 fc rgb "white"
set object 29 rect from 608.5,47.4 to 629.5,48.4 fc rgb "white"
set object 30 rect from 0.5,47.4 to 30.5,48.4 fc rgb "black" fs noborder
plot '/static/tmp/tmp_PxXSud/rst_R4wyer/seq_0///DG1.txt' axes x1y2 w l t '' lt 3 lw 4
exit
