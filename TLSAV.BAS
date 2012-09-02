xp = 10
yp = 10
points = xp * yp
DIM c(points)
CLS
SCREEN 13
DEF SEG = &HA000

path$ = ""
tile$ = "tile"
DO
        num = num + 1
'        IF num = 36 THEN num = num + 4
        IF num < 10 THEN num$ = RIGHT$(STR$(num), 1)
        IF num > 9 THEN num$ = RIGHT$(STR$(num), 2)
        opn$ = path$ + tile$ + num$ + ".dat"
'LOCATE 1, 1
'PRINT opn$
        OPEN opn$ FOR INPUT AS #1
                d = 0

                FOR d = 1 TO points
                        INPUT #1, c(d)
                NEXT

                d = 0
                xplus = ((num - 1) * 10)
                
                IF num > 27 THEN
                        xplus = xplus - ((27) * 10)
                        yplus = 10
                END IF
                IF num > 54 THEN
                        xplus = xplus - 27 * 10
                        yplus = 20
               
                END IF
               
                FOR y = 1 + yplus TO yp + yplus
                FOR x = 1 + xplus TO xp + xplus
                        d = d + 1
           
                        
                        
                        POKE x + y * 320, c(d)
                NEXT x
                NEXT y
        CLOSE
LOOP UNTIL num = 70
OPEN "tile300.dat" FOR INPUT AS #1
        
        FOR y = 0 TO 9
        FOR x = 0 TO 9
                INPUT #1, tl300c
                PSET (x, y + 100), tl300c
        NEXT
        NEXT
CLOSE
OPEN "tile301.dat" FOR INPUT AS #1

        FOR y = 0 TO 9
        FOR x = 0 TO 9
                INPUT #1, tl301c
                PSET (x + 10, y + 100), tl301c
        NEXT
        NEXT
CLOSE
OPEN "tile302.dat" FOR INPUT AS #1

        FOR y = 0 TO 9
        FOR x = 0 TO 9
                INPUT #1, tl302c
                PSET (x + 20, y + 100), tl302c
        NEXT
        NEXT
CLOSE

SLEEP
BSAVE "tiledis.dis", 0, 60000
 STOP

