set style line 11 lt 1 lw 1 lc rgb "blue"
set encoding iso_8859_1
set yrange [0:50]
set xrange [1:856]
set y2range [-2:37.8]
set autoscale xfix
set ter png enh interlace size 2400,1680 font 'Nimbus,40'
set y2label '{/Symbol D}G (kcal/mol)                                             ' tc lt 3
set ytics scale 1,0.0 nomirror ("PDB-homology" 26.9 0, "SPOCTOPUS" 32.9 0, "SCAMPI" 35.9 0, "PolyPhobius" 38.9 0, "Philius" 41.9 0, "OCTOPUS" 44.9 0, "TOPCONS" 47.9 0)
set y2tics nomirror -4,2,15
set out '/big/server/web_common_backend/proj/pred/static/tmp/tmp__R3H40/rst_UItgsq//seq_0///Topcons/total_image.large.png'
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
set object 6 rect from 71.5,32.4 to 91.5,32.6 fc rgb "red" fs noborder
set object 7 rect from 122.5,32.4 to 148.5,32.6 fc rgb "red" fs noborder
set object 8 rect from 447.5,32.4 to 467.5,32.6 fc rgb "red" fs noborder
set object 9 rect from 498.5,32.4 to 772.5,32.6 fc rgb "red" fs noborder
set object 10 rect from 803.5,32.4 to 856.5,32.6 fc rgb "red" fs noborder
set object 11 rect from 19.5,33.2 to 50.5,33.4 fc rgb "blue" fs noborder
set object 12 rect from 106.5,33.2 to 107.5,33.4 fc rgb "blue" fs noborder
set object 13 rect from 169.5,33.2 to 426.5,33.4 fc rgb "blue" fs noborder
set object 14 rect from 482.5,33.2 to 483.5,33.4 fc rgb "blue" fs noborder
set object 15 rect from 787.5,33.2 to 788.5,33.4 fc rgb "blue" fs noborder
set object 16 rect from 50.5,32.4 to 71.5,33.4 fc rgb "white"
set object 17 rect from 91.5,32.4 to 106.5,33.4 fc rgb "grey" fs noborder
set object 18 rect from 107.5,32.4 to 122.5,33.4 fc rgb "white"
set object 19 rect from 148.5,32.4 to 169.5,33.4 fc rgb "grey" fs noborder
set object 20 rect from 426.5,32.4 to 447.5,33.4 fc rgb "white"
set object 21 rect from 467.5,32.4 to 482.5,33.4 fc rgb "grey" fs noborder
set object 22 rect from 483.5,32.4 to 498.5,33.4 fc rgb "white"
set object 23 rect from 772.5,32.4 to 787.5,33.4 fc rgb "grey" fs noborder
set object 24 rect from 788.5,32.4 to 803.5,33.4 fc rgb "white"
set object 25 rect from 50.5,32.4 to 71.5,33.4 fc rgb "white"
set object 26 rect from 91.5,32.4 to 106.5,33.4 fc rgb "grey" fs noborder
set object 27 rect from 107.5,32.4 to 122.5,33.4 fc rgb "white"
set object 28 rect from 148.5,32.4 to 169.5,33.4 fc rgb "grey" fs noborder
set object 29 rect from 426.5,32.4 to 447.5,33.4 fc rgb "white"
set object 30 rect from 467.5,32.4 to 482.5,33.4 fc rgb "grey" fs noborder
set object 31 rect from 483.5,32.4 to 498.5,33.4 fc rgb "white"
set object 32 rect from 772.5,32.4 to 787.5,33.4 fc rgb "grey" fs noborder
set object 33 rect from 788.5,32.4 to 803.5,33.4 fc rgb "white"
set object 34 rect from 0.5,32.4 to 19.5,33.4 fc rgb "black" fs noborder
set object 35 rect from 0.5,35.4 to 1.5,35.6 fc rgb "red" fs noborder
set object 36 rect from 121.5,35.4 to 147.5,35.6 fc rgb "red" fs noborder
set object 37 rect from 451.5,35.4 to 479.5,35.6 fc rgb "red" fs noborder
set object 38 rect from 804.5,35.4 to 856.5,35.6 fc rgb "red" fs noborder
set object 39 rect from 22.5,36.2 to 100.5,36.4 fc rgb "blue" fs noborder
set object 40 rect from 168.5,36.2 to 430.5,36.4 fc rgb "blue" fs noborder
set object 41 rect from 500.5,36.2 to 783.5,36.4 fc rgb "blue" fs noborder
set object 42 rect from 1.5,35.4 to 22.5,36.4 fc rgb "grey" fs noborder
set object 43 rect from 100.5,35.4 to 121.5,36.4 fc rgb "white"
set object 44 rect from 147.5,35.4 to 168.5,36.4 fc rgb "grey" fs noborder
set object 45 rect from 430.5,35.4 to 451.5,36.4 fc rgb "white"
set object 46 rect from 479.5,35.4 to 500.5,36.4 fc rgb "grey" fs noborder
set object 47 rect from 783.5,35.4 to 804.5,36.4 fc rgb "white"
set object 48 rect from 1.5,35.4 to 22.5,36.4 fc rgb "grey" fs noborder
set object 49 rect from 100.5,35.4 to 121.5,36.4 fc rgb "white"
set object 50 rect from 147.5,35.4 to 168.5,36.4 fc rgb "grey" fs noborder
set object 51 rect from 430.5,35.4 to 451.5,36.4 fc rgb "white"
set object 52 rect from 479.5,35.4 to 500.5,36.4 fc rgb "grey" fs noborder
set object 53 rect from 783.5,35.4 to 804.5,36.4 fc rgb "white"
set object 54 rect from 126.5,38.4 to 147.5,38.6 fc rgb "red" fs noborder
set object 55 rect from 451.5,38.4 to 471.5,38.6 fc rgb "red" fs noborder
set object 56 rect from 804.5,38.4 to 856.5,38.6 fc rgb "red" fs noborder
set object 57 rect from 17.5,39.2 to 97.5,39.4 fc rgb "blue" fs noborder
set object 58 rect from 170.5,39.2 to 423.5,39.4 fc rgb "blue" fs noborder
set object 59 rect from 498.5,39.2 to 783.5,39.4 fc rgb "blue" fs noborder
set object 60 rect from 97.5,38.4 to 126.5,39.4 fc rgb "white"
set object 61 rect from 147.5,38.4 to 170.5,39.4 fc rgb "grey" fs noborder
set object 62 rect from 423.5,38.4 to 451.5,39.4 fc rgb "white"
set object 63 rect from 471.5,38.4 to 498.5,39.4 fc rgb "grey" fs noborder
set object 64 rect from 783.5,38.4 to 804.5,39.4 fc rgb "white"
set object 65 rect from 97.5,38.4 to 126.5,39.4 fc rgb "white"
set object 66 rect from 147.5,38.4 to 170.5,39.4 fc rgb "grey" fs noborder
set object 67 rect from 423.5,38.4 to 451.5,39.4 fc rgb "white"
set object 68 rect from 471.5,38.4 to 498.5,39.4 fc rgb "grey" fs noborder
set object 69 rect from 783.5,38.4 to 804.5,39.4 fc rgb "white"
set object 70 rect from 0.5,38.4 to 17.5,39.4 fc rgb "black" fs noborder
set object 71 rect from 123.5,41.4 to 147.5,41.6 fc rgb "red" fs noborder
set object 72 rect from 447.5,41.4 to 468.5,41.6 fc rgb "red" fs noborder
set object 73 rect from 804.5,41.4 to 856.5,41.6 fc rgb "red" fs noborder
set object 74 rect from 19.5,42.2 to 97.5,42.4 fc rgb "blue" fs noborder
set object 75 rect from 170.5,42.2 to 423.5,42.4 fc rgb "blue" fs noborder
set object 76 rect from 496.5,42.2 to 783.5,42.4 fc rgb "blue" fs noborder
set object 77 rect from 97.5,41.4 to 123.5,42.4 fc rgb "white"
set object 78 rect from 147.5,41.4 to 170.5,42.4 fc rgb "grey" fs noborder
set object 79 rect from 423.5,41.4 to 447.5,42.4 fc rgb "white"
set object 80 rect from 468.5,41.4 to 496.5,42.4 fc rgb "grey" fs noborder
set object 81 rect from 783.5,41.4 to 804.5,42.4 fc rgb "white"
set object 82 rect from 97.5,41.4 to 123.5,42.4 fc rgb "white"
set object 83 rect from 147.5,41.4 to 170.5,42.4 fc rgb "grey" fs noborder
set object 84 rect from 423.5,41.4 to 447.5,42.4 fc rgb "white"
set object 85 rect from 468.5,41.4 to 496.5,42.4 fc rgb "grey" fs noborder
set object 86 rect from 783.5,41.4 to 804.5,42.4 fc rgb "white"
set object 87 rect from 0.5,41.4 to 19.5,42.4 fc rgb "black" fs noborder
set object 88 rect from 0.5,44.4 to 1.5,44.6 fc rgb "red" fs noborder
set object 89 rect from 71.5,44.4 to 91.5,44.6 fc rgb "red" fs noborder
set object 90 rect from 122.5,44.4 to 148.5,44.6 fc rgb "red" fs noborder
set object 91 rect from 447.5,44.4 to 467.5,44.6 fc rgb "red" fs noborder
set object 92 rect from 498.5,44.4 to 772.5,44.6 fc rgb "red" fs noborder
set object 93 rect from 803.5,44.4 to 856.5,44.6 fc rgb "red" fs noborder
set object 94 rect from 22.5,45.2 to 50.5,45.4 fc rgb "blue" fs noborder
set object 95 rect from 106.5,45.2 to 107.5,45.4 fc rgb "blue" fs noborder
set object 96 rect from 169.5,45.2 to 426.5,45.4 fc rgb "blue" fs noborder
set object 97 rect from 482.5,45.2 to 483.5,45.4 fc rgb "blue" fs noborder
set object 98 rect from 787.5,45.2 to 788.5,45.4 fc rgb "blue" fs noborder
set object 99 rect from 1.5,44.4 to 22.5,45.4 fc rgb "grey" fs noborder
set object 100 rect from 50.5,44.4 to 71.5,45.4 fc rgb "white"
set object 101 rect from 91.5,44.4 to 106.5,45.4 fc rgb "grey" fs noborder
set object 102 rect from 107.5,44.4 to 122.5,45.4 fc rgb "white"
set object 103 rect from 148.5,44.4 to 169.5,45.4 fc rgb "grey" fs noborder
set object 104 rect from 426.5,44.4 to 447.5,45.4 fc rgb "white"
set object 105 rect from 467.5,44.4 to 482.5,45.4 fc rgb "grey" fs noborder
set object 106 rect from 483.5,44.4 to 498.5,45.4 fc rgb "white"
set object 107 rect from 772.5,44.4 to 787.5,45.4 fc rgb "grey" fs noborder
set object 108 rect from 788.5,44.4 to 803.5,45.4 fc rgb "white"
set object 109 rect from 1.5,44.4 to 22.5,45.4 fc rgb "grey" fs noborder
set object 110 rect from 50.5,44.4 to 71.5,45.4 fc rgb "white"
set object 111 rect from 91.5,44.4 to 106.5,45.4 fc rgb "grey" fs noborder
set object 112 rect from 107.5,44.4 to 122.5,45.4 fc rgb "white"
set object 113 rect from 148.5,44.4 to 169.5,45.4 fc rgb "grey" fs noborder
set object 114 rect from 426.5,44.4 to 447.5,45.4 fc rgb "white"
set object 115 rect from 467.5,44.4 to 482.5,45.4 fc rgb "grey" fs noborder
set object 116 rect from 483.5,44.4 to 498.5,45.4 fc rgb "white"
set object 117 rect from 772.5,44.4 to 787.5,45.4 fc rgb "grey" fs noborder
set object 118 rect from 788.5,44.4 to 803.5,45.4 fc rgb "white"
set object 119 rect from 121.5,47.4 to 148.5,47.6 fc rgb "red" fs noborder
set object 120 rect from 447.5,47.4 to 477.5,47.6 fc rgb "red" fs noborder
set object 121 rect from 804.5,47.4 to 856.5,47.6 fc rgb "red" fs noborder
set object 122 rect from 21.5,48.2 to 100.5,48.4 fc rgb "blue" fs noborder
set object 123 rect from 169.5,48.2 to 426.5,48.4 fc rgb "blue" fs noborder
set object 124 rect from 498.5,48.2 to 783.5,48.4 fc rgb "blue" fs noborder
set object 125 rect from 100.5,47.4 to 121.5,48.4 fc rgb "white"
set object 126 rect from 148.5,47.4 to 169.5,48.4 fc rgb "grey" fs noborder
set object 127 rect from 426.5,47.4 to 447.5,48.4 fc rgb "white"
set object 128 rect from 477.5,47.4 to 498.5,48.4 fc rgb "grey" fs noborder
set object 129 rect from 783.5,47.4 to 804.5,48.4 fc rgb "white"
set object 130 rect from 100.5,47.4 to 121.5,48.4 fc rgb "white"
set object 131 rect from 148.5,47.4 to 169.5,48.4 fc rgb "grey" fs noborder
set object 132 rect from 426.5,47.4 to 447.5,48.4 fc rgb "white"
set object 133 rect from 477.5,47.4 to 498.5,48.4 fc rgb "grey" fs noborder
set object 134 rect from 783.5,47.4 to 804.5,48.4 fc rgb "white"
set object 135 rect from 0.5,47.4 to 21.5,48.4 fc rgb "black" fs noborder
plot '/big/server/web_common_backend/proj/pred/static/tmp/tmp__R3H40/rst_UItgsq//seq_0///DG1.txt' axes x1y2 w l t '' lt 3 lw 4
exit
