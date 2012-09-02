REDIM peltcount(20)
REDIM monalive(20)
kc = 30000
oldy = 38
y = 38
selection = 1
changed = 1

CLS
SCREEN 13
DEF SEG = &HA000
BLOAD "gmeback2.dis", 0

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


'make menu system appear

LINE (10, 10)-(200, 120), 0, BF
LOCATE 4, 4
PRINT "Which save slot?"

    LOCATE 6, 5
    PRINT "Slot 1:"
    LOCATE 8, 5
    PRINT "Slot 2:"
    LOCATE 10, 5
    PRINT "Slot 3:"
    LOCATE 12, 5
    PRINT "Slot 4:"
    LOCATE 14, 5
    PRINT "Slot 5:"



LINE (20, 38)-(190, 49), 15, B

LINE (20, 54)-(190, 65), 15, B

LINE (20, 70)-(190, 81), 15, B

LINE (20, 86)-(190, 97), 15, B

LINE (20, 102)-(190, 113), 15, B


DIM slot$(5)
OPEN "saves.dat" FOR INPUT AS #1
        FOR d = 1 TO 5

                INPUT #1, slot$(d)
                LOCATE 4 + (d * 2), 13
                PRINT slot$(d)

        NEXT d
CLOSE



selectlimit = 5
DO
'load from keyboard
  oldselection = selection
  IF kl = 1 THEN
        kl = 0
        DEF SEG = 0: k = INP(&H60)
        WHILE LEN(INKEY$): WEND
        kl = 0
        klf = 0

  SELECT CASE k
                CASE &H50: selection = selection + 1 'up
                CASE &H48: selection = selection - 1 'down
                CASE &HB9: nospace = 0  'nothing depressed
                CASE &H39         'space key

                        IF nospace = 0 THEN
                                nospace = 1
                                EXIT DO
                        END IF
  END SELECT
END IF
IF selection <> oldselection THEN changed = 1

IF kl = 0 THEN klf = klf + 1
IF klf > kc THEN kl = 1


IF selection > selectlimit THEN selection = selectlimit
IF selection < 1 THEN selection = 1
IF changed = 1 THEN

        oldy = y
        SELECT CASE selection
                CASE 1: y = 38
                CASE 2: y = 54
                CASE 3: y = 70
                CASE 4: y = 86
                CASE 5: y = 102
        END SELECT
                x = 20
        LINE (x, oldy)-(x + 170, oldy + 11), 31, B
        LINE (x, y)-(x + 170, y + 11), 1, B

END IF
changed = 0
LOOP
numba$ = STR$(selection)

savef$ = "save" + numba$ + ".dat"

battletime = 1
initialload = 1

IF slot$(selection) <> "EMPTY" THEN


    OPEN savef$ FOR INPUT AS #1
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

END IF

battletime = 1
initialload = 1
maploaded = 0


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
        PRINT #1, curtile
        FOR d = 1 TO 11
                PRINT #1, peltcount(d)
        NEXT

        PRINT #1, lev
        FOR d = 1 TO 5
                PRINT #1, monalive(d)
        NEXT
        PRINT #1, aqua
    CLOSE

CHAIN "main.exe"
