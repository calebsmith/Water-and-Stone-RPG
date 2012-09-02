xp = 10
yp = 10
points = xp * yp
DIM c(points)
CLS
SCREEN 13
DEF SEG = &HA000

path$ = ""
tile$ = "tile"
num = 499
DO
        num = num + 1

        IF num < 10 THEN num$ = RIGHT$(STR$(num), 1)
        IF num > 9 AND num < 100 THEN num$ = RIGHT$(STR$(num), 2)
        IF num > 99 THEN num$ = RIGHT$(STR$(num), 3)
        opn$ = path$ + tile$ + num$ + ".dat"
        OPEN opn$ FOR INPUT AS #1
                d = 0

                FOR d = 1 TO points
                        INPUT #1, c(d)
                NEXT

                d = 0
                xplus = ((num - 500) * 10)
                
               
                FOR y = 1 + yplus TO yp + yplus
                FOR x = 1 + xplus TO xp + xplus
                        d = d + 1
                        POKE x + y * 320, c(d)
                NEXT x
                NEXT y
        CLOSE
LOOP UNTIL num > 506
SLEEP
BSAVE "tiledis4.dis", 0, 12000
STOP

