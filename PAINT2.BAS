DECLARE SUB hexload (bclear%(), cursor%(), xp2, yp2, x, y, thr)
DECLARE SUB load (bclear%(), bs, F$, mousebackchange, lbchange, colchange, xwid, ywid)
DECLARE SUB save (bclear%(), cx, cy, bs, F$, xwid, ywid, filename$)
DECLARE SUB cfn (F$, filenamechange, path$, filename$)
DECLARE SUB MouseDriver (Ax%, bx%, cx%, dx%)
DECLARE FUNCTION MouseInit% ()
DECLARE SUB MOUSEPUT (PUTX%, PUTY%)
DECLARE SUB MOUSESTATUS (lb%, rb%, xMOUSE%, YMOUSE%)
DIM SHARED MOUSE$, Ax%, bx%, cx%, dx%, lb%, rb%, xMOUSE%, YMOUSE%, PADDLEWIDTH, PADDLEHEIGHT, GRAVITY, BALLSLEFT, SECRET$, CROSSHAIRS, PADDLESLOPE
ON ERROR GOTO 5
c3 = 32
c30 = 112

CLS
SCREEN 12
PRINT "Do you want to edit characters or tiles?"
PRINT "1 = Tile"
PRINT "2 = Character"
INPUT inptype$
IF inptype$ <> "1" AND inptype$ <> "2" THEN inptype$ = "1"
PRINT " Tile number "
INPUT inp$
IF inp$ = " " OR inp$ = "" THEN inp$ = "1"
IF VAL(inp$) < 1 THEN inp$ = "1"
IF VAL(inp$) > 999 THEN inp$ = "999"
SCREEN 13
path$ = "C:\RPG\"
IF inptype$ = "1" THEN beg2$ = "tile"
IF inptype$ = "2" THEN beg2$ = "char"
beg$ = path$ + beg2$
end$ = ".dat"
F$ = beg$ + inp$ + end$
filename$ = beg2$ + inp$
hl = 2
bs = 5
xwid = 21
ywid = 15
IF bs > 10 THEN windis = 10
IF bs < 11 THEN windis = 0
bn = 100            ' number of squares in grid
kc = 10
cb = 0
bxs = ABS(INT(bxs))
bxs = 160 \ bn
sus = 0
thr = 0
c4 = 10
xp = 12
yp = 7
points = xp * yp
S = 1
mousebackchange = 1
lbchange = 1
filenamechange = 1
dischange = 1
bc = 18
cl = 31
DIM saveget(3301)
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

FOR d = 1 TO points
READ c(d)
NEXT
MOUSEPUT 10, 10
DIM p(1)




'title
'DEF SEG = &HA000
'BLOAD "c:\dos\shl.dis", 0
'bc = 31
'cl = 128









c = 2                   'default color
CLS


'background (The black and white and gray thing all around)

DEF SEG = &HA000
BLOAD "C:\RPG\BACK_5.dis", 0

'border of editing region
LINE (0, 0)-(151, 151), 22, B
LINE (152, 0)-(152, 152), 24
LINE (0, 152)-(152, 152), 24
LINE (153, 0)-(153, 153), 26
LINE (0, 153)-(153, 153), 26
LINE (154, 0)-(154, 154), 28
LINE (0, 154)-(154, 154), 28

'the text box (hide the background)
LINE (165, 5)-(315, 50), 0, BF


'load tile

CALL load(bclear%(), bs, F$, mousebackchange, lbchange, colchange, xwid, ywid)
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
x = x / 2
IF x < bs * xwid + windis THEN
        x = INT(x \ bs) * bs
        y = INT(y \ bs) * bs
ELSE
        'IF y < 100 THEN y = 100
END IF
IF x < bs THEN x = bs
IF x > 305 THEN x = 305
'IF x > bs * 10 THEN x = bs * 10
IF y < bs THEN y = bs
IF y > bs * ywid THEN y = bs * ywid


IF hl = 1 THEN
        x = xp2 + 5
        y = yp2 + 5
        hl = 0
END IF

IF lb% = 0 THEN
        IF x < bs * xwid + windis THEN  ' checks if the cursor is in the tile editing window
                lbchange = 1  'if the tile is changed let the tiny display know
                IF c - 1 <> 254 THEN LINE (x, y)-(x - (bs - 1), y - (bs - 1)), c - 1, BF
                IF c - 1 = 254 THEN
                        LINE (x, y)-(x - (bs - 1), y - (bs - 1)), 1, B
                        LINE (x - 1, y - 1)-(x - (bs - 1) + 1, y - (bs - 1) + 1), 0, BF
                END IF
        END IF
END IF
IF rb% = 0 THEN
'        c = c + 1
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
       GET (165, 45)-(319, 110), saveget
    CALL save(bclear%(), cx, cy, bs, F$, xwid, ywid, filename$)
       PUT (165, 45), saveget, PSET
     CASE &H3E   'F4
    CALL load(bclear%(), bs, F$, mousebackchange, lbchange, colchange, xwid, ywid)
    CASE &H3F   'F5
    GET (165, 45)-(315, 110), saveget
    CALL cfn(F$, filenamechange, path$, filename$)
      PUT (165, 45), saveget, PSET
   ' CALL hexload(bclear%(), cursor%(), xp2, yp2, x, y, thr)
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
LOCATE 5, 35
COLOR 0
PRINT "    "
LOCATE 4, 35
COLOR 0
PRINT "    "
END IF
LOCATE 5, 35
IF c5 <> 0 AND c5 <> 16 THEN
COLOR c5
ELSE
COLOR 15
END IF
PRINT c5
LOCATE 4, 35
IF x < bs * xwid + windis THEN
        COLOR POINT(x, y)
        IF POINT(x, y) = 0 OR POINT(x, y) = 16 THEN COLOR 15
        PRINT POINT(x, y)
END IF



'display filename
IF filenamechange = 1 THEN
        filenamechange = 0
        LOCATE 2, 22
        COLOR 15
        PRINT "Editing:"; filename$
END IF

'display labels in top right
IF dischange = 1 THEN
        LOCATE 4, 22
        PRINT "Current color"
        LOCATE 5, 22
        PRINT "New color"
        LOCATE 6, 22
        PRINT "Current Tile"
        dischange = 0
END IF

'display tile as seen (zoomed out)
IF lbchange = 1 THEN
DEF SEG = &HA000
        lbchange = 0
        ydiszm = 0
        FOR ydis = bs TO bs * ywid STEP bs
                ydiszm = ydiszm + 1
                xdiszm = 0
                FOR xdis = bs TO bs * xwid STEP bs
                        xdiszm = xdiszm + 1
                        cdis = POINT(xdis, ydis)
                        c2dis = POINT(x - 1, y - 1)
                                IF cdis = 1 AND c2dis = 0 THEN cdis = 0
                        POKE (280 + xdiszm) + ((40 + ydiszm) * 320), cdis
                NEXT
        NEXT
END IF

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
d = 0
FOR yd = 0 TO 6
FOR xd = 0 TO 6
d = d + 1
IF c(d) <> 16 THEN
IF x <> INT(x) THEN x = x + .5
IF x = INT(x) THEN PSET (x + 1 + xd, y + 1 + yd), c(d)
' POKE (FIX(x) + 1 + xd) + ((y + 1 + yd) * 320), c(d)
END IF
NEXT
NEXT
END IF

END IF
END IF
cx = x
cy = y



'cc = cc + 1
'c2 = c3
'IF cc > 10 THEN
'cc = 0
'IF c3 = 79 THEN
'        c3 = 176
'        GOTO 10
'END IF
'IF c3 = 176 THEN
'        c3 = 104
'        GOTO 10
'END IF
'IF c3 = 104 THEN
'        c3 = 1
'        GOTO 10
'END IF
'IF c3 = 1 THEN
'        c3 = 32
'        GOTO 10
'END IF
'IF c3 = 32 THEN
'        c3 = 55
'        GOTO 10
'END IF
'IF c3 = 55 THEN
'        c3 = 79
'        GOTO 10
'END IF
'END IF
5
10
'
'OUT &H3C7, c3
'r = INP(&H3C9)
'g = INP(&H3C9)
'B = INP(&H3C9)
'WAIT &H3DA, 8
'OUT &H3C8, c2
'OUT &H3C9, r
'OUT &H3C9, g
'OUT &H3C9, B



LOOP
LOCATE 20, 15
INPUT "save?", q$
q$ = UCASE$(q$)
IF q$ = "Y" OR q$ = "YES" THEN
CALL save(bclear%(), cx, cy, bs, F$, xwid, ywid, filename$)
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

SUB cfn (F$, filenamechange, path$, filename$)
LINE (165, 45)-(315, 110), 0, BF
LINE (166, 46)-(314, 109), 28, B
COLOR 29
LOCATE 7, 22
PRINT "Enter new filename"
LOCATE 8, 22
PRINT "Do not include:"
LOCATE 9, 22
PRINT "  Path"
LOCATE 10, 22
PRINT "  File Extension"
LOCATE 12, 22
INPUT "", filename$

F$ = path$ + filename$ + ".dat"
filenamechange = 1

END SUB

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

SUB load (bclear%(), bs, F$, mousebackchange, lbchange, colchange, xwid, ywid)
DEF SEG = &HA000
OPEN F$ FOR INPUT AS #1
FOR y = bs TO bs * ywid STEP bs
FOR x = bs TO bs * xwid STEP bs
INPUT #1, c
IF c = 254 THEN
        LINE (x, y)-(x - bs + 1, y - bs + 1), 1, B
        LINE (x - 1, y - 1)-(x - bs + 2, y - bs + 2), 0, BF
ELSE
        LINE (x, y)-(x - bs + 1, y - bs + 1), c, BF
END IF


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

  rb% = ((bx% OR 2) <> 1)

  xMOUSE% = cx%

  YMOUSE% = dx%

END SUB

SUB save (bclear%(), cx, cy, bs, F$, xwid, ywid, filename$)
DEF SEG = &HA000
PUT (cx + 1, cy + 1), bclear%, PSET
c = 1
CLOSE
OPEN F$ FOR OUTPUT AS #1
FOR y = bs TO bs * ywid STEP bs
FOR x = bs TO bs * xwid STEP bs
c = POINT(x, y)
c2 = POINT(x - 1, y - 1)
IF c = 1 AND c2 = 0 THEN c = 254
'IF x > 50 AND y > 10 AND thrus = 0 THEN
'thrus = 1
'LOCATE 5, 21
'COLOR 31
'PRINT "Saving..."
'END IF
PRINT #1, c
NEXT
NEXT
CLOSE
'GET (165, 45)-(315, 110), saveget%
LINE (165, 45)-(320, 110), 0, BF
LINE (166, 46)-(319, 109), 28, B
LOCATE 7, 22
PRINT "Image is saved."
LOCATE 9, 22
PRINT "Image saved as"
LOCATE 10, 22
PRINT filename$
LOCATE 12, 22
PRINT "Press any key"
LOCATE 13, 22
PRINT "to continue."
SLEEP


CALL load(bclear%(), bs, F$, mousebackchange, lbchange, colchange, xwid, ywid)
END SUB

