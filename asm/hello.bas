5 rem loader for awesome hello routine
10 l = 49152:x = 0
20 read y
30 if y < 0 then goto 80
40 poke l+x, y
50 gosub 500
60 x = x + 1: goto 20
80 print:print "loaded"x"bytes at"l
90 print "jumping to routine":sys 49152
100 end

500 rem print the contents of y as hex
510 a = (y and 240) / 16
520 b = y and 15
530 a = a + 48
540 if a > 57 then a = a + 7
550 b = b + 48
560 if b > 57 then b = b + 7
570 print chr$(a);chr$(b);
580 return

1999 rem awesome hand-assembled hello routine
2000 data 162,0,189,15,192,240,7,32,210,255
2001 data 232,76,2,192,96,72,69,76,76,79,13,0
2002 data -1
