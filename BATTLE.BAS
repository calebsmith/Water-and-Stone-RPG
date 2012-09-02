RANDOMIZE TIMER
DIM peltcount(15)
'battle engine for game

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
oldexpr = expr
IF armoron = 1 THEN ac = ac - 4

'load spells from spellbitvector

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







IF xp = 0 THEN xp = 10
IF yp = 0 THEN yp = 10
IF monster = 0 THEN monster = 4
points = 100
maxitem = 54
REDIM blucurs(points)
REDIM cursclear(points)
REDIM item(maxitem)
REDIM healc(points)
REDIM sleepc(points)
REDIM refreshc(points)
REDIM none(points)
REDIM burn(points)
REDIM burn2(points)
REDIM burn3(points)
REDIM magmisc(points)
REDIM montemphp%(points / 2)
IF weapon$ = "staff1" THEN thac0 = thac0 - 4
kc = 12
selection = 1
sleeptime = 2000000 'amount of pause between displays
IF monster = 1 THEN monster$ = "dog"
IF monster = 2 THEN monster$ = "spider"
IF monster = 3 THEN monster$ = "gangthug"
IF monster = 4 THEN monster$ = "gangboss"
IF monster > 4 THEN monster$ = "wild"


gottenhp = 0'background of monster hp bar not obtained yet
monspotx = 130
monspoty = 65
xselect = 65
yselect = 160

c = 79
IF healpot > 5 THEN healpot = 5
IF sleeppot > 5 THEN sleeppot = 5
firstthru = 1
CLS
SCREEN 13
'load bluecursor
DEF SEG = &HA000

OPEN "blucurs.dat" FOR INPUT AS #1
        d = 0
        FOR d = 1 TO 100
                INPUT #1, blucurs(d)
        NEXT
CLOSE

path$ = ""
ext$ = ".dat"
filename$ = monster$ + ext$
OPEN filename$ FOR INPUT AS #1    ' load monster
        IF monster > 4 THEN
                DO
                 INPUT #1, reading$
                 wildcritter = monster - 4
                 IF wildcritter < 10 THEN numba$ = RIGHT$(reading$, 1)
                 IF wildcritter > 9 THEN numba$ = RIGHT$(reading$, 2)
                 number = VAL(numba$)
                 IF number = wildcritter AND LEFT$(reading$, 6) = "animal" THEN
                 EXIT DO
                 END IF
                LOOP
        END IF
        INPUT #1, monname$             ' name of monster
        INPUT #1, furtype$             ' type of fur (fure,pelt,skin,etc.) or none
        INPUT #1, monattack$           ' attack verb
        INPUT #1, mlev                 ' level
        INPUT #1, mthac0               ' THAC0
        INPUT #1, mac                  ' Armor Class
        INPUT #1, mhpm                 '  Hitpoint max    (randomly this to     x d
        INPUT #1, mhpmin               '     "     min          this              y
        INPUT #1, mhpp                 '  Hitpoint plus           + this)
        INPUT #1, mdamm                '  Monster damage max
        INPUT #1, mdammin              '  Monster damage min
        INPUT #1, mdamp                '  Monster damage plus
CLOSE
'monhp = (INT(RND * mhpm) + mhpmin) + mhpp  'calculate monsters hit points
monhp = 0
FOR rolling = 1 TO mhpmin
        roll = INT(RND * mhpm) + 1
        monhp = monhp + roll
NEXT
monhp = monhp + mhpp
monmaxhp = monhp


BLOAD "back_ba2.dis", 0  'draw background of battle

path$ = ""
ext$ = ".dat"
filepre$ = "mon"

IF monster > 4 THEN filepre$ = "wild"
IF monster > 4 THEN
        monster = monster - 4
        monchanged = 1
END IF
IF monster < 10 THEN filename$ = path$ + filepre$ + RIGHT$(STR$(monster), 1) + ext$
IF monster > 9 THEN filename$ = path$ + filepre$ + RIGHT$(STR$(monster), 2) + ext$
IF monchanged = 1 THEN monster = monster + 4
OPEN filename$ FOR INPUT AS #1                      'load monster and draw it


        FOR mony = 1 TO 30
        FOR monx = 1 TO 30

                INPUT #1, monc
                IF monc <> 0 THEN PSET (monx + monspotx, mony + monspoty), monc
        NEXT
        NEXT
CLOSE

' draw text box

LINE (11, 125)-(310, 150), 0, BF
LINE (10, 124)-(311, 151), 17, B
LINE (9, 123)-(312, 152), 19, B
LINE (8, 122)-(313, 153), 21, B
LINE (7, 121)-(314, 154), 23, B
LINE (6, 120)-(315, 155), 25, B



'draw edges of monster health bar
LINE (129, 99)-(129, 101), 15
LINE (181, 99)-(181, 101), 15

'load buttons
path$ = ""
button$ = "btn"
ext$ = ".dat"
DO WHILE butnum < 4

butnum = butnum + 1
btnspotx = btnspotx + 50
btnspoty = 160
filename$ = button$ + RIGHT$(STR$(butnum), 1) + ext$
OPEN filename$ FOR INPUT AS #1          'attack button

        d = 0
        FOR btny = 1 TO 30
        FOR btnx = 1 TO 30
                d = d + 1
                INPUT #1, btnc
                IF btnc <> 0 THEN PSET (btnx + btnspotx, btny + btnspoty), btnc
        NEXT
        NEXT
CLOSE
LOOP

'draw health box
LINE (237, 158)-(313, 177), 15, B
LINE (238, 159)-(312, 176), 0, BF
monturn = 0
DO

IF thrubat = 0 THEN

        LOCATE 17, 3
        PRINT monname$
        LOCATE 18, 3
        PRINT "stands before you"
END IF
IF INKEY$ = " " THEN selected = 1
IF monturn = 1 THEN

        monturn = 0
        mar = INT(RND * 20) + 1     ' d20 attack roll
        mar = mthac0 - mar

        IF mar <= ac THEN mhit = 1   ' monster hits
        IF mar > ac THEN mhit = 0  ' monster misses
        mdam = 0
        FOR rolling = 1 TO mdammin
                roll = INT(RND * mdamm) + 1
                mdam = mdam + roll
        NEXT
        mdam = mdam + mdamp
        'mdam = (INT(RND * mdamm) + mdammin) + mdamp

        LOCATE 17, 3
        PRINT "                                   "
        LOCATE 18, 3
        PRINT "                                   "
        IF mhit = 1 THEN
                LOCATE 17, 3
                PRINT ""; monname$; "'s "; monattack$; ""
                LOCATE 18, 3
                PRINT "does"; mdam; "damage."

                hp = hp - mdam


        END IF
        IF mhit = 0 THEN
                LOCATE 17, 3
                PRINT ""; monname$; "'s "; monattack$; ""
                LOCATE 18, 3
                PRINT "misses you."

        END IF
         FOR sleepin = 1 TO sleeptime: NEXT
        LINE (238, 159)-(312, 175), 0, BF
END IF

IF INKEY$ = " " THEN selected = 1

WAIT &H3DA, 8


nummons = 5
IF INKEY$ = " " THEN selected = 1

'load from keyboard
IF kl = 1 THEN
        kl = 0
        DEF SEG = 0: k = INP(&H60)
        WHILE LEN(INKEY$): WEND
        SELECT CASE k
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
IF INKEY$ = " " THEN selected = 1
IF kl = 0 THEN klf = klf + 1
IF klf > kc THEN kl = 1

IF selection > 4 THEN selection = 4
IF selection < 1 THEN selection = 1
IF changed = 1 THEN
PUT (xselect, yselect), cursclear, PSET
        IF selection = 1 THEN xselect = 65
        IF selection = 2 THEN xselect = 115
        IF selection = 3 THEN xselect = 165
        IF selection = 4 THEN xselect = 215
GET (xselect, yselect)-(xselect + 10, yselect + 10), cursclear
END IF
IF firstthru = 1 THEN GET (xselect, yselect)-(xselect + 10, yselect + 10), cursclear
IF firstthru = 1 OR changed = 1 THEN
        firstthru = 0
        d = 0
        FOR bluy = 1 TO 10
        FOR blux = 1 TO 10
                d = d + 1
                IF blucurs(d) <> 16 THEN PSET (blux + xselect, bluy + yselect), blucurs(d)
        NEXT
        NEXT
        changed = 0
END IF




IF INKEY$ = " " THEN selected = 1
IF hp < 1 THEN


        FOR sleepin = 1 TO sleeptime: NEXT
        LOCATE 17, 3
        PRINT "                                   "
        LOCATE 18, 3
        PRINT "                                   "
        LOCATE 17, 3
        COLOR 4
        PRINT "You are dying."
        FOR sleepin = 1 TO sleeptime: NEXT
EXIT DO
END IF

300
hpperc = INT((hp / mhp) * 100)                  'draw bars of stats
mpperc = INT((mp / mmp) * 100)
LINE (240, 160)-(240 + (hpperc * .7), 165), 40, BF
LINE (240, 170)-(240 + (mpperc * .7), 175), 33, BF
IF INKEY$ = " " THEN selected = 1


IF selected = 1 THEN
        selected = 0
        IF selection = 4 THEN

                IF thrubat = 1 THEN expr = expr - lev * 20 'if initial swing has been made and flee in progress than deduct xp

                flee = 1
                IF monster = 4 THEN ypl = ypl + 1
                EXIT DO
        END IF
thrubat = 1   ' first round is over

'ATTACK
IF selection = 1 THEN
        ar = INT(RND * 20) + 1
        ar = thac0 - ar
        IF ar < mac THEN hit = 1
        IF ar >= mac THEN hit = 0
        dam = INT(RND * attd) + atpl
        IF dam <= 1 THEN dam = 1
                        LOCATE 17, 3
                        PRINT "                                   "
                        LOCATE 18, 3
                        PRINT "                                   "

        IF hit = 1 THEN

               expr = expr + mlev * 2 + 5
                LOCATE 17, 3
                PRINT "Your "; tow$; ""
                LOCATE 18, 3
                PRINT "does"; dam; "damage."

                monhp = monhp - dam
        END IF
        IF hit = 0 THEN
                expr = expr + 1
                LOCATE 17, 3
                PRINT "Your "; tow$; " misses "
                LOCATE 18, 3
                PRINT ""; monname$; ""
        END IF
        monturn = 1
                FOR sleepin = 1 TO sleeptime: NEXT


IF weapon$ = "sword4" THEN

        'load fireball picture
        OPEN "magmis.dat" FOR INPUT AS #1
d = 0
                FOR y = 0 TO 9
                FOR x = 0 TO 9
                        d = d + 1
                        INPUT #1, magmisc(d)
                NEXT
                NEXT

        CLOSE


        'draw fireball
        x = 280
        y = 2
        DO
             x = x - 1 * 2
             y = y + .5 * 2
                        x10 = x - 13
                        Y10 = y + 3
                        x20 = x + 3
                        Y20 = y + 12

                        GET (INT(x), INT(y))-(INT(x) + 10, INT(y) + 10), burn
                        d = 0
                        DEF SEG = &HA000
                        FOR y2 = 1 TO 10
                        FOR x2 = 1 TO 10
                                d = d + 1
                                IF magmisc(d) <> 16 THEN POKE ((INT(x) + x2) + (INT(y) + y2) * 320), magmisc(d)
                        NEXT
                        NEXT
                        WAIT &H3DA, 8

                        PUT (INT(x), INT(y)), burn, PSET
        LOOP UNTIL x < 160

                expr = expr + 5    ' give some exprience


                'generate amount of damage
                mmdam = 0
                FOR th = 1 TO lev
                        mmrand = INT(RND * 8 + lev)
                        mmdam = mmdam + mmrand
                NEXT th
                IF mmdam / 3 = 0 THEN mmdam = 1
                monhp = monhp - INT(mmdam / 3)   'do the monster the appropriate damage

                LINE (11, 125)-(310, 150), 0, BF
                LOCATE 17, 3
                PRINT "Your katana's fireball"
                LOCATE 18, 3
                PRINT "did"; mmdam; "damage."

                monturn = 1
                        FOR sleepin = 1 TO sleeptime: NEXT

END IF



END IF


'SPELL

IF selection = 2 THEN

        LINE (11, 125)-(310, 150), 0, BF
        startx = 12
        starty = 126

        OPEN "magmis.dat" FOR INPUT AS #1
d = 0
                FOR y = 0 TO 9
                FOR x = 0 TO 9
                        d = d + 1
                        INPUT #1, magmisc(d)
                        PSET (startx + x, starty + y), magmisc(d)
                NEXT
                NEXT

        CLOSE
        OPEN "armor.dat" FOR INPUT AS #1

                FOR y = 0 TO 9
                FOR x = 0 TO 9
                        INPUT #1, armorc
                        PSET (startx + x + 12, starty + y), armorc
                NEXT
                NEXT

        CLOSE
        OPEN "creatw.dat" FOR INPUT AS #1

                FOR y = 0 TO 9
                FOR x = 0 TO 9
                        INPUT #1, creatwc
                        PSET (startx + x + 24, starty + y), creatwc
                NEXT
                NEXT

        CLOSE
        OPEN "curlit.dat" FOR INPUT AS #1

                FOR y = 0 TO 9
                FOR x = 0 TO 9
                        INPUT #1, curlitc
                        PSET (startx + x + 36, starty + y), curlitc
                NEXT
                NEXT

        CLOSE
        OPEN "none.dat" FOR INPUT AS #1


                                 FOR y = 0 TO 9
                                 FOR x = 0 TO 9

                                 INPUT #1, none(d)
                                 PSET (x + 24 * 12, y + starty + 13), none(d)
                                NEXT
                                NEXT
                        CLOSE

selected = 0
selectionspellold = 1
selectionspell = 1

DO WHILE selected = 0
IF INKEY$ = " " THEN selected = 1
'load from keyboard
IF kl = 1 THEN
        kl = 0
        DEF SEG = 0: k = INP(&H60)
        WHILE LEN(INKEY$): WEND
        SELECT CASE k
                CASE &H4B
                'left
                        changed = 1
                        selectionspellold = selectionspell
                        selectionspell = selectionspell - 1
                        kl = 0
                        klf = 0
                CASE &H4D
                'right
                        kl = 0
                        klf = 0
                        changed = 1
                        selectionspellold = selectionspell
                        selectionspell = selectionspell + 1
        END SELECT
END IF
IF selectionspell < 1 THEN selectionspell = 1
IF selectionspellold = 48 AND selectionspell = 47 THEN selectionspell = 4
IF selectionspell > 4 THEN selectionspell = 48
IF changed = 1 THEN
        IF selectionspellold < 25 THEN LINE (selectionspellold * 12 - 1, 125)-(10 + selectionspellold * 12, 137), 0, B
        IF selectionspellold > 24 THEN LINE ((selectionspellold - 24) * 12 - 1, 138)-(10 + (selectionspellold - 24) * 12, 150), 0, B
changed = 0
END IF
IF selectionspell < 25 THEN LINE (selectionspell * 12 - 1, 125)-(10 + selectionspell * 12, 137), 31, B
IF selectionspell > 24 THEN LINE ((selectionspell - 24) * 12 - 1, 138)-(10 + (selectionspell - 24) * 12, 150), 31, B

IF INKEY$ = " " THEN selected = 1
IF kl = 0 THEN klf = klf + 1
IF klf > kc * 600 THEN kl = 1
LOOP

selected = 0

' see if they have enough mana
SELECT CASE selectionspell
        CASE 1
                IF mp < lev THEN manalack = 1
                IF magicmissle = 0 THEN spelllack = 1
        CASE 2
                IF mp < 1 THEN manalack = 1
                IF armor = 0 THEN spelllack = 1
        CASE 4
                IF mp < 3 THEN manalack = 1
                IF curelight = 0 THEN spelllack = 1
END SELECT
IF spelllack = 1 THEN
        spelllack = 0
        LINE (11, 125)-(310, 150), 0, BF
        LOCATE 17, 3
        PRINT "You do not have"
        LOCATE 18, 3
        PRINT "this spell."
                FOR sleepin = 1 TO sleeptime: NEXT
        LINE (11, 125)-(310, 150), 0, BF
        GOTO 300
END IF
IF manalack = 1 THEN
        manalack = 0
        LINE (11, 125)-(310, 150), 0, BF
        LOCATE 17, 3
        PRINT "Not enough mana."
                FOR sleepin = 1 TO sleeptime: NEXT
        LINE (11, 125)-(310, 150), 0, BF
        GOTO 300
END IF

'if mana is enough and spell is learned then carry out the spell

IF selectionspell = 1 THEN 'magic missle

        'draw fireballs
        x = 280
        y = 2
        DO
             x = x - 1 * 2
             y = y + .5 * 2
                        x10 = x - 13
                        Y10 = y + 3
                        x20 = x + 3
                        Y20 = y + 12

                        GET (INT(x), INT(y))-(INT(x) + 10, INT(y) + 10), burn
                        GET (INT(x10), INT(Y10))-(INT(x10) + 10, INT(Y10) + 10), burn2
                        GET (INT(x20), INT(Y20))-(INT(x20) + 10, INT(Y20) + 10), burn3
                        d = 0
                        DEF SEG = &HA000
                        FOR y2 = 1 TO 10
                        FOR x2 = 1 TO 10
                                d = d + 1
                                IF magmisc(d) <> 16 THEN POKE ((INT(x) + x2) + (INT(y) + y2) * 320), magmisc(d)
                                IF magmisc(d) <> 16 THEN POKE ((INT(x10) + x2) + (INT(Y10) + y2) * 320), magmisc(d)
                                IF magmisc(d) <> 16 THEN POKE ((INT(x20) + x2) + (INT(Y20) + y2) * 320), magmisc(d)
                        NEXT
                        NEXT
                        WAIT &H3DA, 8

                        PUT (INT(x), INT(y)), burn, PSET
                        PUT (INT(x10), INT(Y10)), burn2, PSET
                        PUT (INT(x20), INT(Y20)), burn3, PSET
        LOOP UNTIL x < 160

                expr = expr + 75 + 25 * lev   ' give some exprience for succesful spell casting
                mp = mp - lev                 'reduce mana based on the power of the spell

                'generate amount of damage
                mmdam = 0
                FOR th = 1 TO lev
                        mmrand = INT(RND * 4 + 1)
                        mmdam = mmdam + mmrand
                NEXT th

                monhp = monhp - mmdam     'do the monster the appropriate damage
                LINE (11, 125)-(310, 150), 0, BF
                LOCATE 17, 3
                PRINT "Your magic missle"
                LOCATE 18, 3
                PRINT "does"; mmdam; "damage."

                monturn = 1
                        FOR sleepin = 1 TO sleeptime: NEXT
END IF

'armor spell
IF selectionspell = 2 THEN

        IF armoron = 1 THEN
                LINE (11, 125)-(310, 150), 0, BF
                LOCATE 17, 3
                PRINT "You're already under the"
                LOCATE 18, 3
                PRINT "affect of this spell."
                        FOR sleepin = 1 TO sleeptime: NEXT
                LINE (11, 125)-(310, 150), 0, BF
                GOTO 300
        END IF
        IF armoron = 0 THEN
                mp = mp - 1
                ac = ac - 4
                armoron = 1
                LINE (11, 125)-(310, 150), 0, BF
                LOCATE 17, 3
                PRINT "You cast an armor spell."
                        FOR sleepin = 1 TO sleeptime: NEXT
                LINE (11, 125)-(310, 150), 0, BF

        END IF

END IF
'curelight
IF selectionspell = 4 THEN

                expr = expr + 200
                mp = mp - 3
                FOR thru = 1 TO lev
                        healp = (INT(RND * 6) + 1)
                        hp = hp + healp

                NEXT
                IF hp > mhp THEN hp = mhp


                LINE (11, 125)-(310, 150), 0, BF
                 LOCATE 17, 3
                PRINT "You heal "; healp; " hp."
                        FOR sleepin = 1 TO sleeptime: NEXT
                LINE (11, 125)-(310, 150), 0, BF


END IF

     LINE (11, 125)-(310, 150), 0, BF
END IF


' ITEM
IF selection = 3 THEN

        LINE (11, 125)-(310, 150), 0, BF
        items = healpot + sleeppot + refreshpot
        IF items > 54 THEN items = 54
                 d = 1

                FOR d = 1 TO 54   'clear previous items
                        item(d) = 0
                NEXT
                FOR d = 1 TO items

                        IF d <= healpot AND healpot > 0 THEN item(d) = 1
                        IF d > healpot AND sleeppot > 0 THEN item(d) = 2
                        IF d > healpot + sleeppot AND refreshpot > 0 THEN item(d) = 3
                        'IF d > healpot + sleepot + refreshpot THEN item(d) = 3
                        IF d = 1 AND healpot = 0 AND sleeppot = 0 AND refreshpot = 0 THEN item(d) = 0
                NEXT

        startx = 12
        starty = 126
                        OPEN "heal.dat" FOR INPUT AS #1

                                FOR d = 1 TO 100
                                 INPUT #1, healc(d)
                                NEXT
                        CLOSE

                        OPEN "sleep.dat" FOR INPUT AS #1

                                FOR d = 1 TO 100
                                 INPUT #1, sleepc(d)
                                NEXT
                        CLOSE
                        OPEN "refresh.dat" FOR INPUT AS #1

                                FOR d = 1 TO 100
                                 INPUT #1, refreshc(d)
                                NEXT
                        CLOSE

                        OPEN "none.dat" FOR INPUT AS #1

                                FOR d = 1 TO 100
                                 INPUT #1, none(d)
                                NEXT
                        CLOSE

                                  d = 0
                FOR y = starty TO starty + 13 STEP 13
                FOR x = startx TO startx * 24 STEP 12
                                d = d + 1
                                d2 = 0
                        FOR disy = y TO y + 9
                        FOR disx = x TO x + 9
                                d2 = d2 + 1
                                IF item(d) = 1 THEN PSET (disx, disy), healc(d2)
                                IF item(d) = 2 THEN PSET (disx, disy), sleepc(d2)
                                IF item(d) = 3 THEN PSET (disx, disy), refreshc(d2)
                                IF item(d) = 0 AND d = 48 THEN PSET (disx, disy), none(d2)

                        NEXT
                        NEXT

                NEXT
                NEXT

       ' SLEEP 3
selected = 0
selectionpot = 1
selectionpotold = 1
DO WHILE selected = 0
IF INKEY$ = " " THEN selected = 1
'load from keyboard
IF kl = 1 THEN
        kl = 0
        DEF SEG = 0: k = INP(&H60)
        WHILE LEN(INKEY$): WEND
        SELECT CASE k
                CASE &H4B
                'right
                        changed = 1
                        selectionpotold = selectionpot

                        IF selectionpot < 48 THEN selectionpot = selectionpot - 1
                        IF selectionpot = 48 THEN selectionpot = healpot + sleeppot + refreshpot
                        kl = 0
                        klf = 0
                CASE &H4D
                'left
                        kl = 0
                        klf = 0
                        changed = 1
                        selectionpotold = selectionpot
                        selectionpot = selectionpot + 1
        END SELECT
END IF
IF selectionpot > healpot + sleeppot + refreshpot THEN selectionpot = 48
IF selectionpot < 1 THEN selectionpot = 1
IF selectionpot > 48 THEN selectionpot = 48

IF changed = 1 THEN
        IF selectionpotold < 25 THEN LINE (selectionpotold * 12 - 1, 125)-(10 + selectionpotold * 12, 137), 0, B
        IF selectionpotold > 24 THEN LINE ((selectionpotold - 24) * 12 - 1, 138)-(10 + (selectionpotold - 24) * 12, 150), 0, B


changed = 0
END IF
IF selectionpot < 25 THEN LINE (selectionpot * 12 - 1, 125)-(10 + selectionpot * 12, 137), 31, B
IF selectionpot > 24 THEN LINE ((selectionpot - 24) * 12 - 1, 138)-(10 + (selectionpot - 24) * 12, 150), 31, B

IF INKEY$ = " " THEN selected = 1
IF kl = 0 THEN klf = klf + 1
IF klf > kc * 800 THEN kl = 1
LOOP

selected = 0

d = selectionpot



IF item(d) = 1 THEN
        healpot = healpot - 1
        hp = hp + mhp / 2
        IF hp > mhp THEN hp = mhp

END IF
IF item(d) = 2 THEN
        sleeppot = sleeppot - 1
        mp = mp + mmp / 2
        IF mp > mmp THEN mp = mmp
END IF
IF item(d) = 3 THEN
        refreshpot = refreshpot - 1
        hp = mhp
        mp = mmp
END IF

IF item(d) = 0 THEN
             LINE (11, 125)-(310, 150), 0, BF

        'GOTO 300
        selected = 0

END IF



     selected = 0



END IF



        LINE (11, 125)-(310, 150), 0, BF
END IF

'draw monster health

monhealthperc = (monhp / monmaxhp) * 100
xdismonhealth = monhealthperc / 2
IF gottenhp = 1 THEN PUT (130, 100), montemphp%, PSET
GET (130, 100)-(180, 100), montemphp%
gottenhp = 1
IF xdismonhealth > -1 THEN LINE (130, 100)-(130 + xdismonhealth, 100), 4
IF monhp < 1 THEN   'monster dead
        expr = expr + mlev * 175
        LOCATE 17, 3
        PRINT "                                   "
        LOCATE 18, 3
        PRINT "                                   "

        LOCATE 17, 3
        COLOR 4
        PRINT ""; monname$; " is dead."
        LOCATE 18, 3
        PRINT "You gained"; expr - oldexpr; " XP"

                FOR sleepin = 1 TO sleeptime: NEXT
        IF monster = 1 THEN dalive = 0
        IF monster = 2 THEN salive = 0
        IF monster = 4 THEN monalive(1) = 0
        IF monster = 3 THEN
        t = 1
        DO
        t = t + 1
        IF t > 5 THEN EXIT DO
        IF monalive(t) = 1 THEN
        monalive(t) = 0
        EXIT DO
        END IF

        LOOP
        END IF
        IF monster > 4 THEN wildalive(t) = 0

        IF monster > 2 THEN

                IF knife = 1 THEN

                        LINE (11, 125)-(310, 150), 0, BF
                         COLOR 14
                         LOCATE 17, 3

                         IF furtype$ <> "heads" THEN PRINT "You skin "; monname$; " for its"
                         LOCATE 17, 3
                         IF furtype$ = "heads" THEN
                                PRINT "You scalp your victim."

                                scalpcount = scalpcount + 1
                        END IF
                         LOCATE 18, 3
                         IF furtype$ <> "heads" THEN PRINT furtype$

                        IF monster > 4 THEN peltcount(monster - 4) = peltcount(monster - 4) + 1

                       'IF monster > 4 THEN gp = gp + (monster - 4) * 3

                END IF
        END IF

                FOR sleepin = 1 TO sleeptime: NEXT
        EXIT DO
END IF
LOOP
'get rid of memory allocation for this sub routine

ERASE blucurs
ERASE cursclear
ERASE item
ERASE healc
ERASE sleepc
ERASE refreshc
ERASE none
ERASE burn
ERASE burn2
ERASE burn3
ERASE magmisc
ERASE montemphp%






battletime = 1
initialload = 1
rpg = 1
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

