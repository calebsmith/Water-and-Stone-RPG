ON ERROR GOTO 657
REDIM peltcount(11)
REDIM monalive(10)
REDIM blucurs(100)
REDIM bluredo(100)
REDIM bluredo2(100)
REDIM bluredo3(100)
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

nospace = 1
sleeptime = 8000000
kc = 40000
changed = 1

'load spells


oldspellbitv = spellbitv

IF spellbitv >= 16 THEN
        spellbitv = spellbitv - 16
        aquabreath = 1
END IF
IF spellbitv >= 8 THEN
        spellbitv = spellbitv - 8
        curelight = 1
END IF
IF spellbitv >= 4 THEN
        spellbitv = spellbitv - 4
        createwater = 1
END IF
IF spellbitv >= 2 THEN
        spellbitv = spellbitv - 2
        armor = 1
END IF
IF spellbitv >= 1 THEN
        spellbitv = spellbitv - 1
        magicmissle = 1
END IF

spellbitv = oldspellbitv





'load picture of cursor
OPEN "blucurs.dat" FOR INPUT AS #1
FOR d = 1 TO 100
        INPUT #1, blucurs(d)
NEXT
CLOSE


'set up display
CLS
SCREEN 13
BLOAD "back_5.dis"
LINE (9, 9)-(256, 105), 0, BF


OPEN "btn6.dat" FOR INPUT AS #1
        FOR y = 1 TO 16
                FOR x = 1 TO 30
                        INPUT #1, exitc
                        PSET (x + 280, y + 10), exitc
                NEXT
        NEXT
CLOSE
OPEN "btn5.dat" FOR INPUT AS #1
        FOR y = 1 TO 16
                FOR x = 1 TO 30
                        INPUT #1, usec
                        PSET (x + 280, y + 35), usec
                NEXT
        NEXT
CLOSE
OPEN "btn7.dat" FOR INPUT AS #1
        FOR y = 1 TO 16
                FOR x = 1 TO 30
                        INPUT #1, lookc
                        PSET (x + 280, y + 60), lookc
                NEXT
        NEXT
CLOSE
        'load none tile
        OPEN "none.dat" FOR INPUT AS #1


                                 FOR y = 0 TO 9
                                 FOR x = 0 TO 9

                                              INPUT #1, none
                                 PSET (20 * 12 + x, 95 + y), none
                                NEXT
                                NEXT
                        CLOSE



'display spells
        startx = 13
        starty = 11
IF magicmissle = 1 THEN
        OPEN "magmis.dat" FOR INPUT AS #1
                FOR y = 0 TO 9
                FOR x = 0 TO 9
                        INPUT #1, magmisc
                        PSET (startx + x, starty + y), magmisc
                NEXT
                NEXT

        CLOSE
END IF
        
IF armor = 1 THEN
        OPEN "armor.dat" FOR INPUT AS #1

                FOR y = 0 TO 9
                FOR x = 0 TO 9
                        INPUT #1, armorc
                        PSET (startx + x + 12, starty + y), armorc
                NEXT
                NEXT


        CLOSE
END IF
        
IF createwater = 1 THEN
        
        OPEN "creatw.dat" FOR INPUT AS #1

                FOR y = 0 TO 9
                FOR x = 0 TO 9
                        INPUT #1, creatwc
                        PSET (startx + x + 24, starty + y), creatwc
                NEXT
                NEXT

        CLOSE
END IF
        
IF curelight = 1 THEN
        OPEN "curlit.dat" FOR INPUT AS #1

                FOR y = 0 TO 9
                FOR x = 0 TO 9
                        INPUT #1, curlitc
                        PSET (startx + x + 36, starty + y), curlitc
                NEXT
                NEXT

        CLOSE
END IF
        
IF aquabreath = 1 THEN
        OPEN "aqua.dat" FOR INPUT AS #1

                FOR y = 0 TO 9
                FOR x = 0 TO 9
                        INPUT #1, aquac
                        PSET (startx + x + 48, starty + y), aquac
                NEXT
                NEXT

        CLOSE
END IF


IF spellbitv = 0 THEN
LOCATE 2, 2
PRINT "You do not have any"
LOCATE 3, 2
PRINT "magic spells."
END IF


changed = 1
selection = 1

   GET (268, 12)-(278, 22), bluredo
   GET (268, 37)-(278, 47), bluredo2
   GET (268, 62)-(278, 72), bluredo3


DO
'load from keyboard

  IF kl = 1 THEN

  kl = 0
  DEF SEG = 0: k = INP(&H60)
  WHILE LEN(INKEY$): WEND
  SELECT CASE k


    CASE &HB9
    'nothing depressed
    nospace = 0

    CASE &H39
    'space
    IF nospace = 0 THEN

        nospace = 1
        EXIT DO
    END IF
    CASE &H48
    'up

    changed = 1

    selection = selection - 1
    kl = 0
    klf = 0
    CASE &H50
    'down
     kl = 0
     klf = 0
    changed = 1

    selection = selection + 1
END SELECT
END IF


IF kl = 0 THEN klf = klf + 1
IF klf > kc THEN kl = 1


IF selection > 3 THEN
selection = 3
changed = 0
END IF
IF selection < 1 THEN
selection = 1
changed = 0
END IF

IF changed = 1 THEN


        IF selection = 1 THEN yadd = 12
        IF selection = 2 THEN yadd = 37
        IF selection = 3 THEN yadd = 62
                d = 0

                FOR x = 1 TO 10
                FOR y = 1 TO 10
                        d = d + 1
                        IF blucurs(d) <> 16 THEN PSET (x + 268, y + yadd), blucurs(d)
                NEXT
                NEXT
                changed = 0


        IF selection <> 1 THEN
                PUT (268, 12), bluredo, PSET
        END IF
        IF selection <> 2 THEN
                PUT (268, 37), bluredo2, PSET
        END IF
        IF selection <> 3 THEN
                PUT (268, 62), bluredo3, PSET
        END IF


END IF
changed = 0


LOOP
IF selection = 1 THEN
GOTO 490
END IF




'LOOK   and Use
IF selection = 3 OR selection = 2 THEN
selectionitem = 1
changed = 1
'Item selection loop
nospace = 1
DO

nexted = 0
backed = 0
'load from keyboard
  IF kl = 1 THEN
  kl = 0
  DEF SEG = 0: k = INP(&H60)
  WHILE LEN(INKEY$): WEND
  SELECT CASE k
    CASE &HB9
    'nothing depressed
    nospace = 0

    CASE &H39
    'space
    IF nospace = 0 THEN

        nospace = 1
        EXIT DO
    END IF

    CASE &H48
        IF selectionitem > 20 THEN
    'up
        backed = 1
    changed = 1
        selectionitemold = selectionitem
    selectionitem = selectionitem - 20
    kl = 0
    klf = 0
    END IF
    CASE &H50
        IF INKEY$ = " " THEN EXIT DO
        IF selectionitem < 141 THEN

    'down
     kl = 0
     klf = 0
    nexted = 1
    changed = 1
        selectionitemold = selectionitem
    selectionitem = selectionitem + 20
    END IF

    CASE &H4D
         'right
        nexted = 1
    changed = 1
        selectionitemold = selectionitem
    selectionitem = selectionitem + 1
    kl = 0
    klf = 0

    CASE &H4B
    'left
          backed = 1

    changed = 1
        selectionitemold = selectionitem
    selectionitem = selectionitem - 1
        IF selectionitem = 159 THEN
                IF spellbitv >= 1 THEN selectionitem = 1
                IF spellbitv >= 2 THEN selectionitem = 2
                IF spellbitv >= 4 THEN selectionitem = 3
                IF spellbitv >= 8 THEN selectionitem = 4
                IF spellbitv >= 16 THEN selectionitem = 5
        END IF
    kl = 0
    klf = 0
END SELECT
END IF

IF kl = 0 THEN klf = klf + 1
IF klf > kc THEN kl = 1

IF selectionitem < 1 THEN
changed = 0
selectionitem = 1
END IF

IF selectionitem > 160 THEN
selectionitem = 160
changed = 0
END IF

   
IF magicmissle = 0 AND selectionitem = 1 THEN selectionitem = selectionitem + 1
IF armor = 0 AND selectionitem = 2 THEN selectionitem = selectionitem + 1
IF createwater = 0 AND selectionitem = 3 THEN selectionitem = selectionitem + 1
IF curelight = 0 AND selectionitem = 4 THEN selectionitem = selectionitem + 1
IF aquabreath = 0 AND selectionitem = 5 THEN selectionitem = selectionitem + 1

IF selectionitem > 5 THEN selectionitem = 160
'IF selectionitem = 159 THEN selectionitem = 1

IF changed = 1 THEN

        changed = 0
        IF clearneed = 1 THEN LINE (boxx, boxy)-(boxx + 11, boxy + 11), 0, B
        clearneed = 1
        boxx = selectionitem * 12
        boxy = 10
        IF selectionitem > 20 THEN
                boxx = boxx - (20) * 12
                boxy = 22
        END IF
        IF selectionitem > 40 THEN
                boxx = boxx - (20) * 12
                boxy = 34
        END IF
        IF selectionitem > 60 THEN
                boxx = boxx - (20) * 12
                boxy = 46
        END IF
        IF selectionitem > 80 THEN
                boxx = boxx - (20) * 12
                boxy = 58
        END IF
        IF selectionitem > 100 THEN
                boxx = boxx - (20) * 12
                boxy = 70
        END IF
        IF selectionitem > 120 THEN
                boxx = boxx - (20) * 12
                boxy = 82
        END IF
        IF selectionitem > 140 THEN
                boxx = boxx - (20) * 12
                boxy = 94
        END IF

        LINE (boxx, boxy)-(boxx + 11, boxy + 11), 15, B

END IF

LOOP

END IF


'Use
IF selection = 2 THEN
        SELECT CASE selectionitem
                CASE 1

                CASE 2
                        IF armor = 1 THEN

                        IF armoron = 1 THEN
                                LINE (9, 9)-(256, 105), 0, BF
                                LOCATE 3, 3
                                PRINT "You're already under the"
                                LOCATE 4, 3
                                PRINT "affect of this spell."
                                FOR sleepin = 1 TO sleeptime: NEXT
                        END IF
                        IF armoron = 0 THEN

                                LINE (9, 9)-(256, 105), 0, BF
                                expr = expr + 50
                                mp = mp - 1
                                ac = ac - 4
                                armoron = 1

                                LOCATE 3, 3
                                PRINT "You cast an armor spell."
                                        FOR sleepin = 1 TO sleeptime: NEXT

                        END IF

                        END IF

                CASE 3
                       IF createwater = 1 THEN watown = 1
                CASE 4

                       IF curelight = 1 THEN
                                LINE (9, 9)-(256, 105), 0, BF
                                expr = expr + 150
                                mp = mp - 3
                                FOR thru = 1 TO lev
                                        healp = (INT(RND * 6) + 1)
                                        hp = hp + healp

                                NEXT
                                IF hp > mhp THEN hp = mhp

                                LOCATE 3, 3
                                PRINT "You heal "; healp; " hp."
                                FOR sleepin = 1 TO sleeptime: NEXT
                        END IF
                       
                CASE 5
                        IF aquabreath = 1 THEN
                                LINE (9, 9)-(256, 105), 0, BF
                                LOCATE 3, 3
                                PRINT "You can now breath underwater."
                                aqua = 1

                        END IF
        END SELECT
END IF





ERASE blucurs
ERASE bluredo, bluredo2, bluredo3


490




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

CHAIN "main.exe"

657
LOCATE 1, 1
PRINT ERR; ERL
SLEEP 10
STOP
'RESUME NEXT

