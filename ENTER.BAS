DECLARE SUB house1 (tile30%, tile32%, gp, armor, magicmissle, curelight, createwater, lev, c, kc, expr, recallscroll, healpot, sleeppot, refreshpot, spellbitv, oldspellbitv)
DECLARE SUB house2 (tile30%, tile32%, gp, lev, c, expr, wepequip)
DECLARE SUB house3 (tile30%, tile32%, gp, peltcount())
DECLARE SUB house4 (tile30%, tile32%, gp, knife, rope)
DIM peltcount(15)
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
INPUT #1, curtile
FOR d = 1 TO 11
INPUT #1, peltcount(d)
NEXT
INPUT #1, lev
                FOR d = 1 TO 5
                        INPUT #1, monalive(d)
                NEXT
INPUT #1, aqua

CLOSE


IF curtile = 16 AND start$ = "Forest16" THEN
        start$ = "Elftree1"
        xpl = 12
        ypl = 5
        maploaded = 0

END IF
IF curtile = 12 AND start$ = "Town1" THEN
        IF xpl = 16 AND ypl = 4 THEN
                xpl = 13
                ypl = 13
                start$ = "Home"
                maploaded = 0

        END IF


        IF xpl = 2 AND ypl > 5 THEN

        IF books = 0 THEN start$ = "Elder"
        IF books = 1 THEN start$ = "Elder2"
        xpl = 13
        ypl = 13
        maploaded = 0

        END IF
END IF
IF start$ = "Town2" THEN
        IF curtile = 14 AND xpl = 11 AND ypl = 11 THEN
                xpl = 13
                ypl = 13
                start$ = "House1"
                maploaded = 0

        END IF

        IF curtile = 14 AND xpl = 14 AND ypl = 11 THEN
                xpl = 13
                ypl = 13
                start$ = "House2"
                maploaded = 0

        END IF

        IF curtile = 14 AND xpl = 19 AND ypl = 11 THEN
                xpl = 13
                ypl = 13
                start$ = "House3"
                maploaded = 0

        END IF

        IF curtile = 14 AND xpl = 14 AND ypl = 7 THEN
                xpl = 13
                ypl = 13
                start$ = "House4"
                maploaded = 0

        END IF

        IF curtile = 14 AND xpl = 16 AND ypl = 4 THEN
                xpl = 13
                ypl = 13
                start$ = "House5"
                maploaded = 0
 
        END IF

END IF
IF curtile = 12 AND start$ = "Town1" THEN

        IF xpl = 5 AND ypl = 3 THEN CALL house1(tile30%, tile32%, gp, armor, magicmissle, curelight, createwater, lev, c, kc, expr, recallscroll, healpot, sleeppot, refreshpot, spellbitv, oldspellbitv)
        IF xpl = 22 AND ypl = 3 THEN CALL house3(tile30%, tile32%, gp, peltcount())
        ypl = ypl + 1
        maploaded = 0
 
END IF
IF curtile = 12 AND start$ = "Town2" THEN
        IF xpl = 10 AND ypl = 6 THEN
                CALL house4(tile30%, tile32%, gp, knife, rope)
                ypl = ypl + 1
                maploaded = 0
 
        END IF
END IF




IF curtile = 14 AND start$ = "Town1" THEN
        cewmov = movf
        ypl = ypl + 1
        maploaded = 0
        CALL house2(tile30%, tile32%, gp, lev, c, expr, wepequip)
END IF

battletime = 1
initialload = 1
greeter = 1
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

SUB house1 (tile30%, tile32%, gp, armor, magicmissle, curelight, createwater, lev, c, kc, expr, recallscroll, healpot, sleeppot, refreshpot, spellbitv, oldspellbitv)
REDIM tile30%(100)
REDIM tile32%(100)

magicmissle = 0
curelight = 0
createwater = 0
armor = 0
aquabreath = 0
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

healcost = 40
sleepcost = 40
refreshcost = 100
recallcost = 50
sleeptime = 5000000
nospace = 1

20
CLS
SCREEN 13
DEF SEG = &HA000
OPEN "tile10.dat" FOR INPUT AS #1
d = 0
FOR y = 1 TO 10
FOR x = 1 TO 10
d = d + 1
INPUT #1, c
POKE x + y * 320, c
NEXT x
NEXT y
GET (1, 1)-(10, 10), tile30%
CLOSE
OPEN "tile32.dat" FOR INPUT AS #1
d = 0
FOR y = 1 TO 10
FOR x = 1 TO 10
d = d + 1
INPUT #1, c
POKE x + y * 320, c
NEXT x
NEXT y
GET (1, 1)-(10, 10), tile32%
CLOSE

DEF SEG = &HA000
BLOAD "House_1.dis", 0
LINE (161, 11)-(309, 109), 0, BF
LINE (160, 10)-(310, 110), 18, B
COLOR 4
LOCATE 3, 22
PRINT "Magic Shop."
LOCATE , 24
PRINT "Choose between"
LOCATE , 23
PRINT "magical learning"
LOCATE , 23
PRINT "(blue book) and"
LOCATE , 23
PRINT "purchasing basic"
LOCATE , 23
PRINT "magical items."
LOCATE , 23
PRINT "(shiny necklace)"
'c = 79
kc = 150
changed = 1

DO
'load from keyboard
  IF kl = 1 THEN
  kl = 0
  DEF SEG = 0: k = INP(&H60)
  WHILE LEN(INKEY$): WEND
  SELECT CASE k
  CASE &HB9
  'nothing
  nospace = 0

  CASE &H39
  'space key
  IF nospace = 0 THEN
        nospace = 1
        EXIT DO
  END IF

    CASE &H4B
    'right
    changed = 1

    selection = selection - 1
    kl = 0
    klf = 0
    CASE &H4D
    'left
     kl = 0
     klf = 0
    changed = 1

    selection = selection + 1
END SELECT
END IF

IF kl = 0 THEN klf = klf + 1
IF klf > kc THEN kl = 1


IF selection > 2 THEN selection = 2
IF selection < 1 THEN selection = 1
IF changed = 1 THEN
IF selection = 1 THEN PUT (80, 90), tile32%, PSET
IF selection = 2 THEN PUT (120, 90), tile32%, PSET
IF selection <> 1 THEN PUT (80, 90), tile30%, PSET
IF selection <> 2 THEN PUT (120, 90), tile30%, PSET
END IF
changed = 0


LOOP
45
LINE (161, 11)-(309, 109), 0, BF
IF selection = 1 THEN
        nobuy = 1
        changed = 1
        selection = 1
        IF magicmissle = 0 THEN
        OPEN "magmis.dat" FOR INPUT AS #1
                FOR y = 0 TO 9
                FOR x = 0 TO 9
                        INPUT #1, magmisc
                        PSET (162 + x, 12 + y), magmisc
                NEXT
                NEXT
        CLOSE
        END IF
        IF armor = 0 THEN
        OPEN "armor.dat" FOR INPUT AS #1
            FOR y = 0 TO 9
            FOR x = 0 TO 9
                INPUT #1, armorc
                PSET (162 + x + 12, 12 + y), armorc
            NEXT
            NEXT
        CLOSE
        END IF
        IF createwater = 0 THEN
        OPEN "creatw.dat" FOR INPUT AS #1
            FOR y = 0 TO 9
            FOR x = 0 TO 9
                INPUT #1, creatwc
                PSET (162 + x + 24, 12 + y), creatwc
            NEXT
            NEXT
        CLOSE
        END IF
        IF curelight = 0 THEN
        OPEN "curlit.dat" FOR INPUT AS #1
            FOR y = 0 TO 9
            FOR x = 0 TO 9
                INPUT #1, curlitc
                PSET (162 + x + 36, 12 + y), curlitc

            NEXT
            NEXT

        CLOSE
        END IF


        OPEN "back.dat" FOR INPUT AS #1

            FOR y = 0 TO 9
            FOR x = 0 TO 9
                INPUT #1, backc

                PSET (162 + x + 120, y + 36), backc

            NEXT
            NEXT

        CLOSE

        OPEN "exit.dat" FOR INPUT AS #1

            FOR y = 0 TO 9
            FOR x = 0 TO 9
                INPUT #1, exitc
                PSET (162 + x + 132, y + 36), exitc
            NEXT
            NEXT

        CLOSE


selection = 1
changed = 1
thru = 1
nobuy = 1
buying = 0
DO
'load from keyboard
  IF kl = 1 THEN
  kl = 0
  DEF SEG = 0: k = INP(&H60)
  WHILE LEN(INKEY$): WEND
  SELECT CASE k
  CASE &HB9
  'nothing
  nospace = 0

  CASE &H39
  'space key
  IF nospace = 0 THEN
        nospace = 1
        EXIT DO
  END IF

    CASE &H4B
    'right
    changed = 1
    oldx = x
    oldy = y
    nobuy = 0
    selection = selection - 1
    kl = 0
    klf = 0
    CASE &H4D
    'left
     kl = 0
     klf = 0
    changed = 1
    oldx = x
    oldy = y
    nobuy = 0
    selection = selection + 1
END SELECT
END IF

IF kl = 0 THEN klf = klf + 1
IF klf > kc * 325 THEN kl = 1


IF selection > 6 THEN
        selection = 6
        IF thru = 1 THEN
                thru = 0
                changed = 1
        ELSE
                changed = 0

        END IF
END IF
IF selection < 1 THEN
        selection = 1
        IF thru = 1 THEN
                thru = 0
                changed = 1
        ELSE
                changed = 0
        END IF
END IF
IF selection = 1 AND magicmissle = 1 THEN selection = selection + 1
IF selection = 2 AND armor = 1 THEN selection = selection + 1
IF selection = 3 AND createwater = 1 THEN selection = selection + 1
IF selection = 4 AND curelight = 1 THEN selection = selection + 1
IF changed = 1 THEN
startx = 161
starty = 11
'erase old box
LINE (startx + oldx, starty + oldy)-(startx + oldx + 11, starty + oldy + 11), 0, B

FOR cleary = 10 TO 13

        LOCATE cleary, 22
        PRINT "                 "
NEXT


SELECT CASE selection
        CASE 1
                COLOR 40
                LOCATE 10, 22
                PRINT "Magic Missle"
                COLOR 14
                LOCATE 11, 22
                PRINT "Cost: 100"

                x = 0
                y = 0
        CASE 2
                COLOR 1
                LOCATE 10, 22
                PRINT "Armor"
                COLOR 14
                LOCATE 11, 22
                PRINT "Cost: 125"

                x = 12
                y = 0
        CASE 3
                COLOR 1
                LOCATE 10, 22
                PRINT "Create Water"
                COLOR 14
                LOCATE 11, 22
                PRINT "Cost: 200"

                x = 24
                y = 0
        CASE 4
                COLOR 4
                LOCATE 10, 22
                PRINT "Cure Light Wounds"
                COLOR 14
                LOCATE 11, 22
                PRINT "Cost: 300"

                x = 36
                y = 0
        CASE 5
                COLOR 31
                LOCATE 10, 22
                PRINT "Select to go back"
                LOCATE 11, 22
                PRINT "to the main menu"
                x = 120
                y = 24
        CASE 6
                COLOR 31
                LOCATE 10, 22
                PRINT "Select to leave"
                LOCATE 11, 22
                PRINT "the magic shop"
                x = 132
                y = 24

END SELECT


COLOR 14
LOCATE 12, 22
PRINT "Current Gold:"
LOCATE 13, 22
PRINT gp
   LINE (startx + x, starty + y)-(startx + x + 11, starty + y + 11), 31, B



END IF
changed = 0


LOOP


LINE (161, 11)-(309, 109), 0, BF
IF selection = 1 THEN
        IF gp < 100 THEN
                COLOR 31
                LOCATE 3, 22
                PRINT "You do not have"
                LOCATE 4, 22
                PRINT "enough gold for"
                LOCATE 5, 22
                PRINT "that."
                ELSE
                        COLOR 31
                        LOCATE 3, 22
                        PRINT "You study how to"
                        LOCATE 4, 22
                        PRINT "cast magic missle"
                        spellbitv = spellbitv + 1
                        magicmissle = 1
                        gp = gp - 100
        END IF
END IF
IF selection = 2 THEN
        IF gp < 125 THEN
                COLOR 31
                LOCATE 3, 22
                PRINT "You do not have"
                LOCATE 4, 22
                PRINT "enough gold for"
                LOCATE 5, 22
                PRINT "that."
                ELSE
                        COLOR 31
                        LOCATE 3, 22
                        PRINT "You study how to"
                        LOCATE 4, 22
                        PRINT "cast armor"
                        spellbitv = spellbitv + 2
                        armor = 1
                        gp = gp - 125
        END IF

END IF
IF selection = 3 THEN
        IF gp < 200 THEN
                COLOR 31
                LOCATE 3, 22
                PRINT "You do not have"
                LOCATE 4, 22
                PRINT "enough gold for"
                LOCATE 5, 22
                PRINT "that."
                ELSE
                        COLOR 31
                        LOCATE 3, 22
                        PRINT "You study how to"
                        LOCATE 4, 22
                        PRINT "cast create water"
                        spellbitv = spellbitv + 4
                        createwater = 1
                        gp = gp - 200
        END IF

END IF
IF selection = 4 THEN
        IF gp < 300 THEN
                COLOR 31
                LOCATE 3, 22
                PRINT "You do not have"
                LOCATE 4, 22
                PRINT "enough gold for"
                LOCATE 5, 22
                PRINT "that."
                ELSE
                        COLOR 31
                        LOCATE 3, 22
                        PRINT "You study how to"
                        LOCATE 4, 22
                        PRINT "cast cure light"
                        LOCATE 5, 22
                        PRINT "wounds."
                        spellbitv = spellbitv + 8
                        curelight = 1
                        gp = gp - 300
        END IF

END IF

        IF selection = 5 THEN
                GOTO 20
                selection = 1

        END IF
        IF selection = 6 THEN
                EXIT SUB
        END IF

                FOR sleepin = 1 TO sleeptime: NEXT
        selection = 1
        GOTO 45


END IF
IF selection = 2 THEN
        nobuy = 1
        changed = 1
        selection = 1
        OPEN "heal.dat" FOR INPUT AS #1
                FOR y = 0 TO 9
                FOR x = 0 TO 9
                        INPUT #1, healc
                        PSET (162 + x, 12 + y), healc
                NEXT
                NEXT
        CLOSE

        OPEN "sleep.dat" FOR INPUT AS #1
            FOR y = 0 TO 9
            FOR x = 0 TO 9
                INPUT #1, sleepc
                PSET (162 + x + 12, 12 + y), sleepc
                NEXT
            NEXT
        CLOSE

        OPEN "refresh.dat" FOR INPUT AS #1
                FOR y = 0 TO 9
                FOR x = 0 TO 9
                        INPUT #1, refreshc

                        PSET (162 + x + 24, y + 12), refreshc

                NEXT
                NEXT

        CLOSE

        OPEN "recall.dat" FOR INPUT AS #1

            FOR y = 0 TO 9
            FOR x = 0 TO 9
                INPUT #1, recallc
                PSET (162 + x + 36, y + 12), recallc
            NEXT
            NEXT

        CLOSE

        OPEN "back.dat" FOR INPUT AS #1
            FOR y = 0 TO 9
            FOR x = 0 TO 9
                INPUT #1, backc
                PSET (162 + x + 120, y + 36), backc
            NEXT
            NEXT

        CLOSE

        OPEN "exit.dat" FOR INPUT AS #1

            FOR y = 0 TO 9
            FOR x = 0 TO 9

                INPUT #1, exitc

                PSET (162 + x + 132, y + 36), exitc
            NEXT
            NEXT


        CLOSE


selection = 1
changed = 1
thru = 1
nobuy = 1
buying = 0
DO
'load from keyboard
  IF kl = 1 THEN
  kl = 0
  DEF SEG = 0: k = INP(&H60)
  WHILE LEN(INKEY$): WEND
  SELECT CASE k
  CASE &HB9
  'nothing
  nospace = 0

  CASE &H39
  'space key
  IF nospace = 0 THEN
        nospace = 1
        EXIT DO
  END IF

    CASE &H4B
    'right
    changed = 1
    oldx = x
    oldy = y
    nobuy = 0
    selection = selection - 1
    kl = 0
    klf = 0
    CASE &H4D
    'left
     kl = 0
     klf = 0
    changed = 1
    oldx = x
    oldy = y
    nobuy = 0
    selection = selection + 1
END SELECT
END IF

IF kl = 0 THEN klf = klf + 1
IF klf > kc * 325 THEN kl = 1


IF selection > 6 THEN
        selection = 6
        IF thru = 1 THEN
                thru = 0
                changed = 1
        ELSE
                changed = 0

        END IF
END IF
IF selection < 1 THEN
        selection = 1
        IF thru = 1 THEN
                thru = 0
                changed = 1
        ELSE
                changed = 0
        END IF
END IF

IF changed = 1 THEN
startx = 161
starty = 11
'erase old box
LINE (startx + oldx, starty + oldy)-(startx + oldx + 11, starty + oldy + 11), 0, B

FOR cleary = 10 TO 13

        LOCATE cleary, 22
        PRINT "                 "
NEXT

SELECT CASE selection
        CASE 1
                COLOR 4
                LOCATE 10, 22
                PRINT "Healing Potion"
                COLOR 14
                LOCATE 11, 22
                PRINT "Cost:"; healcost

                x = 0
                y = 0
        CASE 2
                COLOR 1
                LOCATE 10, 22
                PRINT "Mana Potion"
                COLOR 14
                LOCATE 11, 22
                PRINT "Cost:"; sleepcost

                x = 12
                y = 0
        CASE 3
                COLOR 2
                LOCATE 10, 22
                PRINT "Refresh Potion"
                COLOR 14
                LOCATE 11, 22
                PRINT "Cost:"; refreshcost

                x = 24
                y = 0
        CASE 4
                COLOR 29
                LOCATE 10, 22
                PRINT "Recall Scroll"
                COLOR 14
                LOCATE 11, 22
                PRINT "Cost:"; recallcost

                x = 36
                y = 0
        CASE 5
                COLOR 31
                LOCATE 10, 22
                PRINT "Select to go back"
                LOCATE 11, 22
                PRINT "to main menu"
                x = 120
                y = 24
        CASE 6
                COLOR 31
                LOCATE 10, 22
                PRINT "Select to leave"
                LOCATE 11, 22
                PRINT "the magic shop"
                x = 132
                y = 24

END SELECT

COLOR 14
LOCATE 12, 22
PRINT "Current Gold:"
LOCATE 13, 22
PRINT gp

LINE (startx + x, starty + y)-(startx + x + 11, starty + y + 11), 31, B

END IF
changed = 0


LOOP

LINE (161, 11)-(309, 109), 0, BF
IF selection = 1 THEN
        IF gp < healcost THEN
                COLOR 31
                LOCATE 3, 22
                PRINT "You do not have"
                LOCATE 4, 22
                PRINT "enough gold for"
                LOCATE 5, 22
                PRINT "that."
                ELSE
                        COLOR 31
                        LOCATE 3, 22
                        PRINT "You buy a healing"
                        LOCATE 4, 22
                        PRINT "potion."
                        healpot = healpot + 1
                        gp = gp - healcost
        END IF
END IF
IF selection = 2 THEN
        IF gp < sleepcost THEN
                COLOR 31
                LOCATE 3, 22
                PRINT "You do not have"
                LOCATE 4, 22
                PRINT "enough gold for"
                LOCATE 5, 22
                PRINT "that."
                ELSE
                        COLOR 31
                        LOCATE 3, 22
                        PRINT "You buy a"
                        LOCATE 4, 22
                        PRINT "mana potion"
                        sleeppot = sleeppot + 1
                        gp = gp - sleepcost
        END IF

END IF
IF selection = 3 THEN
                IF gp < refreshcost THEN
                        COLOR 31
                        LOCATE 3, 22
                        PRINT "You do not have"
                        LOCATE 4, 22
                        PRINT "enough gold for"
                        LOCATE 5, 22
                        PRINT "that."
                ELSE
                                COLOR 31
                                LOCATE 3, 22
                                PRINT "You buy a"
                                LOCATE 4, 22
                                PRINT "refresh potion"
                                LOCATE 5, 22
                                PRINT "for 20 gold"
                                LOCATE 6, 22
                                PRINT "pieces."
                                refreshpot = refreshpot + 1
                                gp = gp - refreshcost
                END IF
        END IF
        IF selection = 4 THEN
                IF gp < recallcost THEN
                                COLOR 31
                                LOCATE 3, 22
                                PRINT "You do not have"
                                LOCATE 4, 22
                                PRINT "enough gold for"
                                LOCATE 5, 22
                                PRINT "that."
                        ELSE
                                COLOR 31
                                LOCATE 3, 22
                                PRINT "You buy a"
                                LOCATE 4, 22
                                PRINT "recall scroll"
                                gp = gp - recallcost
                                recallscroll = recallscroll + 1
                END IF

        END IF
        IF selection = 5 THEN
        GOTO 20
        selection = 1

        END IF
        IF selection = 6 THEN
                EXIT SUB
        END IF

                FOR sleepin = 1 TO sleeptime: NEXT
        selection = 2
        GOTO 45
END IF
END SUB

SUB house2 (tile30%, tile32%, gp, lev, c, expr, wepequip)
nospace = 1
sleeptime = 2500000

'figure out what weapons you have
oldwepquip = wepequip
IF wepequip >= 32 THEN
        wepequip = wepequip - 32
        sword4 = 1
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






REDIM tile30%(100)
REDIM tile32%(100)
200

CLS
SCREEN 13
DEF SEG = &HA000
OPEN "tile10.dat" FOR INPUT AS #1
d = 0
FOR y = 1 TO 10
FOR x = 1 TO 10
d = d + 1
INPUT #1, c
POKE x + y * 320, c
NEXT x
NEXT y
GET (1, 1)-(10, 10), tile30%
CLOSE
OPEN "tile32.dat" FOR INPUT AS #1
d = 0
FOR y = 1 TO 10
FOR x = 1 TO 10
d = d + 1
INPUT #1, c
POKE x + y * 320, c
NEXT x
NEXT y
GET (1, 1)-(10, 10), tile32%
CLOSE


BLOAD "House_3.dis", 0
LINE (161, 11)-(309, 109), 0, BF
LINE (160, 10)-(310, 109), 18, B

COLOR 7
LOCATE 3, 22
PRINT "Weapons and Armor"
LOCATE 5, 23
PRINT "Choose between"
LOCATE 6, 22
PRINT "weaponry (sword)"
LOCATE 7, 22
PRINT "and armor (suit"
LOCATE 8, 22
PRINT "of armor)."

kc = 140
changed = 1
DO


'load from keyboard
  IF kl = 1 THEN
  kl = 0
  DEF SEG = 0: k = INP(&H60)
  WHILE LEN(INKEY$): WEND
  SELECT CASE k
  CASE &HB9
  'nothing
  nospace = 0

  CASE &H39
  'space key
  IF nospace = 0 THEN
        nospace = 1
        EXIT DO
  END IF

    CASE &H4B
    'down
    changed = 1
    selection = selection - 1
    kl = 0
    klf = 0
    CASE &H4D
    'up
     kl = 0
     klf = 0
    changed = 1
    selection = selection + 1
END SELECT
END IF

IF kl = 0 THEN klf = klf + 1
kl = 1


IF selection > 2 THEN selection = 2
IF selection < 1 THEN selection = 1
IF changed = 1 THEN
IF selection = 1 THEN PUT (160, 110), tile32%, PSET
IF selection = 2 THEN PUT (200, 110), tile32%, PSET
IF selection <> 1 THEN PUT (160, 110), tile30%, PSET
IF selection <> 2 THEN PUT (200, 110), tile30%, PSET
END IF
changed = 0

IF selected = 1 THEN EXIT DO


LOOP

450
selected = 0

LINE (161, 11)-(309, 109), 0, BF

IF selection = 1 THEN
        nobuy = 1
        changed = 1
        selection = 1
        OPEN "sword2.dat" FOR INPUT AS #1
                FOR y = 0 TO 9
                FOR x = 0 TO 9
                        INPUT #1, sword2col
                        PSET (162 + x, 12 + y), sword2col
                NEXT
                NEXT
        CLOSE
        OPEN "sword3.dat" FOR INPUT AS #1
                FOR y = 0 TO 9
                FOR x = 0 TO 9
                        INPUT #1, sword3col
                        PSET (162 + x + 12, 12 + y), sword3col
                NEXT
                NEXT
        CLOSE
        OPEN "staff1.dat" FOR INPUT AS #1
                FOR y = 0 TO 9
                FOR x = 0 TO 9
                        INPUT #1, staff1col
                        PSET (162 + x + 24, 12 + y), staff1col
                NEXT
                NEXT
        CLOSE

        OPEN "dagger1.dat" FOR INPUT AS #1
                FOR y = 0 TO 9
                FOR x = 0 TO 9
                        INPUT #1, dagger1col
                        PSET (162 + x + 36, 12 + y), dagger1col
                NEXT
                NEXT
        CLOSE

        OPEN "back.dat" FOR INPUT AS #1

            FOR y = 0 TO 9
            FOR x = 0 TO 9
                INPUT #1, backc

                PSET (162 + x + 120, y + 36), backc

            NEXT
            NEXT

        CLOSE

        OPEN "exit.dat" FOR INPUT AS #1

            FOR y = 0 TO 9
            FOR x = 0 TO 9
                INPUT #1, exitc
                PSET (162 + x + 132, y + 36), exitc
            NEXT
            NEXT

        CLOSE


selection = 1
changed = 1
thru = 1
nobuy = 1
buying = 0
DO


'load from keyboard
  IF kl = 1 THEN
  kl = 0
  DEF SEG = 0: k = INP(&H60)
  WHILE LEN(INKEY$): WEND

  SELECT CASE k
  CASE &HB9
  'nothing
  nospace = 0

  CASE &H39
  'space key
  IF nospace = 0 THEN
        nospace = 1
        EXIT DO
  END IF

    CASE &H4B
    'right
    changed = 1
    oldx = x
    oldy = y
    nobuy = 0
    selection = selection - 1
    kl = 0
    klf = 0
    CASE &H4D
    'left
     kl = 0
     klf = 0
    changed = 1
    oldx = x
    oldy = y
    nobuy = 0
    selection = selection + 1
END SELECT
END IF

IF kl = 0 THEN klf = klf + 1
IF klf > kc * 325 THEN kl = 1


IF selection > 6 THEN
        selection = 6
        IF thru = 1 THEN
                thru = 0
                changed = 1
        ELSE
                changed = 0

        END IF
END IF
IF selection < 1 THEN
        selection = 1
        IF thru = 1 THEN
                thru = 0
                changed = 1
        ELSE
                changed = 0
        END IF
END IF

IF changed = 1 THEN
startx = 161
starty = 11
'erase old box
LINE (startx + oldx, starty + oldy)-(startx + oldx + 11, starty + oldy + 11), 0, B

FOR cleary = 10 TO 13

        LOCATE cleary, 22

        PRINT "                 "
NEXT

SELECT CASE selection
        CASE 1
                COLOR 15
                LOCATE 10, 22
                PRINT "Longsword"
                COLOR 14
                LOCATE 11, 22
                PRINT "Cost: 125"

                x = 0
                y = 0
        CASE 2
                COLOR 15
                LOCATE 10, 22
                PRINT "Broadsword"
                COLOR 14
                LOCATE 11, 22
                PRINT "Cost: 150"

                x = 12
                y = 0
        CASE 3
                COLOR 15
                LOCATE 10, 22
                PRINT "Bo staff"
                COLOR 14
                LOCATE 11, 22
                PRINT "Cost: 100"

                x = 24
                y = 0
        CASE 4
                COLOR 15
                LOCATE 10, 22
                PRINT "Dirk"
                COLOR 14
                LOCATE 11, 22
                PRINT "Cost: 50"

                x = 36
                y = 0
        CASE 5
                COLOR 31
                LOCATE 10, 22
                PRINT "Select to go back"
                LOCATE 11, 22
                PRINT "to the main menu"
                x = 120
                y = 24
        CASE 6
                COLOR 31
                LOCATE 10, 22
                PRINT "Select to leave"
                LOCATE 11, 22
                PRINT "the weapon shop"
                x = 132
                y = 24

END SELECT

COLOR 14
LOCATE 12, 22
PRINT "Current Gold:"
LOCATE 13, 22
PRINT gp

LINE (startx + x, starty + y)-(startx + x + 11, starty + y + 11), 31, B

END IF
changed = 0


LOOP


LINE (161, 11)-(309, 109), 0, BF
IF selection = 1 THEN
        IF gp < 125 THEN
                COLOR 31
                LOCATE 3, 22
                PRINT "You do not have"
                LOCATE 4, 22
                PRINT "enough gold for"
                LOCATE 5, 22
                PRINT "that."
                ELSE
                        IF sword2 = 0 THEN
                                COLOR 31
                                LOCATE 3, 22
                                PRINT "You buy a"
                                LOCATE 4, 22
                                PRINT "longsword"
                                sword2 = 1
                                wepequip = wepequip + 2
                                gp = gp - 125
                                ELSE
                                COLOR 31
                                LOCATE 3, 22
                                PRINT "You already have"
                                LOCATE 4, 22
                                PRINT "one."

                        END IF
        END IF
END IF
IF selection = 2 THEN
        IF gp < 150 THEN
                COLOR 31
                LOCATE 3, 22
                PRINT "You do not have"
                LOCATE 4, 22
                PRINT "enough gold for"
                LOCATE 5, 22
                PRINT "that."
                ELSE
                        IF sword3 = 0 THEN
                        COLOR 31
                        LOCATE 3, 22
                        PRINT "You buy a"
                        LOCATE 4, 22
                        PRINT "broadsword"
                        sword3 = 1
                        wepequip = wepequip + 4
                        gp = gp - 150
                                ELSE
                                COLOR 31
                                LOCATE 3, 22
                                PRINT "You already have"
                                LOCATE 4, 22
                                PRINT "one."


                        END IF
        END IF

END IF
IF selection = 3 THEN
        IF gp < 100 THEN
                COLOR 31
                LOCATE 3, 22
                PRINT "You do not have"
                LOCATE 4, 22
                PRINT "enough gold for"
                LOCATE 5, 22
                PRINT "that."
                ELSE
                        IF staff1 = 0 THEN
                        COLOR 31
                        LOCATE 3, 22
                        PRINT "You buy a bo"
                        LOCATE 4, 22
                        PRINT "staff"
                        staff1 = 1
                        wepequip = wepequip + 8
                        gp = gp - 100
                                ELSE
                                COLOR 31
                                LOCATE 3, 22

                                PRINT "You already have"
                                LOCATE 4, 22
                                PRINT "one."


                        END IF
        END IF

END IF
IF selection = 4 THEN
        IF gp < 50 THEN
                COLOR 31
                LOCATE 3, 22
                PRINT "You do not have"
                LOCATE 4, 22
                PRINT "enough gold for"
                LOCATE 5, 22
                PRINT "that."
                ELSE
                        IF dagger1 = 0 THEN
                        COLOR 31
                        LOCATE 3, 22
                        PRINT "You buy a dirk"
                        LOCATE 4, 22
                        PRINT ""
                        LOCATE 5, 22
                        PRINT ""
                        dagger1 = 1
                        wepequip = wepequip + 16
                        gp = gp - 50
                                ELSE
                                COLOR 31
                                LOCATE 3, 22
                                PRINT "You already have"
                                LOCATE 4, 22
                                PRINT "one."


                        END IF
        END IF

END IF

        IF selection = 5 THEN
                selection = 1
                GOTO 200


        END IF
        IF selection = 6 THEN
                GOTO 897
        END IF

        FOR sleepin = 1 TO sleeptime: NEXT
        selection = 1
        GOTO 450



END IF
897

END SUB

SUB house3 (tile30%, tile32%, gp, peltcount())
REDIM tile30%(100)
REDIM tile32%(100)

sleeptime = 1500000
nospace = 1
210
CLS
SCREEN 13
DEF SEG = &HA000
OPEN "tile10.dat" FOR INPUT AS #1
d = 0
FOR y = 1 TO 10
FOR x = 1 TO 10
d = d + 1
INPUT #1, c
POKE x + y * 320, c
NEXT x
NEXT y
GET (1, 1)-(10, 10), tile30%
CLOSE
OPEN "tile32.dat" FOR INPUT AS #1
d = 0
FOR y = 1 TO 10
FOR x = 1 TO 10
d = d + 1
INPUT #1, c
POKE x + y * 320, c
NEXT x
NEXT y
GET (1, 1)-(10, 10), tile32%
CLOSE

DEF SEG = &HA000
BLOAD "House_4.dis", 0
LINE (161, 11)-(309, 108), 0, BF
LINE (160, 10)-(310, 109), 18, B
COLOR 4
LOCATE 3, 22
PRINT "Pelt Shop."
LOCATE , 24
PRINT "Choose between"
LOCATE , 23
PRINT "selling pelts"
LOCATE , 23
PRINT "and purchasing"
LOCATE , 23
PRINT "fur coats."

kc = 120
changed = 1

DO


'load from keyboard
  IF kl = 1 THEN
  kl = 0
  DEF SEG = 0: k = INP(&H60)
  WHILE LEN(INKEY$): WEND
  SELECT CASE k
  CASE &HB9
  'nothing
  nospace = 0

  CASE &H39
  'space key
  IF nospace = 0 THEN
        nospace = 1
        EXIT DO
  END IF

    CASE &H4B
    'right
    changed = 1

    selection = selection - 1
    kl = 0
    klf = 0
    CASE &H4D
    'left
     kl = 0
     klf = 0
    changed = 1

    selection = selection + 1
END SELECT
END IF

IF kl = 0 THEN klf = klf + 1
IF klf > kc THEN kl = 1


IF selection > 2 THEN selection = 2
IF selection < 1 THEN selection = 1
IF changed = 1 THEN
IF selection = 1 THEN PUT (160, 110), tile32%, PSET
IF selection = 2 THEN PUT (200, 110), tile32%, PSET
IF selection <> 1 THEN PUT (160, 110), tile30%, PSET
IF selection <> 2 THEN PUT (200, 110), tile30%, PSET
END IF
changed = 0


LOOP
451
LINE (161, 11)-(309, 109), 0, BF
IF selection = 1 THEN
peltworth = 0
FOR d = 1 TO 11
        IF peltcount(d) > 0 THEN
        currentpelt = d ^ 2
        currentpelt = currentpelt * peltcount(d)

        ELSE
        currentpelt = 0
        END IF
        peltworth = peltworth + currentpelt
        peltcount(d) = 0
NEXT
        peltworth = INT(peltworth * 4)
        IF peltworth > 0 THEN
                gp = gp + peltworth
                COLOR 31
                LOCATE 3, 22
                PRINT "You sell all of"

                LOCATE 4, 22
                PRINT "your pelts and"
                LOCATE 5, 22
                PRINT "recieve"
                LOCATE 6, 22
                PRINT peltworth
                LOCATE 7, 22
                PRINT "gold pieces."
                ELSE
                        COLOR 31
                        LOCATE 3, 22
                        PRINT "You have no furs"
                        LOCATE 4, 22
                        PRINT "or skins to sell."
                        LOCATE 5, 22
                        PRINT "Buy a skinning"
                        LOCATE 6, 22
                        PRINT "knife and venture"
                        LOCATE 7, 22
                        PRINT "into the woods to"
                        LOCATE 8, 22
                        PRINT "get some."
        END IF


FOR sleepin = 1 TO sleeptime: NEXT 'wait a sec so they can read good
END IF
IF selection = 2 THEN

END IF



END SUB

SUB house4 (tile30%, tile32%, gp, knife, rope)
REDIM tile30%(100)
REDIM tile32%(100)
REDIM knifecol(100)
REDIM ropecol(100)
REDIM exitc(100)
REDIM backc(100)
2000
nospace = 1
sleeptime = 2500000
CLS
SCREEN 13
DEF SEG = &HA000
OPEN "tile10.dat" FOR INPUT AS #1
d = 0
FOR y = 1 TO 10
FOR x = 1 TO 10
d = d + 1
INPUT #1, c
POKE x + y * 320, c
NEXT x
NEXT y
GET (1, 1)-(10, 10), tile30%
CLOSE
OPEN "tile32.dat" FOR INPUT AS #1
d = 0
FOR y = 1 TO 10
FOR x = 1 TO 10
d = d + 1
INPUT #1, c
POKE x + y * 320, c
NEXT x
NEXT y
GET (1, 1)-(10, 10), tile32%
CLOSE

DEF SEG = &HA000
BLOAD "House_5.dis", 0
LINE (161, 11)-(309, 108), 0, BF
LINE (160, 10)-(310, 109), 18, B
COLOR 5
LOCATE 3, 22
PRINT "General store."
LOCATE , 24
PRINT "Choose between"
LOCATE , 23
PRINT "selling items"
LOCATE , 23
PRINT "(Right)"
LOCATE , 23
PRINT "and purchasing"
LOCATE , 23
PRINT "them. (Left)"
LOCATE , 23

kc = 140
changed = 1

DO


'load from keyboard
  IF kl = 1 THEN
  kl = 0
  DEF SEG = 0: k = INP(&H60)
  WHILE LEN(INKEY$): WEND
  SELECT CASE k
  CASE &HB9
  'nothing
  nospace = 0

  CASE &H39
  'space key
  IF nospace = 0 THEN
        nospace = 1
        EXIT DO
  END IF

    CASE &H4B
    'right
    changed = 1

    selection = selection - 1
    kl = 0
    klf = 0
    CASE &H4D
    'left
     kl = 0
     klf = 0
    changed = 1

    selection = selection + 1
END SELECT
END IF

IF kl = 0 THEN klf = klf + 1
IF klf > kc THEN kl = 1


IF selection > 2 THEN selection = 2
IF selection < 1 THEN selection = 1
IF changed = 1 THEN
IF selection = 1 THEN PUT (160, 110), tile32%, PSET
IF selection = 2 THEN PUT (200, 110), tile32%, PSET
IF selection <> 1 THEN PUT (160, 110), tile30%, PSET
IF selection <> 2 THEN PUT (200, 110), tile30%, PSET
END IF
changed = 0


LOOP


4600

LINE (161, 11)-(309, 109), 0, BF

IF selection = 2 THEN
COLOR 31
LOCATE 3, 22
PRINT "You have nothing"
LOCATE 4, 22
PRINT "that I am"
LOCATE 5, 22
PRINT "interested in."

FOR sleepin = 1 TO sleeptime: NEXT 'wait a sec so they can read good
END IF

IF selection = 1 THEN
        nobuy = 1
        changed = 1
        selection = 1
        OPEN "knife1.dat" FOR INPUT AS #1
                FOR y = 0 TO 9
                FOR x = 0 TO 9
                        INPUT #1, knifecol
                        PSET (162 + x, 12 + y), knifecol
                NEXT
                NEXT
        CLOSE
        OPEN "rope.dat" FOR INPUT AS #1
                FOR y = 0 TO 9
                FOR x = 0 TO 9
                        INPUT #1, ropecol
                        PSET (162 + x + 12, 12 + y), ropecol
                NEXT
                NEXT
        CLOSE

        OPEN "back.dat" FOR INPUT AS #1

            FOR y = 0 TO 9
            FOR x = 0 TO 9
                INPUT #1, backc

                PSET (162 + x + 120, y + 36), backc

            NEXT
            NEXT

        CLOSE

        OPEN "exit.dat" FOR INPUT AS #1

            FOR y = 0 TO 9
            FOR x = 0 TO 9
                INPUT #1, exitc
                PSET (162 + x + 132, y + 36), exitc
            NEXT
            NEXT

        CLOSE

selection = 1
changed = 1
thru = 1
nobuy = 1
buying = 0
DO
'load from keyboard
  IF kl = 1 THEN
  kl = 0
  DEF SEG = 0: k = INP(&H60)
  WHILE LEN(INKEY$): WEND

  SELECT CASE k
  CASE &HB9
  'nothing
  nospace = 0

  CASE &H39
  'space key
  IF nospace = 0 THEN
        nospace = 1
        EXIT DO
  END IF

    CASE &H4B
    'right
    changed = 1
    oldx = x
    oldy = y
    nobuy = 0
    selection = selection - 1
    kl = 0
    klf = 0
    CASE &H4D
    'left
     kl = 0
     klf = 0
    changed = 1
    oldx = x
    oldy = y
    nobuy = 0
    selection = selection + 1
END SELECT
END IF

IF kl = 0 THEN klf = klf + 1
IF klf > kc * 325 THEN kl = 1


IF selection > 4 THEN
        selection = 4
        IF thru = 1 THEN
                thru = 0
                changed = 1
        ELSE
                changed = 0

        END IF
END IF
IF selection < 1 THEN
        selection = 1
        IF thru = 1 THEN
                thru = 0
                changed = 1
        ELSE
                changed = 0
        END IF
END IF

IF changed = 1 THEN
startx = 161
starty = 11
'erase old box
LINE (startx + oldx, starty + oldy)-(startx + oldx + 11, starty + oldy + 11), 0, B

FOR cleary = 10 TO 13

        LOCATE cleary, 22

        PRINT "                 "
NEXT

SELECT CASE selection
        CASE 1
                COLOR 15
                LOCATE 10, 22
                PRINT "Skinning Knife"
                COLOR 14
                LOCATE 11, 22
                PRINT "Cost: 12"

                x = 0
                y = 0
        CASE 2
                COLOR 15
                LOCATE 10, 22
                PRINT "Climbing Rope"
                COLOR 14
                LOCATE 11, 22
                PRINT "Cost: 30"

                x = 12
                y = 0

        CASE 3
                COLOR 31
                LOCATE 10, 22
                PRINT "Select to go back"
                LOCATE 11, 22
                PRINT "to the main menu"
                x = 120
                y = 24
        CASE 4
                COLOR 31
                LOCATE 10, 22
                PRINT "Select to leave"
                LOCATE 11, 22
                PRINT "the weapon shop"
                x = 132
                y = 24

END SELECT

COLOR 14
LOCATE 12, 22
PRINT "Current Gold:"
LOCATE 13, 22
PRINT gp

LINE (startx + x, starty + y)-(startx + x + 11, starty + y + 11), 31, B

END IF
changed = 0


LOOP


LINE (161, 11)-(309, 109), 0, BF

IF selection = 1 THEN
        IF gp < 12 THEN
                COLOR 31
                LOCATE 3, 22
                PRINT "You do not have"
                LOCATE 4, 22
                PRINT "enough gold for"
                LOCATE 5, 22
                PRINT "that."
                ELSE
                        IF knife = 0 THEN
                                COLOR 31
                                LOCATE 3, 22
                                PRINT "You buy a"
                                LOCATE 4, 22
                                PRINT "skinning knife."
                                knife = 1

                                gp = gp - 12
                                ELSE
                                COLOR 31
                                LOCATE 3, 22
                                PRINT "You already have"
                                LOCATE 4, 22
                                PRINT "one."

                        END IF
        END IF
        FOR sleepin = 1 TO sleeptime: NEXT 'wait a sec so they can read good
        selection = 1
        GOTO 4600
END IF

IF selection = 2 THEN
        IF gp < 30 THEN
                COLOR 31
                LOCATE 3, 22
                PRINT "You do not have"
                LOCATE 4, 22
                PRINT "enough gold for"
                LOCATE 5, 22
                PRINT "that."
                ELSE
                        IF rope = 0 THEN
                                COLOR 31
                                LOCATE 3, 22
                                PRINT "You buy a"
                                LOCATE 4, 22
                                PRINT "rope."
                                rope = 1

                                gp = gp - 30
                                ELSE
                                COLOR 31
                                LOCATE 3, 22
                                PRINT "You already have"
                                LOCATE 4, 22
                                PRINT "one."

                        END IF
        END IF
        FOR sleepin = 1 TO sleeptime: NEXT 'wait a sec so they can read good
        selection = 1
        GOTO 4600

END IF


END IF

        IF selection = 3 THEN
                selection = 1
                GOTO 2000


        END IF
        IF selection = 4 THEN
                GOTO 8970
        END IF




8970

END SUB

