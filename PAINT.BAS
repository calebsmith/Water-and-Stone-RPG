DECLARE SUB hexload (bclear%(), cursor%(), xp2, yp2, x, y, thr)
DECLARE SUB toolbox ()
DECLARE SUB load (bclear%(), bs, f$, mousebackchange, lbchange, colchange, xwid, ywid)
DECLARE SUB save (bclear%(), cx, cy, bs, f$, xwid, ywid, filename$)
DECLARE SUB cfn (f$, filenamechange, path$, filename$, oldf$)
DECLARE SUB MouseDriver (Ax%, bx%, cx%, dx%)
DECLARE FUNCTION MouseInit% ()
DECLARE SUB MOUSEPUT (PUTX%, PUTY%)
DECLARE SUB mousestatus (lb%, rb%, xMOUSE%, YMOUSE%)
DIM SHARED MOUSE$, Ax%, bx%, cx%, dx%, lb%, rb%, xMOUSE%, YMOUSE%, PADDLEWIDTH, PADDLEHEIGHT, GRAVITY, BALLSLEFT, SECRET$, CROSSHAIRS, PADDLESLOPE
ON ERROR GOTO 5
c3 = 32
c30 = 112

CLS
SCREEN 13
path$ = ""
inp$ = "2"
beg2$ = "tile"
beg$ = path$ + beg2$
end$ = ".dat"

f$ = beg$ + inp$ + end$
filename$ = beg2$ + inp$
hl = 2
bs = 15
xwid = 10
ywid = 10
'IF xwid = 10 AND ywid = 10 THEN bs = 15
bsx = 150 / xwid
bsy = 150 / ywid
IF bsx < bsy THEN bs = INT(bsx)
IF bsy < bsx THEN bs = INT(bsy)
IF bs > 10 THEN windis = 5
IF bs < 11 THEN windis = 5
bn = 100            ' number of squares in grid
kc = 20
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
'mousebackchange = 1
lbchange = 1
filenamechange = 1
dischange = 1
bc = 18
cl = 31
DIM saveget(3301)
DIM c(points)
DIM cursor%(points)
DIM cbox(1024)
DIM savc(100)
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

MOUSEPUT 10, 10
DIM p(1)


'background (The black and white and gray thing all around)

DEF SEG = &HA000
BLOAD "BACK_5.dis", 0

'border of editing region
LINE (0, 0)-(151, 151), 19, B
LINE (152, 0)-(152, 152), 21
LINE (0, 152)-(152, 152), 21
LINE (153, 0)-(153, 153), 23
LINE (0, 153)-(153, 153), 23
LINE (154, 0)-(154, 154), 25
LINE (0, 154)-(154, 154), 25

'the text box (hide the background) and make border
LINE (165, 5)-(315, 58), 0, BF
LINE (165, 5)-(315, 58), 17, B
LINE (164, 4)-(316, 59), 19, B
LINE (163, 3)-(317, 60), 21, B
LINE (162, 2)-(318, 61), 23, B
LINE (161, 1)-(319, 62), 25, B
'load default tile to edit

CALL load(bclear%(), bs, f$, mousebackchange, lbchange, colchange, xwid, ywid)


'load picture of mouse cursor
CLOSE
OPEN "cursor.dat" FOR INPUT AS #1
        FOR d = 1 TO 49
                INPUT #1, c(d)
        NEXT
CLOSE


' actual program loop
DO
'------Check mouse and move the cursor as needed
mousestatus lb%, rb%, xMOUSE%, YMOUSE%
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
IF x < bs * xwid + windis AND y < bs * ywid + windis THEN
        x = INT(x \ bs) * bs
        y = INT(y \ bs) * bs
END IF
       
       
IF x < bs THEN x = bs
IF x > 305 THEN x = 305
'IF x > bs * 10 THEN x = bs * 10
IF y < bs THEN y = bs

IF y > 180 THEN y = 180


IF hl = 1 THEN
        x = xp2 + 5
        y = yp2 + 5
        hl = 0
END IF

IF lb% = 0 THEN
        IF x < bs * xwid + windis AND y < bs * ywid + windis THEN ' checks if the cursor is in the tile editing window
                lbchange = 1  'if the tile is changed let the tiny display know
                IF c - 1 <> 254 THEN LINE (x, y)-(x - (bs - 1), y - (bs - 1)), c - 1, BF
                IF c - 1 = 254 THEN
                        LINE (x, y)-(x - (bs - 1), y - (bs - 1)), 1, B
                        LINE (x - 1, y - 1)-(x - (bs - 1) + 1, y - (bs - 1) + 1), 0, BF
                END IF
        END IF
END IF
IF rb% = 1 THEN
        LOCATE 1, 1
        PRINT "RIGHT MOUSE BUTTON!"
END IF


keylet = keylet + 1
IF keylet > 20 THEN
keylet = 0
kl = 1
END IF


'load from keyboard
  IF kl = 1 THEN
  DEF SEG = 0: k = INP(&H60)
  WHILE LEN(INKEY$): WEND
  SELECT CASE k
    CASE &H3B   'F1
    CASE &H3D   'F3 - Save
        GET (165, 45)-(319, 110), saveget
        CALL save(bclear%(), cx, cy, bs, f$, xwid, ywid, filename$)
        CALL load(bclear%(), bs, f$, mousebackchange, lbchange, colchange, xwid, ywid)
        PUT (165, 45), saveget, PSET
    CASE &H3E   'F4 - Load
        CALL load(bclear%(), bs, f$, mousebackchange, lbchange, colchange, xwid, ywid)
546
    CASE &H3F   'F5 - change filename
        GET (165, 45)-(315, 110), saveget
        CALL cfn(f$, filenamechange, path$, filename$, oldf$)
        PUT (165, 45), saveget, PSET
    CASE &H40   'F6 - rotate
        'buffer existing tiles
        d = 0
        FOR y = bs TO bs * ywid STEP bs
            FOR x = bs TO bs * xwid STEP bs
                    d = d + 1
                    savc(d) = POINT(x, y)
            NEXT
        NEXT
        d = 0
        'display
        FOR x = bs TO bs * xwid STEP bs
            FOR y = bs * ywid TO bs STEP -bs
                    d = d + 1
                    LINE (x, y)-(x - bs + 1, y - bs + 1), savc(d), BF
            NEXT
        NEXT

    CASE &H52   '0
    CASE &H4C   '5
    CASE &H1E   'A
    CASE &H2C   'Z
    CASE &H50
     
    CASE &H48
      
    CASE &H4B 'left - move color left
        c = c - 1
        IF c < 0 THEN c = 255
        kl = 0
        klf = 0

    CASE &H4D 'right - move color right
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
IF x < bs * xwid + windis AND y < bs * ywid + windis THEN
        IF prncol <> POINT(x, y) THEN colchange = 1
        prncol = POINT(x, y)
        COLOR prncol
        IF prncol = 0 OR prncol = 16 THEN COLOR 15
        PRINT prncol
END IF



'display filename
IF filenamechange = 1 THEN
        filenamechange = 0
        LOCATE 2, 22
        COLOR 0
        PRINT "                "
        LOCATE 2, 22
        COLOR 15
        PRINT "Editing:"; filename$
END IF

'display labels in top right
IF dischange = 1 THEN
        COLOR 31
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
        PUT (cx + 1, cy + 1), bclear%, PSET
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
FOR yd = 0 TO 6  'draw mouse cursor
        FOR xd = 0 TO 6
                d = d + 1
                IF c(d) <> 16 THEN
                        IF x <> INT(x) THEN x = x + .5
                        IF x = INT(x) THEN PSET (x + 1 + xd, y + 1 + yd), c(d)
                        POKE (x + 1 + xd) + ((y + 1 + yd) * 320), c(d)
                END IF
        NEXT
NEXT
END IF

END IF
END IF
cx = x
cy = y


10


LOOP

COLOR 15
LOCATE 22, 5
INPUT "Save before quitting?", q$
q$ = UCASE$(q$)
IF q$ = "Y" OR q$ = "YES" THEN
CALL save(bclear%(), cx, cy, bs, f$, xwid, ywid, filename$)
END IF
IF q$ <> "Y" AND q$ <> "YES" THEN
PRINT "exiting..."
SLEEP 1
END IF
SYSTEM
5
IF ERR = 53 THEN
        COLOR 36
        LOCATE 3, 22
        PRINT "File not Found"
        LOCATE , 22
        PRINT "Loading:"; oldf$
        f$ = oldf$
        
        SLEEP 4
        LINE (165, 5)-(315, 58), 0, BF
        dischange = 1
        filenamechange = 1
        CALL load(bclear%(), bs, f$, mousebackchange, lbchange, colchange, xwid, ywid)
       
        f$ = "tile2.dat"
        oldf$ = "tile2.dat"
        GOTO 546
        'RESUME NEXT
ELSE
        LOCATE 1, 1
        PRINT "ERROR NUMBER:"; ERR; "  After line"; ERL
        PRINT "Unexpected error. Exiting program."
END IF
SLEEP 10
SYSTEM

SUB cfn (f$, filenamechange, path$, filename$, oldf$)
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
oldf$ = f$
f$ = path$ + filename$ + ".dat"
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

SUB levelmaker
mousestatus lb%, rb%, xMOUSE%, YMOUSE%

END SUB

SUB load (bclear%(), bs, f$, mousebackchange, lbchange, colchange, xwid, ywid)
DEF SEG = &HA000
CLOSE
OPEN f$ FOR INPUT AS #1
FOR y = bs TO bs * ywid STEP bs
FOR x = bs TO bs * xwid STEP bs
INPUT #1, lodc
IF lodc = 254 THEN
        LINE (x, y)-(x - bs + 1, y - bs + 1), 1, B
        LINE (x - 1, y - 1)-(x - bs + 2, y - bs + 2), 0, BF
ELSE
        LINE (x, y)-(x - bs + 1, y - bs + 1), lodc, BF
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

SUB mousestatus (lb%, rb%, xMOUSE%, YMOUSE%)

  Ax% = 3

  MouseDriver Ax%, bx%, cx%, dx%

  lb% = ((bx% AND 1) <> 1)

  rb% = ((bx% AND 2) <> 2)

  xMOUSE% = cx%

  YMOUSE% = dx%

END SUB

SUB save (bclear%(), cx, cy, bs, f$, xwid, ywid, filename$)
DEF SEG = &HA000
PUT (cx + 1, cy + 1), bclear%, PSET
'savc = 1
CLOSE
OPEN f$ FOR OUTPUT AS #1
FOR y = bs TO bs * ywid STEP bs
FOR x = bs TO bs * xwid STEP bs
savc = POINT(x, y)
savc2 = POINT(x + 1, y + 1)
IF savc = 1 AND savc2 = 0 THEN c = 254
'IF x > 50 AND y > 10 AND thrus = 0 THEN
'thrus = 1
'LOCATE 5, 21
'COLOR 31
'PRINT "Saving..."
'END IF
PRINT #1, savc
NEXT
NEXT
CLOSE
'GET (165, 45)-(315, 110), saveget%
LINE (165, 45)-(320, 110), 0, BF
LINE (166, 46)-(319, 109), 28, B
COLOR 29
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


'CALL load(bclear%(), bs, F$, mousebackchange, lbchange, colchange, xwid, ywid)
END SUB

SUB toolbox
OPEN "savetile.dat" FOR INPUT AS #1
        FOR ysav = 1 TO 15
                FOR xsav = 1 TO 21
                        INPUT #1, savcol
                        LINE (0, 0)-(xsav + 190, ysav + 165), savcol
                NEXT
        NEXT
CLOSE
SLEEP
END SUB

