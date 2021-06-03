set style line 11 lt 1 lw 1 lc rgb "blue"
set encoding iso_8859_1
set yrange [0:50]
set xrange [1:865]
set y2range [-2:37.8]
set autoscale xfix
set ter png enh interlace size 2400,1680 font 'Nimbus,40'
set y2label '{/Symbol D}G (kcal/mol)                                             ' tc lt 3
set ytics scale 1,0.0 nomirror ("PDB-homology" 26.9 0, "SPOCTOPUS" 32.9 0, "SCAMPI" 35.9 0, "PolyPhobius" 38.9 0, "Philius" 41.9 0, "OCTOPUS" 44.9 0, "TOPCONS" 47.9 0)
set y2tics nomirror -4,2,15
set out '/static/tmp/tmp_IxEurd/rst_LcbiDo/seq_0///Topcons/total_image.large.png'
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
set object 6 rect from 130.5,32.4 to 157.5,32.6 fc rgb "red" fs noborder
set object 7 rect from 456.5,32.4 to 475.5,32.6 fc rgb "red" fs noborder
set object 8 rect from 813.5,32.4 to 865.5,32.6 fc rgb "red" fs noborder
set object 9 rect from 21.5,33.2 to 99.5,33.4 fc rgb "blue" fs noborder
set object 10 rect from 178.5,33.2 to 435.5,33.4 fc rgb "blue" fs noborder
set object 11 rect from 506.5,33.2 to 792.5,33.4 fc rgb "blue" fs noborder
set object 12 rect from 99.5,32.4 to 130.5,33.4 fc rgb "white"
set object 13 rect from 157.5,32.4 to 178.5,33.4 fc rgb "grey" fs noborder
set object 14 rect from 435.5,32.4 to 456.5,33.4 fc rgb "white"
set object 15 rect from 475.5,32.4 to 506.5,33.4 fc rgb "grey" fs noborder
set object 16 rect from 792.5,32.4 to 813.5,33.4 fc rgb "white"
set object 17 rect from 99.5,32.4 to 130.5,33.4 fc rgb "white"
set object 18 rect from 157.5,32.4 to 178.5,33.4 fc rgb "grey" fs noborder
set object 19 rect from 435.5,32.4 to 456.5,33.4 fc rgb "white"
set object 20 rect from 475.5,32.4 to 506.5,33.4 fc rgb "grey" fs noborder
set object 21 rect from 792.5,32.4 to 813.5,33.4 fc rgb "white"
set object 22 rect from 0.5,32.4 to 21.5,33.4 fc rgb "black" fs noborder
set object 23 rect from 22.5,35.4 to 94.5,35.6 fc rgb "red" fs noborder
set object 24 rect from 137.5,35.4 to 156.5,35.6 fc rgb "red" fs noborder
set object 25 rect from 460.5,35.4 to 488.5,35.6 fc rgb "red" fs noborder
set object 26 rect from 813.5,35.4 to 865.5,35.6 fc rgb "red" fs noborder
set object 27 rect from 0.5,36.2 to 1.5,36.4 fc rgb "blue" fs noborder
set object 28 rect from 115.5,36.2 to 116.5,36.4 fc rgb "blue" fs noborder
set object 29 rect from 177.5,36.2 to 439.5,36.4 fc rgb "blue" fs noborder
set object 30 rect from 509.5,36.2 to 792.5,36.4 fc rgb "blue" fs noborder
set object 31 rect from 1.5,35.4 to 22.5,36.4 fc rgb "white"
set object 32 rect from 94.5,35.4 to 115.5,36.4 fc rgb "grey" fs noborder
set object 33 rect from 116.5,35.4 to 137.5,36.4 fc rgb "white"
set object 34 rect from 156.5,35.4 to 177.5,36.4 fc rgb "grey" fs noborder
set object 35 rect from 439.5,35.4 to 460.5,36.4 fc rgb "white"
set object 36 rect from 488.5,35.4 to 509.5,36.4 fc rgb "grey" fs noborder
set object 37 rect from 792.5,35.4 to 813.5,36.4 fc rgb "white"
set object 38 rect from 1.5,35.4 to 22.5,36.4 fc rgb "white"
set object 39 rect from 94.5,35.4 to 115.5,36.4 fc rgb "grey" fs noborder
set object 40 rect from 116.5,35.4 to 137.5,36.4 fc rgb "white"
set object 41 rect from 156.5,35.4 to 177.5,36.4 fc rgb "grey" fs noborder
set object 42 rect from 439.5,35.4 to 460.5,36.4 fc rgb "white"
set object 43 rect from 488.5,35.4 to 509.5,36.4 fc rgb "grey" fs noborder
set object 44 rect from 792.5,35.4 to 813.5,36.4 fc rgb "white"
set object 45 rect from 135.5,38.4 to 156.5,38.6 fc rgb "red" fs noborder
set object 46 rect from 460.5,38.4 to 481.5,38.6 fc rgb "red" fs noborder
set object 47 rect from 813.5,38.4 to 865.5,38.6 fc rgb "red" fs noborder
set object 48 rect from 19.5,39.2 to 106.5,39.4 fc rgb "blue" fs noborder
set object 49 rect from 179.5,39.2 to 432.5,39.4 fc rgb "blue" fs noborder
set object 50 rect from 507.5,39.2 to 792.5,39.4 fc rgb "blue" fs noborder
set object 51 rect from 106.5,38.4 to 135.5,39.4 fc rgb "white"
set object 52 rect from 156.5,38.4 to 179.5,39.4 fc rgb "grey" fs noborder
set object 53 rect from 432.5,38.4 to 460.5,39.4 fc rgb "white"
set object 54 rect from 481.5,38.4 to 507.5,39.4 fc rgb "grey" fs noborder
set object 55 rect from 792.5,38.4 to 813.5,39.4 fc rgb "white"
set object 56 rect from 106.5,38.4 to 135.5,39.4 fc rgb "white"
set object 57 rect from 156.5,38.4 to 179.5,39.4 fc rgb "grey" fs noborder
set object 58 rect from 432.5,38.4 to 460.5,39.4 fc rgb "white"
set object 59 rect from 481.5,38.4 to 507.5,39.4 fc rgb "grey" fs noborder
set object 60 rect from 792.5,38.4 to 813.5,39.4 fc rgb "white"
set object 61 rect from 0.5,38.4 to 19.5,39.4 fc rgb "black" fs noborder
set object 62 rect from 132.5,41.4 to 156.5,41.6 fc rgb "red" fs noborder
set object 63 rect from 456.5,41.4 to 477.5,41.6 fc rgb "red" fs noborder
set object 64 rect from 813.5,41.4 to 865.5,41.6 fc rgb "red" fs noborder
set object 65 rect from 19.5,42.2 to 106.5,42.4 fc rgb "blue" fs noborder
set object 66 rect from 179.5,42.2 to 432.5,42.4 fc rgb "blue" fs noborder
set object 67 rect from 505.5,42.2 to 792.5,42.4 fc rgb "blue" fs noborder
set object 68 rect from 106.5,41.4 to 132.5,42.4 fc rgb "white"
set object 69 rect from 156.5,41.4 to 179.5,42.4 fc rgb "grey" fs noborder
set object 70 rect from 432.5,41.4 to 456.5,42.4 fc rgb "white"
set object 71 rect from 477.5,41.4 to 505.5,42.4 fc rgb "grey" fs noborder
set object 72 rect from 792.5,41.4 to 813.5,42.4 fc rgb "white"
set object 73 rect from 106.5,41.4 to 132.5,42.4 fc rgb "white"
set object 74 rect from 156.5,41.4 to 179.5,42.4 fc rgb "grey" fs noborder
set object 75 rect from 432.5,41.4 to 456.5,42.4 fc rgb "white"
set object 76 rect from 477.5,41.4 to 505.5,42.4 fc rgb "grey" fs noborder
set object 77 rect from 792.5,41.4 to 813.5,42.4 fc rgb "white"
set object 78 rect from 0.5,41.4 to 19.5,42.4 fc rgb "black" fs noborder
set object 79 rect from 22.5,44.4 to 99.5,44.6 fc rgb "red" fs noborder
set object 80 rect from 130.5,44.4 to 157.5,44.6 fc rgb "red" fs noborder
set object 81 rect from 456.5,44.4 to 475.5,44.6 fc rgb "red" fs noborder
set object 82 rect from 813.5,44.4 to 865.5,44.6 fc rgb "red" fs noborder
set object 83 rect from 0.5,45.2 to 1.5,45.4 fc rgb "blue" fs noborder
set object 84 rect from 114.5,45.2 to 115.5,45.4 fc rgb "blue" fs noborder
set object 85 rect from 178.5,45.2 to 435.5,45.4 fc rgb "blue" fs noborder
set object 86 rect from 506.5,45.2 to 792.5,45.4 fc rgb "blue" fs noborder
set object 87 rect from 1.5,44.4 to 22.5,45.4 fc rgb "white"
set object 88 rect from 99.5,44.4 to 114.5,45.4 fc rgb "grey" fs noborder
set object 89 rect from 115.5,44.4 to 130.5,45.4 fc rgb "white"
set object 90 rect from 157.5,44.4 to 178.5,45.4 fc rgb "grey" fs noborder
set object 91 rect from 435.5,44.4 to 456.5,45.4 fc rgb "white"
set object 92 rect from 475.5,44.4 to 506.5,45.4 fc rgb "grey" fs noborder
set object 93 rect from 792.5,44.4 to 813.5,45.4 fc rgb "white"
set object 94 rect from 1.5,44.4 to 22.5,45.4 fc rgb "white"
set object 95 rect from 99.5,44.4 to 114.5,45.4 fc rgb "grey" fs noborder
set object 96 rect from 115.5,44.4 to 130.5,45.4 fc rgb "white"
set object 97 rect from 157.5,44.4 to 178.5,45.4 fc rgb "grey" fs noborder
set object 98 rect from 435.5,44.4 to 456.5,45.4 fc rgb "white"
set object 99 rect from 475.5,44.4 to 506.5,45.4 fc rgb "grey" fs noborder
set object 100 rect from 792.5,44.4 to 813.5,45.4 fc rgb "white"
set object 101 rect from 127.5,47.4 to 157.5,47.6 fc rgb "red" fs noborder
set object 102 rect from 456.5,47.4 to 485.5,47.6 fc rgb "red" fs noborder
set object 103 rect from 813.5,47.4 to 865.5,47.6 fc rgb "red" fs noborder
set object 104 rect from 21.5,48.2 to 106.5,48.4 fc rgb "blue" fs noborder
set object 105 rect from 178.5,48.2 to 435.5,48.4 fc rgb "blue" fs noborder
set object 106 rect from 506.5,48.2 to 792.5,48.4 fc rgb "blue" fs noborder
set object 107 rect from 106.5,47.4 to 127.5,48.4 fc rgb "white"
set object 108 rect from 157.5,47.4 to 178.5,48.4 fc rgb "grey" fs noborder
set object 109 rect from 435.5,47.4 to 456.5,48.4 fc rgb "white"
set object 110 rect from 485.5,47.4 to 506.5,48.4 fc rgb "grey" fs noborder
set object 111 rect from 792.5,47.4 to 813.5,48.4 fc rgb "white"
set object 112 rect from 106.5,47.4 to 127.5,48.4 fc rgb "white"
set object 113 rect from 157.5,47.4 to 178.5,48.4 fc rgb "grey" fs noborder
set object 114 rect from 435.5,47.4 to 456.5,48.4 fc rgb "white"
set object 115 rect from 485.5,47.4 to 506.5,48.4 fc rgb "grey" fs noborder
set object 116 rect from 792.5,47.4 to 813.5,48.4 fc rgb "white"
set object 117 rect from 0.5,47.4 to 21.5,48.4 fc rgb "black" fs noborder
plot '/static/tmp/tmp_IxEurd/rst_LcbiDo/seq_0///DG1.txt' axes x1y2 w l t '' lt 3 lw 4
exit
