set style line 11 lt 1 lw 1 lc rgb "blue"
set encoding iso_8859_1
set yrange [0:50]
set xrange [1:345]
set y2range [-2:41.2]
set autoscale xfix
set ter png enh interlace size 2400,1680 font 'Nimbus,40'
set y2label '{/Symbol D}G (kcal/mol)                                             ' tc lt 3
set ytics scale 1,0.0 nomirror ("PDB-homology" 26.9 0, "SPOCTOPUS" 32.9 0, "SCAMPI" 35.9 0, "PolyPhobius" 38.9 0, "Philius" 41.9 0, "OCTOPUS" 44.9 0, "TOPCONS" 47.9 0)
set y2tics nomirror -5,2,16
set out '/static/tmp/tmp_ZnE0xm/rst_4wTEwB/seq_0///Topcons/total_image.large.png'
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
set object 6 rect from 44.5,32.4 to 60.5,32.6 fc rgb "red" fs noborder
set object 7 rect from 113.5,32.4 to 125.5,32.6 fc rgb "red" fs noborder
set object 8 rect from 191.5,32.4 to 203.5,32.6 fc rgb "red" fs noborder
set object 9 rect from 263.5,32.4 to 345.5,32.6 fc rgb "red" fs noborder
set object 10 rect from 0.5,33.2 to 23.5,33.4 fc rgb "blue" fs noborder
set object 11 rect from 81.5,33.2 to 92.5,33.4 fc rgb "blue" fs noborder
set object 12 rect from 146.5,33.2 to 170.5,33.4 fc rgb "blue" fs noborder
set object 13 rect from 224.5,33.2 to 242.5,33.4 fc rgb "blue" fs noborder
set object 14 rect from 23.5,32.4 to 44.5,33.4 fc rgb "white"
set object 15 rect from 60.5,32.4 to 81.5,33.4 fc rgb "grey" fs noborder
set object 16 rect from 92.5,32.4 to 113.5,33.4 fc rgb "white"
set object 17 rect from 125.5,32.4 to 146.5,33.4 fc rgb "grey" fs noborder
set object 18 rect from 170.5,32.4 to 191.5,33.4 fc rgb "white"
set object 19 rect from 203.5,32.4 to 224.5,33.4 fc rgb "grey" fs noborder
set object 20 rect from 242.5,32.4 to 263.5,33.4 fc rgb "white"
set object 21 rect from 23.5,32.4 to 44.5,33.4 fc rgb "white"
set object 22 rect from 60.5,32.4 to 81.5,33.4 fc rgb "grey" fs noborder
set object 23 rect from 92.5,32.4 to 113.5,33.4 fc rgb "white"
set object 24 rect from 125.5,32.4 to 146.5,33.4 fc rgb "grey" fs noborder
set object 25 rect from 170.5,32.4 to 191.5,33.4 fc rgb "white"
set object 26 rect from 203.5,32.4 to 224.5,33.4 fc rgb "grey" fs noborder
set object 27 rect from 242.5,32.4 to 263.5,33.4 fc rgb "white"
set object 28 rect from 46.5,35.4 to 61.5,35.6 fc rgb "red" fs noborder
set object 29 rect from 112.5,35.4 to 128.5,35.6 fc rgb "red" fs noborder
set object 30 rect from 188.5,35.4 to 205.5,35.6 fc rgb "red" fs noborder
set object 31 rect from 259.5,35.4 to 345.5,35.6 fc rgb "red" fs noborder
set object 32 rect from 0.5,36.2 to 25.5,36.4 fc rgb "blue" fs noborder
set object 33 rect from 82.5,36.2 to 91.5,36.4 fc rgb "blue" fs noborder
set object 34 rect from 149.5,36.2 to 167.5,36.4 fc rgb "blue" fs noborder
set object 35 rect from 226.5,36.2 to 238.5,36.4 fc rgb "blue" fs noborder
set object 36 rect from 25.5,35.4 to 46.5,36.4 fc rgb "white"
set object 37 rect from 61.5,35.4 to 82.5,36.4 fc rgb "grey" fs noborder
set object 38 rect from 91.5,35.4 to 112.5,36.4 fc rgb "white"
set object 39 rect from 128.5,35.4 to 149.5,36.4 fc rgb "grey" fs noborder
set object 40 rect from 167.5,35.4 to 188.5,36.4 fc rgb "white"
set object 41 rect from 205.5,35.4 to 226.5,36.4 fc rgb "grey" fs noborder
set object 42 rect from 238.5,35.4 to 259.5,36.4 fc rgb "white"
set object 43 rect from 25.5,35.4 to 46.5,36.4 fc rgb "white"
set object 44 rect from 61.5,35.4 to 82.5,36.4 fc rgb "grey" fs noborder
set object 45 rect from 91.5,35.4 to 112.5,36.4 fc rgb "white"
set object 46 rect from 128.5,35.4 to 149.5,36.4 fc rgb "grey" fs noborder
set object 47 rect from 167.5,35.4 to 188.5,36.4 fc rgb "white"
set object 48 rect from 205.5,35.4 to 226.5,36.4 fc rgb "grey" fs noborder
set object 49 rect from 238.5,35.4 to 259.5,36.4 fc rgb "white"
set object 50 rect from 48.5,38.4 to 59.5,38.6 fc rgb "red" fs noborder
set object 51 rect from 114.5,38.4 to 125.5,38.6 fc rgb "red" fs noborder
set object 52 rect from 192.5,38.4 to 203.5,38.6 fc rgb "red" fs noborder
set object 53 rect from 260.5,38.4 to 345.5,38.6 fc rgb "red" fs noborder
set object 54 rect from 0.5,39.2 to 21.5,39.4 fc rgb "blue" fs noborder
set object 55 rect from 82.5,39.2 to 93.5,39.4 fc rgb "blue" fs noborder
set object 56 rect from 150.5,39.2 to 169.5,39.4 fc rgb "blue" fs noborder
set object 57 rect from 225.5,39.2 to 240.5,39.4 fc rgb "blue" fs noborder
set object 58 rect from 21.5,38.4 to 48.5,39.4 fc rgb "white"
set object 59 rect from 59.5,38.4 to 82.5,39.4 fc rgb "grey" fs noborder
set object 60 rect from 93.5,38.4 to 114.5,39.4 fc rgb "white"
set object 61 rect from 125.5,38.4 to 150.5,39.4 fc rgb "grey" fs noborder
set object 62 rect from 169.5,38.4 to 192.5,39.4 fc rgb "white"
set object 63 rect from 203.5,38.4 to 225.5,39.4 fc rgb "grey" fs noborder
set object 64 rect from 240.5,38.4 to 260.5,39.4 fc rgb "white"
set object 65 rect from 21.5,38.4 to 48.5,39.4 fc rgb "white"
set object 66 rect from 59.5,38.4 to 82.5,39.4 fc rgb "grey" fs noborder
set object 67 rect from 93.5,38.4 to 114.5,39.4 fc rgb "white"
set object 68 rect from 125.5,38.4 to 150.5,39.4 fc rgb "grey" fs noborder
set object 69 rect from 169.5,38.4 to 192.5,39.4 fc rgb "white"
set object 70 rect from 203.5,38.4 to 225.5,39.4 fc rgb "grey" fs noborder
set object 71 rect from 240.5,38.4 to 260.5,39.4 fc rgb "white"
set object 72 rect from 48.5,41.4 to 59.5,41.6 fc rgb "red" fs noborder
set object 73 rect from 112.5,41.4 to 123.5,41.6 fc rgb "red" fs noborder
set object 74 rect from 188.5,41.4 to 204.5,41.6 fc rgb "red" fs noborder
set object 75 rect from 260.5,41.4 to 345.5,41.6 fc rgb "red" fs noborder
set object 76 rect from 0.5,42.2 to 23.5,42.4 fc rgb "blue" fs noborder
set object 77 rect from 82.5,42.2 to 90.5,42.4 fc rgb "blue" fs noborder
set object 78 rect from 144.5,42.2 to 165.5,42.4 fc rgb "blue" fs noborder
set object 79 rect from 224.5,42.2 to 240.5,42.4 fc rgb "blue" fs noborder
set object 80 rect from 23.5,41.4 to 48.5,42.4 fc rgb "white"
set object 81 rect from 59.5,41.4 to 82.5,42.4 fc rgb "grey" fs noborder
set object 82 rect from 90.5,41.4 to 112.5,42.4 fc rgb "white"
set object 83 rect from 123.5,41.4 to 144.5,42.4 fc rgb "grey" fs noborder
set object 84 rect from 165.5,41.4 to 188.5,42.4 fc rgb "white"
set object 85 rect from 204.5,41.4 to 224.5,42.4 fc rgb "grey" fs noborder
set object 86 rect from 240.5,41.4 to 260.5,42.4 fc rgb "white"
set object 87 rect from 23.5,41.4 to 48.5,42.4 fc rgb "white"
set object 88 rect from 59.5,41.4 to 82.5,42.4 fc rgb "grey" fs noborder
set object 89 rect from 90.5,41.4 to 112.5,42.4 fc rgb "white"
set object 90 rect from 123.5,41.4 to 144.5,42.4 fc rgb "grey" fs noborder
set object 91 rect from 165.5,41.4 to 188.5,42.4 fc rgb "white"
set object 92 rect from 204.5,41.4 to 224.5,42.4 fc rgb "grey" fs noborder
set object 93 rect from 240.5,41.4 to 260.5,42.4 fc rgb "white"
set object 94 rect from 44.5,44.4 to 60.5,44.6 fc rgb "red" fs noborder
set object 95 rect from 113.5,44.4 to 125.5,44.6 fc rgb "red" fs noborder
set object 96 rect from 190.5,44.4 to 203.5,44.6 fc rgb "red" fs noborder
set object 97 rect from 263.5,44.4 to 345.5,44.6 fc rgb "red" fs noborder
set object 98 rect from 0.5,45.2 to 23.5,45.4 fc rgb "blue" fs noborder
set object 99 rect from 81.5,45.2 to 92.5,45.4 fc rgb "blue" fs noborder
set object 100 rect from 146.5,45.2 to 169.5,45.4 fc rgb "blue" fs noborder
set object 101 rect from 224.5,45.2 to 242.5,45.4 fc rgb "blue" fs noborder
set object 102 rect from 23.5,44.4 to 44.5,45.4 fc rgb "white"
set object 103 rect from 60.5,44.4 to 81.5,45.4 fc rgb "grey" fs noborder
set object 104 rect from 92.5,44.4 to 113.5,45.4 fc rgb "white"
set object 105 rect from 125.5,44.4 to 146.5,45.4 fc rgb "grey" fs noborder
set object 106 rect from 169.5,44.4 to 190.5,45.4 fc rgb "white"
set object 107 rect from 203.5,44.4 to 224.5,45.4 fc rgb "grey" fs noborder
set object 108 rect from 242.5,44.4 to 263.5,45.4 fc rgb "white"
set object 109 rect from 23.5,44.4 to 44.5,45.4 fc rgb "white"
set object 110 rect from 60.5,44.4 to 81.5,45.4 fc rgb "grey" fs noborder
set object 111 rect from 92.5,44.4 to 113.5,45.4 fc rgb "white"
set object 112 rect from 125.5,44.4 to 146.5,45.4 fc rgb "grey" fs noborder
set object 113 rect from 169.5,44.4 to 190.5,45.4 fc rgb "white"
set object 114 rect from 203.5,44.4 to 224.5,45.4 fc rgb "grey" fs noborder
set object 115 rect from 242.5,44.4 to 263.5,45.4 fc rgb "white"
set object 116 rect from 44.5,47.4 to 60.5,47.6 fc rgb "red" fs noborder
set object 117 rect from 113.5,47.4 to 125.5,47.6 fc rgb "red" fs noborder
set object 118 rect from 190.5,47.4 to 203.5,47.6 fc rgb "red" fs noborder
set object 119 rect from 261.5,47.4 to 345.5,47.6 fc rgb "red" fs noborder
set object 120 rect from 0.5,48.2 to 23.5,48.4 fc rgb "blue" fs noborder
set object 121 rect from 81.5,48.2 to 92.5,48.4 fc rgb "blue" fs noborder
set object 122 rect from 146.5,48.2 to 169.5,48.4 fc rgb "blue" fs noborder
set object 123 rect from 224.5,48.2 to 240.5,48.4 fc rgb "blue" fs noborder
set object 124 rect from 23.5,47.4 to 44.5,48.4 fc rgb "white"
set object 125 rect from 60.5,47.4 to 81.5,48.4 fc rgb "grey" fs noborder
set object 126 rect from 92.5,47.4 to 113.5,48.4 fc rgb "white"
set object 127 rect from 125.5,47.4 to 146.5,48.4 fc rgb "grey" fs noborder
set object 128 rect from 169.5,47.4 to 190.5,48.4 fc rgb "white"
set object 129 rect from 203.5,47.4 to 224.5,48.4 fc rgb "grey" fs noborder
set object 130 rect from 240.5,47.4 to 261.5,48.4 fc rgb "white"
set object 131 rect from 23.5,47.4 to 44.5,48.4 fc rgb "white"
set object 132 rect from 60.5,47.4 to 81.5,48.4 fc rgb "grey" fs noborder
set object 133 rect from 92.5,47.4 to 113.5,48.4 fc rgb "white"
set object 134 rect from 125.5,47.4 to 146.5,48.4 fc rgb "grey" fs noborder
set object 135 rect from 169.5,47.4 to 190.5,48.4 fc rgb "white"
set object 136 rect from 203.5,47.4 to 224.5,48.4 fc rgb "grey" fs noborder
set object 137 rect from 240.5,47.4 to 261.5,48.4 fc rgb "white"
plot '/static/tmp/tmp_ZnE0xm/rst_4wTEwB/seq_0///DG1.txt' axes x1y2 w l t '' lt 3 lw 4
exit
