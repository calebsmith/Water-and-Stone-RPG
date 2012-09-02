DECLARE SUB hexload (bclear%(), cursor%(), xp2, yp2, x, y, thr)
DECLARE SUB load (bclear%(), bs, F$, mousebackchange, lbchange, colchange, mx, my, size)
DECLARE SUB save (bclear%(), cx, cy, bs, F$, mx, my)
DECLARE SUB MouseDriver (Ax%, bx%, cx%, dx%)
DECLARE FUNCTION MouseInit% ()
DECLARE SUB MOUSEPUT (PUTX%, PUTY%)
DECLARE SUB MOUSESTATUS (lb%, rb%, xMOUSE%, YMOUSE%)
DIM SHARED MOUSE$, Ax%, bx%, cx%, dx%, lb%, rb%, xMOUSE%, YMOUSE%, PADDLEWIDTH, PADDLEHEIGHT, GRAVITY, BALLSLEFT, SECRET$, CROSSHAIRS, PADDLESLOPE
c3 = 32
c30 = 112
size = 10
CLS
SCREEN 13
path$ = "C:\myrpg\"
beg$ = "Island"
beg2$ = ""
beg$ = path$ + beg$ + beg2$
end$ = ".dat"
F$ = beg$ + end$

hl = 2
bs = 15
bn = 10            ' number of squares in grid
kc = 10
cb = 0
bxs = ABS(INT(bxs))
bxs = 160 \ bn
sus = 0
thr = 0
c4 = 10
xp = 7
yp = 7
points = xp * yp
S = 1
mousebackchange = 1
lbchange = 1
filenamechange = 1
dischange = 1
bc = 18
cl = 31
DIM saveget(3251)
DIM c(points)
DIM cursor%(points)
DIM cbox(1024)
DIM bclear%(points)
'--Read Mouse Data
RESTORE
MOUSE$ = SPACE$(57)
FOR i% = 1 TO 57
READ a$
h$ = CHR$(VAL("&H" + a$))
MID$(MOUSE$, i%, 1) = h$
NEXT i%
DATA 55,89,E5,8B,5E,0C,8B,07,50,8B,5E,0A,8B,07,50,8B
DATA 5E,08,8B,0F,8B,5E,06,8B,17,5B,58,1E,07,CD,33,53
DATA 8B,5E,0C,89,07,58,8B,5E,0A,89,07,8B,5E,08,89,0F
DATA 8B,5E,06,89,17,5D,CA,08,00
ms% = MouseInit
DIM SHARED changed
CLS
SCREEN 13

FOR D = 1 TO points
READ c(D)
NEXT
MOUSEPUT 10, 10
DIM p(1)




c = 2                   'default color
CLS


'background (The black and white and gray thing all around)

DEF SEG = &HA000
BLOAD "C:\myrpg\back_5.dis", 0

'the text box (hide the background)
'LINE (165, 5)-(315, 50), 0, BF


'load tile
CALL load(bclear%(), bs, F$, mousebackchange, lbchange, colchange, mx, my, size)
'PAINT (100, 100), 0, 70

' actual program loop
DO
'------Check mouse and move the cursor as needed
MOUSESTATUS lb%, rb%, xMOUSE%, YMOUSE%
changed = 0
IF xMOUSE% <> p(0) THEN changed = 1
IF YMOUSE% <> p(1) THEN changed = 1
p(0) = xMOUSE%
p(1) = YMOUSE%
IF hl = 0 THEN
        x = p(0) + xp2 + 5
        y = p(1) + yp2 + 5
        IF changed = 1 THEN hl = 2
END IF
IF hl = 2 THEN
        x = p(0)
        y = p(1)
END IF

x = INT(x / 2)

IF INT(x / size) <> x / size THEN x = INT(x / size) * size
IF INT(y / size) <> y / size THEN y = INT(y / size) * size
IF x < size THEN x = size
IF x > (mx * size) THEN x = mx * size
IF y < size * 2 THEN y = size * 2
IF y > (my * size) - 10 THEN y = my * size - 10
                                       
IF hl = 1 THEN
        x = xp2 + 5
        y = yp2 + 5
        hl = 0
END IF

IF lb% = 0 THEN 'draw
        lbchange = 1
        LINE (x, y)-(x - (size - 1), y - (size - 1)), c - 1, BF
END IF

IF rb% = 0 THEN       'draw bigger
        lbchange = 1
       
        
        
END IF
IF lb% = 0 AND rb% = 0 THEN 'draw huge
  IF x > 17 AND y > 14 THEN LINE (x, y)-(x - 11, y - 7), c - 1, BF
END IF

letkey = letkey + 1
IF letkey > 200 THEN
kl = 1
letkey = 0
ELSE
kl = 0

END IF

'load from keyboard
  IF kl = 1 THEN

  DEF SEG = 0: k = INP(&H60)
  WHILE LEN(INKEY$): WEND
  SELECT CASE k
    CASE &H3B   'F1
    CASE &H3C   'F2
    CHAIN "/windows/desktop/ladder/paint.bas"
    CASE &H3D   'F3
       GET (165, 45)-(315, 110), saveget
    CALL save(bclear%(), cx, cy, bs, F$, mx, my)
       PUT (165, 45), saveget, PSET
     CASE &H3E   'F4
    CALL load(bclear%(), bs, F$, mousebackchange, lbchange, colchange, mx, my, size)
    CASE &H3F   'F5
   ' CALL hexload(bclear%(), cursor%(), xp2, yp2, x, y, thr)
   CASE &H40   'F6
    CASE &H52   '0
    CASE &H4C   '5
    CASE &H1E   'A
    CASE &H2C   'Z
    CASE &H50
        c = c - 32
        IF c < 0 THEN c = 255
        kl = 0
        klf = 0
       
    CASE &H48
        c = c + 32
        IF c > 255 THEN c = 16
        kl = 0
        klf = 0
      
    CASE &H4B 'left
        c = c - 1
        IF c < 0 THEN c = 255
        kl = 0
        klf = 0
    CASE &H4D 'right
        c = c + 1
        IF c > 255 THEN c = 0
        kl = 0
        klf = 0
    CASE &H4A   '+
      
    CASE &H4E   '-
      
    CASE 1
      EXIT DO
    END SELECT

END IF
IF kl = 0 THEN
klf = klf + 1
END IF
IF klf > kc THEN kl = 1

'WAIT &H3DA, 8

 

c4 = c
FOR cdx = 0 TO 312 STEP 10

c4 = c4 - 1
LINE (312 - cdx, 195)-(318 - cdx, 197), c4, BF
NEXT
LINE (311, 193)-(319, 199), 15, B
c6 = c5
c5 = c4 + 31
IF c5 = -1 THEN c5 = 0
IF c6 <> c5 OR colchange = 1 THEN
colchange = 0
'LOCATE 5, 35
'COLOR 0
'PRINT "    "
'LOCATE 4, 35
'COLOR 0
'PRINT "    "
END IF
'LOCATE 5, 35
'IF c5 <> 0 AND c5 <> 16 THEN
'COLOR c5
'ELSE
'COLOR 15
'END IF
'PRINT c5
'LOCATE 4, 35
'IF POINT(x, y) <> 0 AND POINT(x, y) <> 16 THEN
'COLOR POINT(x, y)
'ELSE
'COLOR 15
'END IF
'PRINT POINT(x, y)

'display filename
'IF filenamechange = 1 THEN
'        filenamechange = 0
'        LOCATE 2, 22
'        COLOR 15
'        PRINT F$
'END IF

'display labels in top right
'IF dischange = 1 THEN
'        LOCATE 4, 22
'        PRINT "Current color"
'        LOCATE 5, 22
'        PRINT "New color"
'        LOCATE 6, 22
'        PRINT "Current Tile"
'        dischange = 0
'END IF




IF mousebackchange = 1 THEN
        GET (x + 1, y + 1)-(x + xp + 1, y + yp + 1), bclear%
        changed = 1
        mousebackchange = 0
END IF
IF x > 0 AND y > 0 THEN
IF thr = 1 AND cx + 1 > 0 AND changed = 1 THEN PUT (cx + 1, cy + 1), bclear%, PSET
thr = 1
IF changed = 1 THEN GET (x + 1, y + 1)-(x + xp + 1, y + yp + 1), bclear%
IF hl = 2 THEN
IF changed = 1 THEN
DEF SEG = &HA000
D = 0
FOR yd = 0 TO 6
FOR xd = 0 TO 6
D = D + 1
IF c(D) <> 16 THEN POKE (x + 1 + xd) + ((y + 1 + yd) * 320), c(D)
NEXT
NEXT
END IF

END IF
END IF
cx = x
cy = y



LOOP
LOCATE 22, 15
INPUT "save?", q$
q$ = UCASE$(q$)
IF q$ = "Y" OR q$ = "YES" THEN
CALL save(bclear%(), cx, cy, bs, F$, mx, my)
END IF
IF q$ <> "Y" AND q$ <> "YES" THEN
PRINT "exiting..."
SLEEP 1
END IF

STOP




DATA   31,30,29,28,27,16,16
DATA   30,29,28,27,16,16,16
DATA   29,28,27,26,16,16,16
DATA   28,27,26,25,24,16,16
DATA   27,16,16,24,23,22,16
DATA   16,16,16,16,22,21,20
DATA   16,16,16,16,16,20,19

SUB hexload (bclear%(), cursor%(), xp2, yp2, x, y, thr)
CLS
DEF SEG = &HA000
OPEN "hg.txt" FOR INPUT AS #1
INPUT #1, xp2
INPUT #1, yp2



FOR y = 5 TO yp2 + 4
FOR x = 5 TO xp2 + 4
INPUT #1, c$
F$ = LEFT$(c$, 1)
l$ = RIGHT$(c$, 1)
F$ = LCASE$(F$)
l$ = LCASE$(l$)
IF F$ = "f" THEN F$ = "15"
IF F$ = "e" THEN F$ = "14"
IF F$ = "d" THEN F$ = "13"
IF F$ = "c" THEN F$ = "12"
IF F$ = "b" THEN F$ = "11"
IF F$ = "a" THEN F$ = "10"
IF l$ = "f" THEN l$ = "15"
IF l$ = "e" THEN l$ = "14"
IF l$ = "d" THEN l$ = "13"
IF l$ = "c" THEN l$ = "12"
IF l$ = "b" THEN l$ = "11"
IF l$ = "a" THEN l$ = "10"
F = VAL(F$)
l = VAL(l$)
F = F * 16
l = l * 1
COLR = F + l
POKE x + y * 320, COLR
NEXT
NEXT
CLOSE
END SUB

SUB load (bclear%(), bs, F$, mousebackchange, lbchange, colchange, mx, my, size)
DEF SEG = &HA000
OPEN F$ FOR INPUT AS #1
INPUT #1, mx
INPUT #1, my
FOR y = 1 TO my * size - 10 STEP size
FOR x = 1 TO mx * size STEP size
INPUT #1, c
  IF y > 10 AND y < my * size - 10 THEN LINE (x, y)-(x + size - 1, y + size - 1), c, BF
NEXT
NEXT
CLOSE
colchange = 1
lbchange = 1
mousechange = 1
END SUB

SUB MouseDriver (Ax%, bx%, cx%, dx%)
  DEF SEG = VARSEG(MOUSE$)
  MOUSE% = SADD(MOUSE$)
  CALL Absolute(Ax%, bx%, cx%, dx%, MOUSE%)
END SUB

FUNCTION MouseInit%

 

  Ax% = 0

 ' MouseDriver Ax%, 0, 0, 0

 MouseInit% = Ax%



END FUNCTION

SUB MOUSEPUT (PUTX%, PUTY%)

  Ax% = 4

  cx% = PUTX%

  dx% = PUTY%

  MouseDriver Ax%, 0, cx%, dx%

END SUB

SUB MOUSESTATUS (lb%, rb%, xMOUSE%, YMOUSE%)

  Ax% = 3

  MouseDriver Ax%, bx%, cx%, dx%

  lb% = ((bx% AND 1) <> 1)

  rb% = ((bx% AND 2) <> 2)

  xMOUSE% = cx%

  YMOUSE% = dx%

END SUB

SUB save (bclear%(), cx, cy, bs, F$, mx, my)
DIM saveget%(150 * 65)
DEF SEG = &HA000
PUT (cx + 1, cy + 1), bclear%, PSET
c = 1
CLOSE
'OPEN "/windows/desktop/ladder/tile41.dat" FOR OUTPUT AS #1
OPEN F$ FOR OUTPUT AS #1
PRINT #1, mx
PRINT #1, my
FOR y = 9 TO (my * 5) + 9 STEP 2
FOR x = 7 TO (mx * 5) + 6 STEP 3
c = POINT(x, y)
PRINT #1, c
NEXT
NEXT
CLOSE
GET (165, 45)-(315, 110), saveget%
LINE (165, 45)-(315, 110), 0, BF
LINE (166, 46)-(314, 109), 28, B
LOCATE 7, 22
PRINT "Image is saved."
LOCATE 9, 22
PRINT "Saved as"
LOCATE 10, 22
PRINT F$
LOCATE 12, 22
PRINT "Press any key"
LOCATE 13, 22
PRINT "to continue."
'PUT (165, 45), saveget%
SLEEP


CALL load(bclear%(), bs, F$, mousebackchange, lbchange, colchange, mx, my, size)
END SUB

