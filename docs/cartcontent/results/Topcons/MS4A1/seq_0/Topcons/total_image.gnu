set style line 11 lt 1 lw 1 lc rgb "blue"
set encoding iso_8859_1
set yrange [0:50]
set xrange [1:297]
set y2range [-2:42]
set autoscale xfix
set ter png enh interlace size 2400,1680 font 'Nimbus,40'
set y2label '{/Symbol D}G (kcal/mol)                                             ' tc lt 3
set ytics scale 1,0.0 nomirror ("PDB-homology" 26.9 0, "SPOCTOPUS" 32.9 0, "SCAMPI" 35.9 0, "PolyPhobius" 38.9 0, "Philius" 41.9 0, "OCTOPUS" 44.9 0, "TOPCONS" 47.9 0)
set y2tics nomirror -2,2,18
set out '/static/tmp/tmp_WuWK4o/rst_ywt85g/seq_0///Topcons/total_image.large.png'
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
set object 6 rect from 0.5,32.4 to 52.5,32.6 fc rgb "red" fs noborder
set object 7 rect from 103.5,32.4 to 117.5,32.6 fc rgb "red" fs noborder
set object 8 rect from 208.5,32.4 to 297.5,32.6 fc rgb "red" fs noborder
set object 9 rect from 73.5,33.2 to 82.5,33.4 fc rgb "blue" fs noborder
set object 10 rect from 138.5,33.2 to 187.5,33.4 fc rgb "blue" fs noborder
set object 11 rect from 52.5,32.4 to 73.5,33.4 fc rgb "grey" fs noborder
set object 12 rect from 82.5,32.4 to 103.5,33.4 fc rgb "white"
set object 13 rect from 117.5,32.4 to 138.5,33.4 fc rgb "grey" fs noborder
set object 14 rect from 187.5,32.4 to 208.5,33.4 fc rgb "white"
set object 15 rect from 52.5,32.4 to 73.5,33.4 fc rgb "grey" fs noborder
set object 16 rect from 82.5,32.4 to 103.5,33.4 fc rgb "white"
set object 17 rect from 117.5,32.4 to 138.5,33.4 fc rgb "grey" fs noborder
set object 18 rect from 187.5,32.4 to 208.5,33.4 fc rgb "white"
set object 19 rect from 0.5,35.4 to 50.5,35.6 fc rgb "red" fs noborder
set object 20 rect from 104.5,35.4 to 120.5,35.6 fc rgb "red" fs noborder
set object 21 rect from 206.5,35.4 to 297.5,35.6 fc rgb "red" fs noborder
set object 22 rect from 71.5,36.2 to 83.5,36.4 fc rgb "blue" fs noborder
set object 23 rect from 141.5,36.2 to 185.5,36.4 fc rgb "blue" fs noborder
set object 24 rect from 50.5,35.4 to 71.5,36.4 fc rgb "grey" fs noborder
set object 25 rect from 83.5,35.4 to 104.5,36.4 fc rgb "white"
set object 26 rect from 120.5,35.4 to 141.5,36.4 fc rgb "grey" fs noborder
set object 27 rect from 185.5,35.4 to 206.5,36.4 fc rgb "white"
set object 28 rect from 50.5,35.4 to 71.5,36.4 fc rgb "grey" fs noborder
set object 29 rect from 83.5,35.4 to 104.5,36.4 fc rgb "white"
set object 30 rect from 120.5,35.4 to 141.5,36.4 fc rgb "grey" fs noborder
set object 31 rect from 185.5,35.4 to 206.5,36.4 fc rgb "white"
set object 32 rect from 0.5,38.4 to 51.5,38.6 fc rgb "red" fs noborder
set object 33 rect from 104.5,38.4 to 117.5,38.6 fc rgb "red" fs noborder
set object 34 rect from 212.5,38.4 to 297.5,38.6 fc rgb "red" fs noborder
set object 35 rect from 77.5,39.2 to 83.5,39.4 fc rgb "blue" fs noborder
set object 36 rect from 143.5,39.2 to 187.5,39.4 fc rgb "blue" fs noborder
set object 37 rect from 51.5,38.4 to 77.5,39.4 fc rgb "grey" fs noborder
set object 38 rect from 83.5,38.4 to 104.5,39.4 fc rgb "white"
set object 39 rect from 117.5,38.4 to 143.5,39.4 fc rgb "grey" fs noborder
set object 40 rect from 187.5,38.4 to 212.5,39.4 fc rgb "white"
set object 41 rect from 51.5,38.4 to 77.5,39.4 fc rgb "grey" fs noborder
set object 42 rect from 83.5,38.4 to 104.5,39.4 fc rgb "white"
set object 43 rect from 117.5,38.4 to 143.5,39.4 fc rgb "grey" fs noborder
set object 44 rect from 187.5,38.4 to 212.5,39.4 fc rgb "white"
set object 45 rect from 0.5,41.4 to 54.5,41.6 fc rgb "red" fs noborder
set object 46 rect from 104.5,41.4 to 117.5,41.6 fc rgb "red" fs noborder
set object 47 rect from 208.5,41.4 to 297.5,41.6 fc rgb "red" fs noborder
set object 48 rect from 77.5,42.2 to 84.5,42.4 fc rgb "blue" fs noborder
set object 49 rect from 139.5,42.2 to 188.5,42.4 fc rgb "blue" fs noborder
set object 50 rect from 54.5,41.4 to 77.5,42.4 fc rgb "grey" fs noborder
set object 51 rect from 84.5,41.4 to 104.5,42.4 fc rgb "white"
set object 52 rect from 117.5,41.4 to 139.5,42.4 fc rgb "grey" fs noborder
set object 53 rect from 188.5,41.4 to 208.5,42.4 fc rgb "white"
set object 54 rect from 54.5,41.4 to 77.5,42.4 fc rgb "grey" fs noborder
set object 55 rect from 84.5,41.4 to 104.5,42.4 fc rgb "white"
set object 56 rect from 117.5,41.4 to 139.5,42.4 fc rgb "grey" fs noborder
set object 57 rect from 188.5,41.4 to 208.5,42.4 fc rgb "white"
set object 58 rect from 0.5,44.4 to 52.5,44.6 fc rgb "red" fs noborder
set object 59 rect from 103.5,44.4 to 117.5,44.6 fc rgb "red" fs noborder
set object 60 rect from 208.5,44.4 to 297.5,44.6 fc rgb "red" fs noborder
set object 61 rect from 73.5,45.2 to 82.5,45.4 fc rgb "blue" fs noborder
set object 62 rect from 138.5,45.2 to 187.5,45.4 fc rgb "blue" fs noborder
set object 63 rect from 52.5,44.4 to 73.5,45.4 fc rgb "grey" fs noborder
set object 64 rect from 82.5,44.4 to 103.5,45.4 fc rgb "white"
set object 65 rect from 117.5,44.4 to 138.5,45.4 fc rgb "grey" fs noborder
set object 66 rect from 187.5,44.4 to 208.5,45.4 fc rgb "white"
set object 67 rect from 52.5,44.4 to 73.5,45.4 fc rgb "grey" fs noborder
set object 68 rect from 82.5,44.4 to 103.5,45.4 fc rgb "white"
set object 69 rect from 117.5,44.4 to 138.5,45.4 fc rgb "grey" fs noborder
set object 70 rect from 187.5,44.4 to 208.5,45.4 fc rgb "white"
set object 71 rect from 0.5,47.4 to 52.5,47.6 fc rgb "red" fs noborder
set object 72 rect from 104.5,47.4 to 117.5,47.6 fc rgb "red" fs noborder
set object 73 rect from 208.5,47.4 to 297.5,47.6 fc rgb "red" fs noborder
set object 74 rect from 73.5,48.2 to 83.5,48.4 fc rgb "blue" fs noborder
set object 75 rect from 138.5,48.2 to 187.5,48.4 fc rgb "blue" fs noborder
set object 76 rect from 52.5,47.4 to 73.5,48.4 fc rgb "grey" fs noborder
set object 77 rect from 83.5,47.4 to 104.5,48.4 fc rgb "white"
set object 78 rect from 117.5,47.4 to 138.5,48.4 fc rgb "grey" fs noborder
set object 79 rect from 187.5,47.4 to 208.5,48.4 fc rgb "white"
set object 80 rect from 52.5,47.4 to 73.5,48.4 fc rgb "grey" fs noborder
set object 81 rect from 83.5,47.4 to 104.5,48.4 fc rgb "white"
set object 82 rect from 117.5,47.4 to 138.5,48.4 fc rgb "grey" fs noborder
set object 83 rect from 187.5,47.4 to 208.5,48.4 fc rgb "white"
plot '/static/tmp/tmp_WuWK4o/rst_ywt85g/seq_0///DG1.txt' axes x1y2 w l t '' lt 3 lw 4
exit
