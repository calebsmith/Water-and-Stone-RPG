
CLS
SCREEN 13
DEF SEG = &HA000
randomize timer
FOR y = -1 TO 201 STEP 1
FOR x = -1 TO 321 STEP 1
c = INT(RND * 16) + 16
POKE x + (320 * y), c
NEXT
NEXT
thru = 0
DO
FOR y = 0 TO 200 STEP 1
FOR x = 0 TO 320 STEP 1
c = POINT(x, y)
c2 = POINT(x - 1, y)
c3 = POINT(x, y - 1)
c4 = POINT(x + 1, y)
c5 = POINT(x, y + 1)

c6 = (((c + c) + c2 + c3 + c4 + c5) / 6)
POKE x + (320 * y), c6
NEXT
NEXT
thru = thru + 1
LOOP UNTIL thru = 2
thru = 0
DO
thru = thru + 1
FOR y = 0 TO 200 STEP 1
FOR x = 0 TO 320 STEP 1
rrand = INT(RND * 10) + 1
IF rrand > 8 THEN PSET (x, y), 16
NEXT
NEXT
LOOP UNTIL thru = 1
thru = 0
DO
FOR y = 0 TO 200 STEP 1
FOR x = 0 TO 320 STEP 1
c = POINT(x, y)
c2 = POINT(x - 1, y)
c3 = POINT(x, y - 1)
c4 = POINT(x + 1, y)
c5 = POINT(x, y + 1)

c6 = ((c + c2 + c3 + c4 + c5) / 5)
POKE x + (320 * y), c6
NEXT
NEXT
thru = thru + 1
LOOP UNTIL thru = 2

'DO
thru = thru + 1
FOR y = 0 TO 200 STEP 1
FOR x = 0 TO 320 STEP 1
rrand = INT(RND * 10) + 1
IF rrand > 8 THEN PSET (x, y), 16
NEXT
NEXT
'LOOP UNTIL thru = 1
thru = 0
DO
FOR y = 0 TO 200 STEP 1
FOR x = 0 TO 320 STEP 1
c = POINT(x, y)
c2 = POINT(x - 1, y)
c3 = POINT(x, y - 1)
c4 = POINT(x + 1, y)
c5 = POINT(x, y + 1)

c6 = ((c + c2 + c3 + c4 + c5) / 5)
POKE x + (320 * y), c6
NEXT
NEXT
thru = thru + 1
LOOP UNTIL thru = 2



FOR y = 0 TO 200 STEP 1
FOR x = 0 TO 320 STEP 1
c = POINT(x, y)
IF c < 16 OR c > 31 THEN PSET (x, y), 16
NEXT
NEXT


BSAVE "C:\rpg\stone_1.dis", 0, 65535
SLEEP



