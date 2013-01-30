DECLARE SUB tilesetfind (start$, tileset)
DECLARE SUB tilset3 (t(), d, tile65%(), tile63%(), tile69%(), tile9%(), tile70%(), x, y)
DECLARE SUB mapname (start$, map$)
DECLARE SUB mudtiles (t(), d, x, y, tile18%(), tile19%(), tile20%(), tile21%(), tile5%(), tile6%(), tile7%(), tile8%())
DECLARE SUB pathtiles1 (t(), d, x, y, tile40%(), tile41%(), tile42%(), tile43%(), tile44%, tile45%(), tile47%(), tile48%(), tile49%())
DECLARE SUB pathtiles2 (t(), d, x, y, tile40%(), tile52%(), tile53%(), tile54%(), tile55%(), tile56%())
DECLARE SUB tilset3 (t(), d, tile65%(), tile63%(), tile69%(), tile9%(), tile70%(), x, y)
DECLARE SUB tilset5 (t(), d, tile200%(), tile201%(), tile202%(), tile203%(), tile204%(), tile205%(), tile206%(), tile207%(), tile208%(), start$, x, y, sword4)
xp = 10
yp = 10
points = 100



ON ERROR GOTO 999


battletime = 1
initialload = 1

REDIM peltcount(25)
REDIM monalive(16)

OPEN "tmpsave2.dat" FOR INPUT AS #1
INPUT #1, battletime
INPUT #1, start$
INPUT #1, initialload


INPUT #1, monster
INPUT #1, hp
INPUT #1, mhp
INPUT #1, mp
INPUT #1, mmp
INPUT #1, thac0
INPUT #1, ac
INPUT #1, spellbitv
INPUT #1, healpot
INPUT #1, sleeppot
INPUT #1, refreshpot
INPUT #1, expr
INPUT #1, dalive
INPUT #1, attd
INPUT #1, atpl
INPUT #1, salive
INPUT #1, flee
INPUT #1, knife
INPUT #1, armoron
INPUT #1, xpl
INPUT #1, ypl
INPUT #1, xpl3
INPUT #1, ypl3
INPUT #1, weapon$

INPUT #1, wepequip
INPUT #1, coldprot
INPUT #1, rope
INPUT #1, watown
INPUT #1, scalpcount
INPUT #1, recallscroll
INPUT #1, books
INPUT #1, talked2
INPUT #1, talked3
INPUT #1, returned
INPUT #1, reward
INPUT #1, gp
INPUT #1, maploaded
INPUT #1, selftalked1
INPUT #1, greeter
INPUT #1, person
INPUT #1, tow$
INPUT #1, curtil
FOR d = 1 TO 11
INPUT #1, peltcount(d)
NEXT
INPUT #1, lev

                FOR d = 1 TO 5
                        INPUT #1, monalive(d)
                NEXT

INPUT #1, aqua
CLOSE



CLS
SCREEN 13
CALL tilesetfind(start$, tileset)

'background tiles

IF tileset = 0 THEN tileset = 1
IF tileset = 2 THEN

REDIM tile1%(points), tile2%(points), tile3%(points), tile4%(points), tile10%(points)
REDIM tile11%(points), tile12%(points), tile30%(points), tile31%(points), tile32%(points)
REDIM tile33%(points), tile34%(points), tile35%(points), tile36%(points), tile37%(points)
REDIM tile38%(points), tile39%(points), tile40%(points), tile41%(points), tile42%(points)
REDIM tile43%(points), tile44%(points), tile45%(points), tile46%(points), tile47%(points)
REDIM tile48%(points), tile49%(points), tile50%(points), tile51%(points), tile52%(points)
REDIM tile53%(points), tile54%(points), tile55%(points), tile56%(points), tile57%(points)
REDIM tile58%(points), tile59%(points), tile60%(points), tile61%(points), TILE62%(points)


'load tiles from binary file. display and get
xp = 10
yp = 10
points = 100
BLOAD "tiledis.dis"

      yplus = 0
        FOR num = 1 TO 62

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

                SELECT CASE num

                        CASE 1: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile2%
                        CASE 2: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile1%
                        CASE 3: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile3%
                        CASE 4: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile4%
                        CASE 10: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile10%
                        CASE 11: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile11%
                        CASE 12: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile12%
                        CASE 30: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile30%
                        CASE 31: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile31%
                        CASE 32: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile32%
                        CASE 33: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile33%
                        CASE 34: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile34%
                        CASE 35: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile35%
                        CASE 36: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile36%
                        CASE 37: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile37%
                        CASE 38: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile38%
                        CASE 39: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile39%
                        CASE 40: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile40%
                        CASE 41: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile41%
                        CASE 42: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile42%
                        CASE 43: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile43%
                        CASE 44: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile44%
                        CASE 45: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile45%
                        CASE 46: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile46%
                        CASE 47: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile47%
                        CASE 48: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile48%
                        CASE 49: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile49%
                        CASE 50: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile50%
                        CASE 51: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile51%
                        CASE 52: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile52%
                        CASE 53: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile53%
                        CASE 54: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile54%
                        CASE 55: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile55%
                        CASE 56: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile56%
                        CASE 57: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile57%
                        CASE 58: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile58%
                        CASE 59: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile59%
                        CASE 60: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile60%
                        CASE 61: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile61%
                        CASE 62: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), TILE62%

                        END SELECT
        NEXT

END IF

IF tileset = 1 THEN
REDIM tile1%(points), tile2%(points), tile3%(points), tile4%(points), tile5%(points)
REDIM tile6%(points), tile7%(points), tile8%(points), tile9%(points), tile10%(points)
REDIM tile11%(points), tile12%(points), tile13%(points), tile14%(points)
REDIM tile15%(points), tile16%(points), tile17%(points), tile18%(points)
REDIM tile19%(points), tile20%(points), tile21%(points), tile22%(points)
REDIM tile23%(points), TILE24%(points), tile25%(points), tile26%(points)
REDIM tile27%(points), tile28%(points), tile29%(points), tile30%(points)
REDIM tile31%(points), tile32%(points), tile33%(points), tile34%(points)
REDIM tile35%(points), tile300%(points), tile301%(points), tile302%(points)

backthrough2 = 1

helpscramount = 20000

'load tiles from binary file. display and get

BLOAD "tiledis.dis"

yplus = 0
        FOR num = 1 TO 38
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
                SELECT CASE num
                        CASE 1: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile2%
                        CASE 2: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile1%
                        CASE 3: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile3%
                        CASE 4: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile4%
                        CASE 5: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile5%
                        CASE 6: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile6%
                        CASE 7: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile7%
                        CASE 8: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile8%
                        CASE 9: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile9%
                        CASE 10: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile10%
                        CASE 11: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile11%
                        CASE 12: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile12%
                        CASE 13: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile13%
                        CASE 14: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile14%
                        CASE 15: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile15%
                        CASE 16: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile16%
                        CASE 17: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile17%
                        CASE 18: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile18%
                        CASE 19: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile19%
                        CASE 20: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile20%
                        CASE 21: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile21%
                        CASE 22: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile22%
                        CASE 23: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile23%
                        CASE 24: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), TILE24%
                        CASE 25: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile25%
                        CASE 26: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile26%
                        CASE 27: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile27%
                        CASE 28: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile28%
                        CASE 29: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile29%
                        CASE 30: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile30%
                        CASE 31: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile31%
                        CASE 32: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile32%
                        CASE 33: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile33%
                        CASE 34: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile34%
                        CASE 35: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile35%
                        CASE 36: GET (0, 100)-(9, 109), tile300%
                        CASE 37: GET (10, 100)-(19, 109), tile301%
                        CASE 38: GET (20, 100)-(29, 109), tile302%
                END SELECT
        NEXT

END IF
IF tileset = 3 THEN
REDIM tile1%(points), tile2%(points), tile9%(points), tile30%(points)
REDIM TILE62%(points), tile63%(points), tile64%(points)
REDIM tile65%(points), tile66%(points), tile70%(points)
REDIM tile67%(points), tile68%(points), tile69%(points)
'load tiles from binary file. display and get
BLOAD "tiledis.dis"

      yplus = 0
        FOR num = 1 TO 70

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
                SELECT CASE num
                        CASE 1: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile2%
                        CASE 2: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile1%
                        CASE 9: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile9%
                        CASE 30: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile30%
                        CASE 62: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), TILE62%
                        CASE 63: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile63%
                        CASE 64: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile64%
                        CASE 65: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile65%
                        CASE 66: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile66%
                        CASE 67: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile67%
                        CASE 68: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile68%
                        CASE 69: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile69%
                        CASE 70: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile70%
                        END SELECT
        NEXT

END IF


IF tileset = 5 THEN
REDIM tile200%(points), tile201%(points)
REDIM tile202%(points), tile203%(points)
REDIM tile204%(points), tile205%(points)
REDIM tile206%(points), tile207%(points)
REDIM tile208%(points), tile209%(points)
REDIM tile210%(points), tile211%(points)
REDIM tile212%(points), tile213%(points)
REDIM tile214%(points)
'bed
REDIM tile215%(points), tile216%(points)
REDIM tile217%(points), tile218%(points)
REDIM tile219%(points), tile220%(points)

'load tiles from binary file. display and get
BLOAD "tiledis2.dis"

      yplus = 0
        FOR num = 1 TO 21

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
                SELECT CASE num
                        CASE 1: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile200%
                        CASE 2: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile201%
                        CASE 3: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile202%
                        CASE 4: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile203%
                        CASE 5: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile204%
                        CASE 6: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile205%
                        CASE 7: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile206%
                        CASE 8: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile207%
                        CASE 9: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile208%
                        CASE 10: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile209%
                        CASE 11: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile210%
                        CASE 12: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile211%
                        CASE 13: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile212%
                        CASE 14: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile213%
                        CASE 15: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile214%
                        CASE 16: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile215%
                        CASE 17: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile216%
                        CASE 18: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile217%
                        CASE 19: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile218%
                        CASE 20: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile219%
                        CASE 21: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile220%
                        END SELECT
        NEXT

END IF
IF tileset = 6 THEN 'underground
REDIM tile400%(points), tile401%(points)
REDIM tile402%(points), tile403%(points)
REDIM tile404%(points)

'load tiles from binary file. display and get
BLOAD "tiledis3.dis"

      yplus = 0
        FOR num = 1 TO 5

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
                SELECT CASE num
                        CASE 1: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile400%
                        CASE 2: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile401%
                        CASE 3: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile402%
                        END SELECT
        NEXT

END IF

IF tileset = 4 THEN          'mountains
REDIM tile500%(points), tile501%(points)
REDIM tile502%(points), tile503%(points)
REDIM tile504%(points), tile505%(points)
REDIM tile506%(points), tile507%(points)

'load tiles from binary file. display and get
BLOAD "tiledis4.dis"

      yplus = 0
        FOR num = 1 TO 8

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
                SELECT CASE num
                        CASE 1: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile500%
                        CASE 2: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile501%
                        CASE 3: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile502%
                        CASE 4: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile503%
                        CASE 5: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile504%
                        CASE 6: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile505%
                        CASE 7: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile506%
                        CASE 8: GET (xplus + 1, yplus + 1)-(xp + xplus, yp + yplus), tile507%
                        END SELECT
        NEXT

END IF

'prepare screen
CLS : SCREEN 13: DEF SEG = &HA000
'display stone background
BLOAD "back_11.dis", 0


d = 0

CALL mapname(start$, map$)

OPEN map$ FOR INPUT AS #1

INPUT #1, mx
INPUT #1, my
1

IF through = 0 THEN
        REDIM t(mx * my + 29)
END IF
through = 1
d = 0

DO
        d = d + 1
        INPUT #1, t(d)
        IF t(d) = 14 AND start$ = "House3" AND reward = 0 THEN t(d) = 1
LOOP UNTIL (EOF(1))

'NEXT

CLOSE
d = 25

FOR y = 10 TO 150 STEP 10
FOR x = 10 TO 250 STEP 10
d = d + 1


2
IF t(d) = 2 AND tileset = 1 OR t(d) = 2 AND tileset = 2 THEN PUT (x, y), tile2%, PSET
IF t(d) = 1 AND tileset = 1 THEN PUT (x, y), tile1%, PSET

IF t(d) = 1 AND tileset = 2 THEN
        grassrnd = INT(RND * 5) + 1
        SELECT CASE grassrnd
                CASE 1
                        PUT (x, y), tile1%, PSET
                CASE 2
                        PUT (x, y), tile36%, PSET
                CASE 3
                        PUT (x, y), tile37%, PSET
                CASE 4
                        PUT (x, y), tile38%, PSET
                CASE 5
                        PUT (x, y), tile39%, PSET
                'CASE IS < 1 OR grassrnd > 5
                '        PUT (x, Y), tile2%, PSET
END SELECT


END IF
IF t(d) = 3 AND tileset = 1 THEN PUT (x, y), tile3%, PSET
IF t(d) = 3 AND tileset = 2 THEN
        treerand = INT(RND * 10) + 1
        IF treerand < 7 THEN PUT (x, y), tile58%, PSET
        IF treerand < 8 AND treerand > 6 THEN PUT (x, y), tile57%, PSET
        IF treerand = 8 OR treerand = 9 THEN PUT (x, y), tile3%, PSET
        IF treerand = 10 THEN PUT (x, y), tile59%, PSET
END IF

IF t(d) = 16 THEN PUT (x, y), TILE62%, PSET

IF t(d) = 4 AND tileset = 1 THEN PUT (x, y), tile9%, PSET
IF t(d) = 4 AND tileset = 2 THEN
        

        'dead end up
        IF t(d + 25) = 4 AND t(d - 1) <> 4 AND t(d + 1) <> 4 AND t(d - 25) <> 4 THEN PUT (x, y), tile40%, PSET
        'dead end down
        IF t(d - 25) = 4 AND t(d - 1) <> 4 AND t(d + 1) <> 4 AND t(d + 25) <> 4 THEN PUT (x, y), tile41%, PSET
        'dead end left
        IF t(d + 1) = 4 AND t(d - 1) <> 4 AND t(d + 25) <> 4 AND t(d - 25) <> 4 THEN PUT (x, y), tile42%, PSET
        'dead end right
        IF t(d - 1) = 4 AND t(d + 1) <> 4 AND t(d + 25) <> 4 AND t(d - 25) <> 4 THEN PUT (x, y), tile43%, PSET
        'vertical path
        IF t(d - 25) = 4 AND t(d + 25) = 4 AND t(d - 1) <> 4 AND t(d + 1) <> 4 THEN PUT (x, y), tile44%, PSET
        'horizontal path
        IF t(d - 1) = 4 AND t(d + 1) = 4 AND t(d - 25) <> 4 AND t(d + 25) <> 4 THEN PUT (x, y), tile45%, PSET
        'T junction |-
        IF t(d + 1) = 4 AND t(d + 25) = 4 AND t(d - 25) = 4 AND t(d - 1) <> 4 THEN PUT (x, y), tile47%, PSET
        'T junction _|_
        IF t(d - 1) = 4 AND t(d - 25) = 4 AND t(d - 25) = 4 AND t(d + 25) <> 4 THEN PUT (x, y), tile48%, PSET
        'T junction  -|
        IF t(d - 1) = 4 AND t(d + 25) = 4 AND t(d - 25) = 4 AND t(d + 1) <> 4 THEN PUT (x, y), tile49%, PSET

        'all by itself path
        IF t(d + 1) <> 4 AND t(d - 1) <> 4 AND t(d + 25) <> 4 AND t(d - 25) <> 4 THEN PUT (x, y), tile56%, PSET
        'crossroads
        IF t(d + 1) = 4 AND t(d - 1) = 4 AND t(d + 25) = 4 AND t(d - 25) = 4 THEN PUT (x, y), tile55%, PSET
        'T junction   ~|~
        IF t(d - 1) = 4 AND t(d + 25) = 4 AND t(d + 1) = 4 AND t(d - 25) <> 4 THEN PUT (x, y), tile50%, PSET
        'curve left to down
        IF t(d - 1) = 4 AND t(d + 25) = 4 AND t(d - 25) <> 4 AND t(d + 1) <> 4 THEN PUT (x, y), tile51%, PSET
        'curve from down to right
        IF t(d + 1) = 4 AND t(d + 25) = 4 AND t(d - 25) <> 4 AND t(d - 1) <> 4 THEN PUT (x, y), tile52%, PSET
        'curve from up to right
        IF t(d + 1) = 4 AND t(d - 25) = 4 AND t(d + 25) <> 4 AND t(d - 1) <> 4 THEN PUT (x, y), tile53%, PSET
        'curve from up to left
        IF t(d - 1) = 4 AND t(d - 25) = 4 AND t(d + 25) <> 4 AND t(d + 1) <> 4 THEN PUT (x, y), tile54%, PSET
        

END IF


IF t(d) = 5 AND tileset = 1 THEN PUT (x, y), tile10%, PSET
IF t(d) = 5 AND tileset = 2 THEN
brickrand = INT(RND * 10) + 1
IF brickrand < 7 THEN PUT (x, y), tile10%, PSET
IF brickrand = 7 THEN PUT (x, y), tile60%, PSET
IF brickrand > 7 THEN PUT (x, y), tile61%, PSET
END IF

IF tileset = 1 OR tileset = 2 THEN
IF t(d) = 6 THEN PUT (x, y), tile11%, PSET
IF t(d) = 7 THEN PUT (x, y), tile25%, PSET
IF t(d) = 9 THEN PUT (x, y), tile16%, PSET
IF t(d) = 11 THEN PUT (x, y), tile28%, PSET
IF t(d) = 12 AND tileset = 2 THEN PUT (x, y), tile30%, PSET
IF t(d) = 12 AND tileset = 1 THEN
        IF t(d - 1) = 12 AND t(d + 1) = 2 THEN PUT (x, y), tile300%, PSET
        IF t(d - 1) <> 12 AND t(d + 1) = 12 THEN PUT (x, y), tile301%, PSET
        IF t(d - 1) = 12 AND t(d + 1) = 12 THEN PUT (x, y), tile301%, PSET
END IF

IF t(d) = 13 THEN PUT (x, y), tile31%, PSET
IF t(d) = 15 THEN PUT (x, y), tile35%, PSET
IF t(d) = 17 THEN PUT (x, y), tile302%, PSET

IF t(d) = 14 AND t(d + 1) = 14 THEN PUT (x, y), tile33%, PSET
IF t(d) = 14 AND t(d - 1) = 14 THEN PUT (x, y), tile34%, PSET

IF t(d) = 10 AND t(d + 1) <> 2 THEN PUT (x, y), tile27%, PSET
IF t(d) = 10 AND t(d + 1) = 2 THEN PUT (x, y), tile29%, PSET


IF t(d) = 8 AND t(d + 1) = 8 AND t(d + 25) = 8 THEN PUT (x, y), tile12%, PSET
IF t(d) = 8 AND t(d - 1) = 8 AND t(d + 25) = 8 THEN PUT (x, y), tile13%, PSET
IF t(d) = 8 AND t(d + 1) = 8 AND t(d - 25) = 8 THEN PUT (x, y), tile14%, PSET
IF t(d) = 8 AND t(d - 1) = 8 AND t(d - 25) = 8 THEN PUT (x, y), tile15%, PSET
END IF
'undeground tileset

IF tileset = 3 THEN CALL tilset3(t(), d, tile65%(), tile63%(), tile69%(), tile9%(), tile70%(), x, y)

'inside house tileset
IF tileset = 5 THEN
        CALL tilset5(t(), d, tile200%(), tile201%(), tile202%(), tile203%(), tile204%(), tile205%(), tile206%(), tile207%(), tile208%(), start$, x, y, sword4)
        'blood spot in home
        IF t(d - 1) = 13 AND t(d) = 13 THEN PUT (x, y), tile213%, PSET
        IF t(d + 1) = 13 AND t(d) = 13 THEN PUT (x, y), tile214%, PSET
        'bedside table w/o candle
        IF t(d) = 10 THEN PUT (x, y), tile210%, PSET
        'bedside table with candle
        IF t(d) = 9 THEN PUT (x, y), tile209%, PSET
        'big table
        IF t(d) = 11 AND t(d + 1) = 11 THEN PUT (x, y), tile211%, PSET
        IF t(d) = 11 AND t(d - 1) = 11 THEN PUT (x, y), tile212%, PSET
        'bed

        IF t(d) = 8 AND t(d + 1) = 8 AND t(d + 25) = 8 AND t(d - 25) <> 8 THEN PUT (x, y), tile215%, PSET
        IF t(d) = 8 AND t(d - 1) = 8 AND t(d + 25) = 8 AND t(d - 25) <> 8 THEN PUT (x, y), tile216%, PSET
        IF t(d) = 8 AND t(d + 1) = 8 AND t(d + 25) = 8 AND t(d - 25) = 8 THEN PUT (x, y), tile217%, PSET
        IF t(d) = 8 AND t(d - 1) = 8 AND t(d + 25) = 8 AND t(d - 25) = 8 THEN PUT (x, y), tile218%, PSET
        IF t(d) = 8 AND t(d + 1) = 8 AND t(d - 25) = 8 AND t(d + 25) <> 8 THEN PUT (x, y), tile219%, PSET
        IF t(d) = 8 AND t(d - 1) = 8 AND t(d - 25) = 8 AND t(d + 25) <> 8 THEN PUT (x, y), tile220%, PSET
        
        IF t(d) = 14 THEN 'people in houses
                PUT (x, y), tile200%, PSET  'floor background 'floor
                IF LEFT$(start$, 5) = "Elder" THEN charfil$ = "char6.dat" 'elder
                IF start$ = "House4" THEN charfil$ = "char8.dat"    'fisherman
                IF start$ = "House2" THEN charfil$ = "char9.dat"    'balam's widow
                IF start$ = "House3" THEN charfil$ = "char2.dat"    'guy you helped
                
                        'make elder
                        OPEN charfil$ FOR INPUT AS #1
                                FOR ye = 0 TO 9
                                FOR xe = 0 TO 9
                                        INPUT #1, charc
                                        IF charc <> 16 AND charc <> 254 THEN PSET (xe + x, ye + y), charc
                                NEXT
                                NEXT
                        CLOSE
                
        END IF
END IF

'underwater
IF tileset = 6 THEN
        IF t(d) = 1 THEN PUT (x, y), tile400%, PSET
        IF t(d) = 2 THEN PUT (x, y), tile401%, PSET
        IF t(d) = 3 THEN PUT (x, y), tile402%, PSET
END IF
'mountains
IF tileset = 4 THEN
        'snow
        IF t(d) = 1 THEN
         PUT (x, y), tile500%, PSET
    '    snw = (RND * 3) + 1
     '           IF snw = 1 THEN PUT (x, y), tile500%, PSET
      '          IF snw = 2 THEN PUT (x, y), tile501%, PSET
       '         IF snw = 3 THEN PUT (x, y), tile502%, PSET
        END IF
        'pine trees
        IF t(d) = 3 THEN PUT (x, y), tile503%, PSET
       
        'footprints
        IF t(d) = 4 THEN PUT (x, y), tile504%, PSET
        IF t(d) = 5 THEN PUT (x, y), tile505%, PSET
        IF t(d) = 6 THEN PUT (x, y), tile506%, PSET
        IF t(d) = 7 THEN PUT (x, y), tile507%, PSET

END IF




5
'muddy edge tiles


IF LEFT$(start$, 6) <> "Forest" THEN
IF tileset = 1 OR tileset = 2 THEN
xp = 10
yp = 10

IF t(d) = 1 AND t(d - 26) = 2 AND d > 26 AND x > 10 THEN PUT (x, y), tile18%, PSET
IF t(d) = 1 AND t(d + 24) = 2 AND x > 10 THEN PUT (x, y), tile19%, PSET
IF t(d) = 1 AND t(d + 26) = 2 AND x < 250 THEN PUT (x, y), tile20%, PSET
IF t(d) = 1 AND t(d - 24) = 2 AND x < 250 THEN PUT (x, y), tile21%, PSET
IF t(d + 1) = 2 AND t(d) = 1 AND x < xp * 25 THEN PUT (x, y), tile5%, OR
IF t(d - 1) = 2 AND t(d) = 1 AND x > 10 THEN PUT (x, y), tile6%, OR
IF t(d + 25) = 2 AND t(d) = 1 THEN PUT (x, y), tile7%, OR
IF t(d - 25) = 2 AND t(d) = 1 AND y > 0 AND d > 25 THEN PUT (x, y), tile8%, OR

END IF
END IF

IF tileset = 1 AND t(d - 1) = 7 AND t(d) = 1 THEN PUT (x, y), tile26%, OR



NEXT
NEXT



IF tileset = 1 THEN

ERASE tile1%, tile2%, tile3%, tile4%, tile5%, tile6%, tile7%, tile8%, tile9%
ERASE tile10%, tile11%, tile12%, tile13%, tile14%, tile15%, tile16%, tile17%
ERASE tile18%, tile19%, tile20%, tile21%, tile22%, tile23%, TILE24%, tile25%
ERASE tile26%, tile27%, tile28%, tile29%, tile30%, tile31%, tile32%, tile33%
ERASE tile34%, tile35%, tile300%, tile301%, tile302%
END IF
IF tileset = 2 THEN
ERASE tile1%, tile2%, tile3%, tile4%, tile5%, tile10%, tile11%, tile12%, tile30%
ERASE tile31%, tile32%, tile33%, tile34%, tile35%, tile36%, tile37%, tile38%, tile39%
ERASE tile40%, tile41%, tile42%, tile43%, tile44%
ERASE tile45%, tile46%, tile47%, tile48%, tile49%, tile50%, tile51%, tile52%, tile53%, tile54%
ERASE tile55%, tile56%, tile57%, tile58%, tile59%, tile60%, tile61%, TILE62%

END IF
IF tileset = 3 THEN
ERASE tile1%, tile2%, tile9%, tile30%
ERASE TILE62%, tile63%, tile64%
ERASE tile65%, tile66%, tile70%
ERASE tile67%, tile68%, tile69%

END IF
IF tileset = 4 THEN
ERASE tile500%, tile501%
ERASE tile502%, tile503%
ERASE tile504%, tile505%
ERASE tile506%, tile507%
END IF

IF tileset = 5 THEN
ERASE tile200%, tile201%, tile202%, tile203%, tile204%
ERASE tile205%, tile206%, tile207%, tile208%, tile209%
ERASE tile210%, tile211%, tile212%, tile213%, tile214%
END IF
IF tileset = 6 THEN
ERASE tile400%, tile401%
ERASE tile402%, tile403%
ERASE tile404%
END IF




battletime = 1
initialload = 1

OPEN "tempsave.dat" FOR OUTPUT AS #1
PRINT #1, battletime
PRINT #1, start$
PRINT #1, initialload
 PRINT #1, monster
PRINT #1, hp
PRINT #1, mhp
PRINT #1, mp
PRINT #1, mmp
PRINT #1, thac0
PRINT #1, ac
PRINT #1, spellbitv
PRINT #1, healpot
PRINT #1, sleeppot
PRINT #1, refreshpot
PRINT #1, expr
PRINT #1, dalive
PRINT #1, attd
PRINT #1, atpl
PRINT #1, salive
PRINT #1, flee
PRINT #1, knife
PRINT #1, armoron
PRINT #1, xpl
PRINT #1, ypl
PRINT #1, xpl3
PRINT #1, ypl3
PRINT #1, weapon$

PRINT #1, wepequip
PRINT #1, coldprot
PRINT #1, rope
PRINT #1, watown
PRINT #1, scalpcount
PRINT #1, recallscroll
PRINT #1, books
PRINT #1, talked2
PRINT #1, talked3
PRINT #1, returned
PRINT #1, reward
PRINT #1, gp
PRINT #1, maploaded
PRINT #1, selftalked1
PRINT #1, greeter
PRINT #1, person
PRINT #1, tow$
PRINT #1, curtil
FOR d = 1 TO 11
PRINT #1, peltcount(d)
NEXT
PRINT #1, lev

                FOR d = 1 TO 5
                        PRINT #1, monalive(d)
                NEXT


PRINT #1, aqua
CLOSE


BSAVE "gameback.dis", 0, 62000
CHAIN "main.exe"
999
'CLS
'SCREEN 12
PRINT "In rpgtile.exe"
PRINT "ERROR:"
PRINT ERR
PRINT "on line:"
PRINT ERL
PRINT "Exiting...."
SLEEP 10
'RESUME NEXT

SUB mapname (start$, map$)
map$ = start$ + ".dat"
IF start$ = "Home" THEN map$ = "home1.dat"
END SUB

SUB mudtiles (t(), d, x, y, tile18%(), tile19%(), tile20%(), tile21%(), tile5%(), tile6%(), tile7%(), tile8%())
END SUB

SUB pathtiles1 (t(), d, x, y, tile40%(), tile41%(), tile42%(), tile43%(), tile44%, tile45%(), tile47%(), tile48%(), tile49%())
END SUB

SUB pathtiles2 (t(), d, x, y, tile40%(), tile52%(), tile53%(), tile54%(), tile55%(), tile56%())
END SUB

SUB tilesetfind (start$, tileset)
IF start$ <> "Island" THEN tileset = 2
IF start$ = "Island" THEN tileset = 1
IF start$ = "Island7" THEN tileset = 1
IF start$ = "Island8" THEN tileset = 1
IF start$ = "Elftree1" THEN tileset = 3
IF start$ = "Elftree2" THEN tileset = 3
IF start$ = "Elftree3" THEN tileset = 3
IF start$ = "Elftree4" THEN tileset = 3
IF start$ = "Elftree5" THEN tileset = 3
IF start$ = "Elder" THEN tileset = 5
IF start$ = "Elder2" THEN tileset = 5
IF start$ = "Elder3" THEN tileset = 5
IF start$ = "Home" THEN tileset = 5
IF start$ = "House1" THEN tileset = 5
IF start$ = "House2" THEN tileset = 5
IF start$ = "House3" THEN tileset = 5
IF start$ = "House4" THEN tileset = 5
IF start$ = "House5" THEN tileset = 5
IF start$ = "House6" THEN tileset = 5
IF start$ = "House7" THEN tileset = 5
IF start$ = "Water1" THEN tileset = 6
IF start$ = "Water2" THEN tileset = 6
IF start$ = "Water3" THEN tileset = 6
IF start$ = "Mtn1" THEN tileset = 4
IF start$ = "Mtn2" THEN tileset = 4
IF start$ = "Mtn3" THEN tileset = 4
IF start$ = "Mtn4" THEN tileset = 4
IF start$ = "Mtn5" THEN tileset = 4
IF start$ = "Mtn6" THEN tileset = 4
IF start$ = "Mtn7" THEN tileset = 4
IF start$ = "Mtn8" THEN tileset = 4
IF start$ = "Mtn9" THEN tileset = 4
IF start$ = "Mtn10" THEN tileset = 4
END SUB

SUB tilset3 (t(), d, tile65%(), tile63%(), tile69%(), tile9%(), tile70%(), x, y)
        IF t(d) = 17 THEN PUT (x, y), tile65%, PSET
        IF t(d) = 18 THEN PUT (x, y), tile63%, PSET
        IF t(d) = 19 THEN PUT (x, y), tile69%, PSET
        IF t(d) = 20 THEN PUT (x, y), tile9%, PSET
        IF t(d) = 62 THEN PUT (x, y), tile70%, PSET

END SUB

SUB tilset5 (t(), d, tile200%(), tile201%(), tile202%(), tile203%(), tile204%(), tile205%(), tile206%(), tile207%(), tile208%(), start$, x, y, sword4)
        'hardwood floor
        IF t(d) = 1 THEN PUT (x, y), tile200%, PSET
        'red entrance rug
        IF t(d) = 4 THEN PUT (x, y), tile201%, PSET
        'brick wall
        IF t(d) = 5 THEN PUT (x, y), tile202%, PSET
        'doors to  houses
        IF t(d) = 5 AND start$ <> "Elder3" AND x = 130 AND y = 140 THEN PUT (x, y), tile206%, PSET
        IF t(d) = 5 AND start$ = "Elder3" AND x = 50 AND y = 140 THEN PUT (x, y), tile206%, PSET

        'bookshelves
        IF t(d) = 3 THEN
                randbook = INT(RND * 3) + 1
                IF randbook = 2 THEN PUT (x, y), tile203%, PSET
                IF randbook <> 2 THEN PUT (x, y), tile204%, PSET
        END IF
        IF start$ = "Elder2" AND t(d) = 5 AND x = 50 AND y = 30 THEN
                PUT (x, y), tile205%, PSET
        END IF
        'chests
        IF t(d) = 2 THEN
                IF sword4 = 0 AND start$ = "Elder3" THEN PUT (x, y), tile207%, PSET
                IF sword4 <> 0 AND start$ = "Elder3" THEN PUT (x, y), tile208%, PSET
                IF start$ = "Home" THEN PUT (x, y), tile207%, PSET
        END IF
END SUB

