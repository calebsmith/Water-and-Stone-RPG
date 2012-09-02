REDIM peltcount(16)
REDIM monalive(10)

x = 0
y = 1
z$ = "Town1"

CLS
SCREEN 13
DEF SEG = &HA000
BLOAD "back_1.dis", 0
kc = 2000
c3 = 32
maxcc = 300
cc = maxcc + 1

DO
    ' animation w/ pallete

    cc = cc + 1
    c2 = c3
    IF cc > maxcc THEN
    cc = 0
    IF c3 = 79 THEN
            c3 = 176
            GOTO 160
    END IF
    IF c3 = 176 THEN
            c3 = 104
            GOTO 160
    END IF
    IF c3 = 104 THEN
            c3 = 1
            GOTO 160
    END IF
    IF c3 = 1 THEN
            c3 = 32
            GOTO 160
    END IF
    IF c3 = 32 THEN
            c3 = 55
            GOTO 160
    END IF
    IF c3 = 55 THEN
            c3 = 79
            GOTO 160
    END IF

    160
    OUT &H3C7, c3
    r = INP(&H3C9)
    g = INP(&H3C9)
    B = INP(&H3C9)
    WAIT &H3DA, 8
    OUT &H3C8, c2
    OUT &H3C9, r
    OUT &H3C9, g
    OUT &H3C9, B

    END IF










    'load from keyboard
    IF kl = 1 THEN
        kl = 0
        DEF SEG = 0: k = INP(&H60)
        WHILE LEN(INKEY$): WEND
        SELECT CASE k
            CASE &H39
                EXIT DO
            CASE &H1E
                EXIT DO
            CASE &H90
                selection = 3
            EXIT DO
            CASE &H50 'down
                selection = selection + 1
                kl = 0
                klf = 0
            CASE &H48 'up
                kl = 0
                klf = 0
                selection = selection - 1
        END SELECT
    END IF

    IF kl = 0 THEN klf = klf + 1

    IF klf > kc THEN kl = 1

    IF selection > 3 THEN selection = 3
    IF selection < 1 THEN selection = 1


    IF selection = 1 THEN LINE (107, 117)-(113, 123), 15, BF
    IF selection = 2 THEN LINE (107, 147)-(113, 153), 15, BF
    IF selection = 3 THEN LINE (107, 177)-(113, 183), 15, BF
    IF selection <> 1 THEN LINE (107, 117)-(113, 123), 0, BF
    IF selection <> 2 THEN LINE (107, 147)-(113, 153), 0, BF
    IF selection <> 3 THEN LINE (107, 177)-(113, 183), 0, BF

LOOP

IF selection = 1 THEN
        IF battletime = 0 THEN
        stoptime = 500000
        CLS
        SCREEN 13
        DEF SEG = &HA000
        BLOAD "back_11.dis", 0
        LINE (30, 30)-(290, 150), 0, BF
        LINE (29, 29)-(291, 151), 31, B
        COLOR 28
        LOCATE 5, 5
        PRINT "Our story begins in the quaint"
        LOCATE , 5
        PRINT "town of Neshkel. You come back"
        LOCATE , 5
        PRINT "one morning from a week of"
        LOCATE , 5
        PRINT "hunting in the wilderness to"
        LOCATE , 5
        PRINT "discover that your father has"
        LOCATE , 5
        PRINT "been brutally murdered. You set"
        LOCATE , 5
        PRINT "out to find the truth..."
        PRINT ""
        LOCATE , 5
        PRINT "         Good luck!"
        LOCATE 18, 5
        PRINT "Press any key to continue."
        FOR t = 1 TO stoptime: NEXT t
        SLEEP
        END IF





        xpl = 16: ypl = 5: xpl3 = 18: ypl3 = 12
        weapon$ = "nothing"
        lev = 1: expr = 0: hp = 8
        start$ = "Town1"
        mp = 1: mv = 100: gp = 100: ac = 10
        ans1 = 0: movf = 175


        talked2 = 0: talked3 = 0: returned = 0
        knife = 0: reward = 0: rope = 0: aqua = 0
        armor = 0: curelight = 0: magicmissle = 0: createwater = 0: watown = 0
        coldprot = 0: recallscroll = 0: healpot = 1: sleeppot = 0: refreshpot = 0
        dalive = 2: salive = 1
        greeter = 1
        initialload = 1
        spellbitv = 0
                FOR d = 1 TO 11
                         peltcount(d) = 0
                NEXT
                FOR d = 1 TO 5
                        monalive(d) = 1    'make them all alive(as opposed to dead)
                NEXT


battletime = 1
initialload = 0


END IF

IF selection = 3 THEN SYSTEM
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


OPEN "temp3.dat" FOR OUTPUT AS #1
PRINT #1, selection
CLOSE


CHAIN "main.exe"

