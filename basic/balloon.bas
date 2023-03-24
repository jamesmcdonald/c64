10 rem sprite example 1...
20 rem the hot air balloon
30 vic=13*4096:rem this is where the vic registers begin
31 print "filling sprite...";
32 fory=0to62:poke192*64+y,255:next
33 print "done"
35 poke vic+21,1:rem enable sprite 0
36 rem poke vic+33,14:rem set background colour to light blue
37 poke vic+23,1:rem expand sprite 1 x
38 poke vic+29,1:rem expand sprite 1 y
40 poke 2040,192:rem set sprite 0's pointer
180 poke vic+0,100:rem set sprite 0 x
190 poke vic+1,100:rem set sprite 0 y
220 poke vic+39,1:rem set sprite 0 colour
250 fory=0to62:rem byte counter with sprite loop
300 reada:rem read in a byte
310 poke192*64+y,a:rem store sprite data
320 nexty
330 dx=1:dy=1
340 x=peek(vic):rem get x position
350 y=peek(vic+1):rem get y position
360 ify=50ory=208thendy=-dy:rem bounce y
380 ifx=24and(peek(vic+16)and1)=0thendx=-dx:rem if sprite
390 rem is touching left and the msb is 0, reverse
400 ifx=40and(peek(vic+16)and1)=1thendx=-dx:rem if sprite
410 rem is touching right and the msb is 1, reverse
420 ifx=255anddx=1thenx=-1:side=1
440 ifx=0anddx=-1thenx=256:side=0
460 x=x+dx:rem add delta x to x
470 x=xand255:rem make sure x is in range
480 y=y+dy:rem add delta y to y
485 poke vic+16,side
490 poke vic,x
510 poke vic+1,y
520 rem print x, y
530 goto 340
600 rem ***** sprite data *****
rem 610 data 0,127,0,1,255,192,3,255,224,3,231,224
rem 620 data 7,217,240,7,223,240,7,217,240,3,231,224
rem 630 data 3,255,224,3,255,224,2,255,160,1,127,64
rem 640 data 1,62,64,0,156,128,0,156,128,0,73,0,0,73,0
rem 650 data 0,62,0,0,62,0,0,62,0,0,28,0,0
rem 2000 data 0, 0, 0, 0, 0, 0, 0, 0, 0
rem 2010 data 0, 0, 0, 0, 0, 0, 0, 0, 0
rem 2020 data 0, 0, 0, 0, 0, 0, 0, 0, 0
rem 2030 data 0, 0, 0, 0, 0, 0, 0, 0, 0
rem 2040 data 0, 0, 0, 0, 0, 0, 0, 0, 0
rem 2050 data 7, 255, 224, 15, 255, 240, 31, 255, 248
rem 2060 data 63, 255, 252, 127, 255, 254, 255, 255, 255
2000 data 15, 255, 240, 56, 0, 28, 96, 0, 6
2010 data 192, 0, 3, 128, 0, 1, 128, 0, 1
2020 data 128, 0, 1, 134, 0, 97, 143, 0, 241
2030 data 143, 0, 241, 134, 0, 97, 128, 0, 1
2040 data 128, 0, 1, 140, 0, 49, 135, 0, 225
2050 data 129, 255, 129, 128, 126, 1, 192, 0, 3
2060 data 96, 0, 6, 56, 0, 28, 15, 255, 240
