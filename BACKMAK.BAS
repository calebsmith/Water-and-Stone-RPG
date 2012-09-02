DECLARE SUB hexload (bclear%(), cursor%(), xp2, yp2, x, y, thr)
DECLARE SUB load (bclear%(), bs, f$, file$)
DECLARE SUB save (bclear%(), cx, cy, bs, f$, file$)
DECLARE SUB MouseDriver (Ax%, bx%, cx%, dx%)
DECLARE FUNCTION MouseInit% ()
DECLARE SUB MOUSEPUT (PUTX%, PUTY%)
DECLARE SUB MOUSESTATUS (lb%, rb%, xMOUSE%, YMOUSE%)
DIM SHARED MOUSE$, Ax%, bx%, cx%, dx%, lb%, rb%, xMOUSE%, YMOUSE%, PADDLEWIDTH, PADDLEHEIGHT, GRAVITY, BALLSLEFT, SECRET$, CROSSHAIRS, PADDLESLOPE
DIM tile30%(100)
DIM C4(100)
DIM cursorc(49)
'ON ERROR GOTO 5
file$ = "house_5.dis"
c3 = 32
CLS
SCREEN 13
hl = 2
bs = 10
bn = 10            ' number of squares in grid
kc = 70
cb = 0
bxs = ABS(INT(bxs))
bxs = 160 \ bn
sus = 0
thr = 0
xp = 7
yp = 7
S = 1
bc = 18
cl = 31

changed = 1
DIM cursor%(49)
DIM cbox(1024)
DIM bclear%(49)
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
'DIM SHARED changed
CLS
SCREEN 13

FOR d = 1 TO 49
READ cursorc(d)
NEXT

MOUSEPUT 10, 10
DIM p(1)




'title
'DEF SEG = &HA000
'BLOAD "c:\dos\shl.dis", 0
'bc = 31
'cl = 128
'DO
'FOR c = 32 TO 64
'COLOR c
'LOCATE 10, 16
'PRINT "Caleb's Paint"
'NEXT
'LOOP UNTIL INKEY$ <> ""




CLS




c = 32                   'default color
PAINT (100, 100), 16, 16
'CALL load(bclear%(), bs, f$)


DEF SEG = &HA000
'OPEN "C:\rpg\tile10.dat" FOR INPUT AS #1
'FOR d = 1 TO 100
'INPUT #1, C4(d)
'NEXT
'd = 0
'FOR y = 1 TO 10
'FOR x = 1 TO 10
'd = d + 1
'POKE x + y * 320, C4(d)
'NEXT x
'NEXT y
'GET (1, 1)-(10, 10), tile30%
'CLOSE
'FOR y = 0 TO 150 STEP 10
'FOR x = 0 TO 310 STEP 10
'PUT (x, y), tile30%, PSET
'NEXT
'NEXT
'LINE (0, 160)-(320, 160), 4
'PAINT (0, 161), 185, 4






BLOAD file$, 0
'LINE (120, 110)-(180, 130), 0, B
'LINE (120, 140)-(180, 160), 0, B
'LINE (120, 170)-(180, 190), 0, B
'LINE (107, 117)-(113, 123), 0, BF
'LINE (107, 147)-(113, 153), 0, BF
'LINE (107, 177)-(113, 183), 0, BF
'CLS
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
'x = x / 2
'x = INT(x \ bs) * bs
'y = INT(y \ bs) * bs
IF x < 1 THEN x = 1
IF x > 310 THEN x = 310
IF y < 1 THEN y = 1
IF y > 189 THEN y = 189
IF hl = 1 THEN
    x = xp2 + 5
    y = yp2 + 5
hl = 0
END IF
IF lb% = 0 THEN
IF c - 1 <> 254 THEN PSET (x, y), c - 1
IF c - 1 = 254 THEN PSET (x, y), 1
END IF






'load from keyboard
  IF kl = 1 THEN
  DEF SEG = 0: k = INP(&H60)
  WHILE LEN(INKEY$): WEND
  SELECT CASE k
    CASE &H3B   'F1
    CASE &H3C   'F2
    CHAIN "paint.bas"
    CASE &H3D   'F3
    CALL save(bclear%(), cx, cy, bs, f$, file$)
     CASE &H3E   'F4
    CALL load(bclear%(), bs, f$, file$)
    CASE &H3F   'F5
   ' CALL hexload(bclear%(), cursor%(), xp2, yp2, x, y, thr)
    hl = 1
    CASE &H40   'F6
    CASE &H52   '0
    CASE &H4C   '5
    CASE &H1E   'A
    CASE &H2C   'Z
    CASE &H50
     
    CASE &H48
      
    CASE &H4B
      c = c - 1
    IF c < 0 THEN c = 255
    kl = 0
    klf = 0
    CASE &H4D
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

 

C4 = c
FOR cdx = 0 TO 312 STEP 10

C4 = C4 - 1
LINE (312 - cdx, 195)-(318 - cdx, 197), C4, BF
NEXT
LINE (311, 193)-(319, 199), 15, B




IF x > 0 AND y > 0 THEN
IF thr = 1 AND cx + 1 > 0 AND changed = 1 THEN PUT (cx + 1, cy + 1), bclear%, PSET
thr = 1
IF changed = 1 THEN GET (x + 1, y + 1)-(x + xp + 1, y + yp + 1), bclear%
IF hl = 2 THEN
IF changed = 1 THEN
'PUT (x + 1, y + 1), cursor%, PSET

DEF SEG = &HA000
d = 0
FOR yd = 0 TO 6
FOR xd = 0 TO 6
d = d + 1

IF cursorc(d) <> 16 THEN PSET (x + 1 + xd, y + 1 + yd), cursorc(d)
'POKE (x + 1 + xd) + ((y + 1 + yd) * 320), cursorc(d)
NEXT
NEXT
END IF
END IF
END IF
cx = x
cy = y









cc = cc + 1
c2 = c3
IF cc > 15 THEN
cc = 0
IF c3 = 79 THEN
        c3 = 176
        GOTO 10
END IF
IF c3 = 176 THEN
        c3 = 104
        GOTO 10
END IF
IF c3 = 104 THEN
        c3 = 1
        GOTO 10
END IF
IF c3 = 1 THEN
        c3 = 32
        GOTO 10
END IF
IF c3 = 32 THEN
        c3 = 55
        GOTO 10
END IF
IF c3 = 55 THEN
        c3 = 79
        GOTO 10
END IF

10
OUT &H3C7, c3
r = INP(&H3C9)
g = INP(&H3C9)
B = INP(&H3C9)
WAIT &H3DA, 8
OUT &H3C8, c2
OUT &H3C9, r
OUT &H3C9, g
OUT &H3C9, B

END IF

IF rb% = 0 THEN
LINE (x + 0, y - 5)-(x - 0, y + 5), c - 1
END IF

LOOP
STOP




DATA   31,30,29,28,27,16,16
DATA   30,29,28,27,16,16,16
DATA   29,28,27,26,16,16,16
DATA   28,27,26,25,24,16,16
DATA   27,16,16,24,23,22,16
DATA   16,16,16,16,22,21,20
DATA   16,16,16,16,16,20,19

'PSET (x, y), 1
'CIRCLE (x, y), 1, 32
'CIRCLE (x, y), 2, 55
'PSET (x + 1, y + 1), 55
'PSET (x - 1, y - 1), 55
'PSET (x - 1, y + 1), 55
'PSET (x + 1, y - 1), 55
'CIRCLE (x, y), 3, 79
'PSET (x, y + 2), 55
'PSET (x, y - 2), 55
'PSET (x - 1, y + 3), 79
'PSET (x, y + 3), 79
'PSET (x + 1, y - 3), 79
'PSET (x - 1, y - 3), 79
'PSET (x, y - 3), 79
'PSET (x + 1, y + 3), 79

SUB hexload (bclear%(), cursor%(), xp2, yp2, x, y, thr)
CLS
DEF SEG = &HA000
OPEN "hg.txt" FOR INPUT AS #1
INPUT #1, xp2
INPUT #1, yp2



FOR y = 5 TO yp2 + 4
FOR x = 5 TO xp2 + 4
INPUT #1, c$
f$ = LEFT$(c$, 1)
l$ = RIGHT$(c$, 1)
f$ = LCASE$(f$)
l$ = LCASE$(l$)
IF f$ = "f" THEN f$ = "15"
IF f$ = "e" THEN f$ = "14"
IF f$ = "d" THEN f$ = "13"
IF f$ = "c" THEN f$ = "12"
IF f$ = "b" THEN f$ = "11"
IF f$ = "a" THEN f$ = "10"
IF l$ = "f" THEN l$ = "15"
IF l$ = "e" THEN l$ = "14"
IF l$ = "d" THEN l$ = "13"
IF l$ = "c" THEN l$ = "12"
IF l$ = "b" THEN l$ = "11"
IF l$ = "a" THEN l$ = "10"
f = VAL(f$)
l = VAL(l$)
f = f * 16
l = l * 1
COLR = f + l
POKE x + y * 320, COLR
NEXT
NEXT
CLOSE
END SUB

SUB load (bclear%(), bs, f$, file$)
CLS
DEF SEG = &HA000
BLOAD file$, 0
END SUB

SUB MouseDriver (Ax%, bx%, cx%, dx%)
  DEF SEG = VARSEG(MOUSE$)
  MOUSE% = SADD(MOUSE$)
  CALL Absolute(Ax%, bx%, cx%, dx%, MOUSE%)
END SUB

FUNCTION MouseInit%

 

  Ax% = 0

  'MouseDriver Ax%, 0, 0, 0

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

SUB save (bclear%(), cx, cy, bs, f$, file$)
DEF SEG = &HA000
PUT (cx + 1, cy + 1), bclear%, PSET

BSAVE file$, 0, 62000
SLEEP
CLS
CALL load(bclear%(), bs, f$, file$)
END SUB

