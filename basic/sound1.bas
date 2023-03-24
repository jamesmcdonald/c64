1 rem from c64 page 193
5 s=54272
10 forl=stos+24:pokel,0:next:rem clear sound chip
20 pokes+5,9:pokes+6,0
30 pokes+24,15:rem set volume to maximum
40 readhf,lf,dr
50 ifhf<0thenend
60 pokes+1,hf:pokes,lf
70 pokes+4,33
80 fort=1todr:next
90 pokes+4,32:fort=1to50:next
100 goto 40
110 data 25,177,250,28,214,250
120 data 25,177,250,25,177,250
130 data 25,177,125,28,214,125
140 data 32,94,750,25,177,250
150 data 28,214,250,19,63,250
160 data 19,63,250,19,63,250
170 data 21,154,63,24,63,63
180 data 25,177,250,24,63,125
190 data 19,63,250,-1,-1,-1
