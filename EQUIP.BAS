REDIM healc(100)
REDIM sleepc(100)
REDIM refreshc(100)
REDIM recallc(100)
REDIM furc(100)
REDIM blucurs(100)
REDIM bluredo(100)
REDIM bluredo2(100)
REDIM bluredo3(100)
REDIM item(200)
REDIM scalpc(200)
REDIM sword1c(100)
REDIM sword2c(100)
REDIM sword3c(100)
REDIM sword4c(100)
REDIM staff1c(100)
REDIM dagger1c(100)
REDIM knifec(100)
REDIM ropec(100)
REDIM peltcount(15)

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
recalled = 0
clearneed = 0
kc = 40000
'get variables right


IF healpot > 5 THEN healpot = 5
IF sleeppot > 5 THEN sleeppot = 5
IF refreshpot > 5 THEN refreshpot = 5




'only have 5 pelts of each animal
FOR chck = 1 TO 11
        IF peltcount(chck) > 5 THEN peltcount(chck) = 5
 NEXT
    FOR d = 1 TO 11
        IF peltcount(d) > 0 THEN
                monster$ = "wild"
                path$ = ""
                ext$ = ".dat"
                filename$ = monster$ + ext$
                OPEN filename$ FOR INPUT AS #1    ' load monster
                        monster = d

                                DO
                                        INPUT #1, reading$
                                        wildcritter = monster
                                        IF wildcritter < 10 THEN numba$ = RIGHT$(reading$, 1)
                                        IF wildcritter > 9 THEN numba$ = RIGHT$(reading$, 2)
                                        number = VAL(numba$)
                                       IF number = wildcritter AND LEFT$(reading$, 6) = "animal" THEN
                                                EXIT DO
                                        END IF
                                LOOP

                        INPUT #1, critter$      ' name of monster
                        INPUT #1, furtype$      ' type of fur (pelt, fur, skin, or none, etc.)
        END IF

CLOSE
        NEXT



'figure out what weapons you have
oldwepquip = wepequip
IF wepequip >= 32 THEN
        sword4 = 1
        wepequip = wepequip - 32
END IF
IF wepequip >= 16 THEN
        wepequip = wepequip - 16
        dagger1 = 1
END IF
IF wepequip >= 8 THEN
        wepequip = wepequip - 8
        staff1 = 1
END IF
IF wepequip >= 4 THEN
        wepequip = wepequip - 4
        sword3 = 1
END IF
IF wepequip >= 2 THEN
        wepequip = wepequip - 2
        sword2 = 1
END IF
IF wepequip >= 1 THEN
        wepequip = wepequip - 1
        sword1 = 1
END IF

wepequip = oldwepquip






'load picture of cursor
OPEN "blucurs.dat" FOR INPUT AS #1
FOR d = 1 TO 100
        INPUT #1, blucurs(d)
NEXT
CLOSE
'load pictures of items
IF healpot > 0 THEN
        OPEN "heal.dat" FOR INPUT AS #1

                FOR d = 1 TO 100
                        INPUT #1, healc(d)
                NEXT
        CLOSE
END IF
IF sleeppot > 0 THEN
        OPEN "sleep.dat" FOR INPUT AS #1

                FOR d = 1 TO 100
                        INPUT #1, sleepc(d)
                NEXT
        CLOSE
END IF
IF refreshpot > 0 THEN
        OPEN "refresh.dat" FOR INPUT AS #1

                FOR d = 1 TO 100
                        INPUT #1, refreshc(d)
                NEXT
        CLOSE
END IF

IF recallscroll > 0 THEN
        OPEN "recall.dat" FOR INPUT AS #1

            FOR d = 1 TO 100

                INPUT #1, recallc(d)


            NEXT

        CLOSE
END IF
loadpelt = 0
FOR d = 1 TO 11
        IF peltcount(d) > 0 THEN loadpelt = 1
NEXT
IF loadpelt = 1 THEN
        OPEN "fur.dat" FOR INPUT AS #1

            FOR d = 1 TO 100

                INPUT #1, furc(d)


            NEXT

        CLOSE

END IF
IF scalpcount > 0 THEN
        OPEN "scalp.dat" FOR INPUT AS #1

                FOR d = 1 TO 100
                        INPUT #1, scalpc(d)
                NEXT
        CLOSE

END IF
IF sword1 = 1 THEN
        OPEN "sword1.dat" FOR INPUT AS #1

                FOR d = 1 TO 100
                        INPUT #1, sword1c(d)
                NEXT
        CLOSE
END IF

IF sword2 = 1 THEN
        OPEN "sword2.dat" FOR INPUT AS #1

                FOR d = 1 TO 100
                        INPUT #1, sword2c(d)
                NEXT
        CLOSE
END IF
IF sword4 = 1 THEN
        OPEN "sword5.dat" FOR INPUT AS #1

                FOR d = 1 TO 100
                        INPUT #1, sword4c(d)
                NEXT
        CLOSE
END IF

IF sword3 = 1 THEN
        OPEN "sword3.dat" FOR INPUT AS #1

                FOR d = 1 TO 100
                        INPUT #1, sword3c(d)
                NEXT
        CLOSE
END IF

IF staff1 = 1 THEN
        OPEN "staff1.dat" FOR INPUT AS #1

                FOR d = 1 TO 100
                        INPUT #1, staff1c(d)
                NEXT
        CLOSE
END IF
IF dagger1 = 1 THEN
        OPEN "dagger1.dat" FOR INPUT AS #1

                FOR d = 1 TO 100
                        INPUT #1, dagger1c(d)
                NEXT
        CLOSE
END IF
IF knife = 1 THEN
        OPEN "knife1.dat" FOR INPUT AS #1

                FOR d = 1 TO 100
                        INPUT #1, knifec(d)
                NEXT
        CLOSE

END IF
IF rope = 1 THEN
        OPEN "rope.dat" FOR INPUT AS #1

                FOR d = 1 TO 100
                        INPUT #1, ropec(d)
                NEXT
        CLOSE

END IF





'create item list with item(d)

d = 0
FOR d = 1 TO healpot
        item(d) = 1
NEXT
itemsofar = healpot
FOR d = 1 + itemsofar TO 1 + itemsofar + sleeppot
        item(d) = 2
NEXT
itemsofar = itemsofar + sleeppot
FOR d = 1 + itemsofar TO 1 + itemsofar + recallscroll
        item(d) = 3
NEXT
itemsofar = itemsofar + recallscroll
FOR d = 1 + itemsofar TO 1 + itemsofar + refreshpot
        item(d) = 4
NEXT
itemsofar = itemsofar + refreshpot

adder = 0

FOR d2 = 1 + itemsofar TO 1 + itemsofar + 11
        d = d2 - 1 - itemsofar
        oldadder = adder
        IF peltcount(d) > 0 AND d > 0 THEN adder = adder + peltcount(d)

                plac = oldadder + itemsofar
        IF peltcount(d) > 0 AND d > 0 THEN
        FOR d3 = 1 TO adder
                item(plac + d3) = d + 4
        NEXT
        END IF

NEXT
itemsofar = itemsofar + adder

FOR d = 1 + itemsofar TO 1 + itemsofar + scalpcount
        item(d) = 20
NEXT
itemsofar = itemsofar + scalpcount

'check for accidental bleed over of item array values past itemsofar value
FOR cler = 1 TO 160
IF cler > itemsofar THEN item(cler) = 0
NEXT
IF sword1 = 1 THEN

        d = itemsofar + 1
        item(d) = 31
        itemsofar = itemsofar + 1
END IF
IF sword2 = 1 THEN

        d = itemsofar + 1
        item(d) = 32
        itemsofar = itemsofar + 1
END IF
IF sword3 = 1 THEN
        d = itemsofar + 1
        item(d) = 33
        itemsofar = itemsofar + 1
END IF

IF staff1 = 1 THEN
        d = itemsofar + 1
        item(d) = 34
        itemsofar = itemsofar + 1
END IF
IF dagger1 = 1 THEN
        d = itemsofar + 1
        item(d) = 35
        itemsofar = itemsofar + 1
END IF
IF knife = 1 THEN
        d = itemsofar + 1
        item(d) = 36
        itemsofar = itemsofar + 1
END IF
IF rope = 1 THEN
        d = itemsofar + 1
        item(d) = 37
        itemsofar = itemsofar + 1
END IF
IF sword4 = 1 THEN
        d = itemsofar + 1
        item(d) = 38
        itemsofar = itemsofar + 1
END IF




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



'FOR d = 1 TO 11
 '       LOCATE 3 + d, 5
  '      PRINT peltcount(d)
   '            NEXT

'display items
IF itemsofar > 159 THEN itemsofar = 159
FOR disp = 1 TO itemsofar
        d = 0
        FOR y = 1 TO 10
                FOR x = 1 TO 10
                        disx = x + disp * 12
                        disy = y + 10
                        IF disp > 20 THEN
                                disx = disx - 20 * 12
                                disy = disy + 12
                        END IF
                        IF disp > 40 THEN
                                disx = disx - 20 * 12
                                disy = disy + 12
                        END IF
                        IF disp > 60 THEN
                                disx = disx - 20 * 12
                                disy = disy + 12
                        END IF
                        IF disp > 80 THEN
                                disx = disx - 20 * 12
                                disy = disy + 12
                        END IF
                        IF disp > 100 THEN
                                disx = disx - 20 * 12
                                disy = disy + 12
                        END IF
                        IF disp > 120 THEN
                                disx = disx - 20 * 12
                                disy = disy + 12
                        END IF
                        IF disp > 140 THEN
                                disx = disx - 20 * 12
                                disy = disy + 12
                        END IF
                        IF disp > 160 THEN
                                disx = disx - 20 * 12
                                disy = disy + 12
                        END IF
                        IF disp > 180 THEN
                                disx = disx - 20 * 12
                                disy = disy + 12
                        END IF

                        d = d + 1
                        IF item(disp) = 1 THEN
                                PSET (disx, disy), healc(d)
                        END IF
                        IF item(disp) = 2 THEN
                                PSET (disx, disy), sleepc(d)
                        END IF
                        IF item(disp) = 3 THEN
                                PSET (disx, disy), recallc(d)
                        END IF
                        IF item(disp) = 4 THEN
                                PSET (disx, disy), refreshc(d)
                        END IF

                        IF item(disp) > 4 AND item(disp) < 20 THEN
                                PSET (disx, disy), furc(d)
                        END IF

                        IF item(disp) = 20 THEN
                                PSET (disx, disy), scalpc(d)
                        END IF
                        IF item(disp) = 31 THEN
                                PSET (disx, disy), sword1c(d)
                        END IF
                        IF item(disp) = 32 THEN
                                PSET (disx, disy), sword2c(d)
                        END IF
                        IF item(disp) = 33 THEN
                                PSET (disx, disy), sword3c(d)
                        END IF
                        IF item(disp) = 34 THEN
                                PSET (disx, disy), staff1c(d)
                        END IF
                        IF item(disp) = 35 THEN
                                PSET (disx, disy), dagger1c(d)
                        END IF
                        IF item(disp) = 36 THEN
                                PSET (disx, disy), knifec(d)
                        END IF
                        IF item(disp) = 37 THEN
                                PSET (disx, disy), ropec(d)
                        END IF
                        IF item(disp) = 38 THEN
                                PSET (disx, disy), sword4c(d)
                        END IF




                NEXT
        NEXT
NEXT
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

IF item(selectionitem) = 0 AND nexted = 1 THEN
selectionitem = 160
END IF
IF backed = 1 AND item(selectionitem) = 0 THEN
selectionitem = itemsofar
IF itemsofar = 0 THEN selectionitem = 160
END IF

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
        SELECT CASE item(selectionitem)
                CASE 1
                        healpot = healpot - 1
                        hp = hp + mhp / 2
                        IF hp > mhp THEN hp = mhp
                CASE 2
                        sleeppot = sleeppot - 1
                        mp = mp + mmp / 2
                        IF mp > mmp THEN mp = mmp
                CASE 3
                        recallscroll = recallscroll - 1
                        start$ = "Town1"
                        recalled = 1
                CASE 4
                        refreshpot = refreshpot - 1
                        mp = mmp
                        hp = mhp
                CASE 31
                        weapon$ = "sword1"
                CASE 32
                        weapon$ = "sword2"
                CASE 33
                        weapon$ = "sword3"
                CASE 34
                        weapon$ = "staff1"
                CASE 35
                        weapon$ = "dagger1"
                CASE 38
                        weapon$ = "sword4"

        END SELECT
END IF







ERASE healc, sleepc, refreshc, recallc, furc, blucurs
ERASE bluredo, bluredo2, bluredo3, item, scalpc
ERASE sword1c, sword2c, sword3c, sword4c, staff1c, dagger1c, knifec, ropec

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

