'rpg talking and scripting handler.
REDIM peltcount(15)
REDIM saying$(50)
REDIM choice$(4)
REDIM newperson(4)

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
DEF SEG = &HA000
BLOAD "gmeback2.dis", 0
sleeptime = 1500000
6926
FOR crap = 1 TO sleeptime / 3: NEXT

done = 1
COLOR 15
currentprint = 1

IF person > 0 THEN
        OPEN "talking.dat" FOR INPUT AS #1
3065
                DO
                    INPUT #1, number$
                    IF number$ = "====" THEN
                        CLOSE
                        GOTO 589
                    END IF
                LOOP UNTIL VAL(number$) = person
                INPUT #1, nextthing$
                IF nextthing$ <> "&" THEN goto 3065

                INPUT #1, persontalking
                ' load what they say
                FOR printing = 1 TO 90
                    INPUT #1, saying$(printing)
                    IF saying$(printing) = "^" THEN
                            printmax = printing
                            GOTO 567
                    END IF

                NEXT

567
        CLOSE
568

LINE (10, 10)-(270, 180), 15, B
LINE (11, 11)-(269, 179), 0, BF
filetoget$ = "NOTHING"  'in case it messes up, load nothing
SELECT CASE persontalking
    CASE 0: filetoget$ = "char1.dat"
    CASE 1: filetoget$ = "char2.dat"
    CASE 2: filetoget$ = "char2.dat"
    CASE 3: filetoget$ = "char6.dat"
    CASE 4: filetoget$ = "char7.dat"
    CASE 5: filetoget$ = "char8.dat"
    CASE 6: filetoget$ = "char9.dat"
END SELECT
    IF filetoget$ <> "NOTHING" THEN
    OPEN filetoget$ FOR INPUT AS #1
        FOR y = 1 TO 10
        FOR x = 1 TO 10

            INPUT #1, drawc
            PSET (x + 100, y + 11), drawc

        NEXT x
        NEXT y
    CLOSE
    END IF

    printy = 3
    FOR printing = currentprint TO currentprint + 9
            printy = printy + 1
            LOCATE printy, 3
            IF saying$(printing) <> "^" THEN PRINT saying$(printing)
            IF saying$(printing) = "^" OR saying$(printing + 1) = "^" THEN
                    currentprint = printmax + 1
                    GOTO 190
            END IF
    NEXT
190
        IF person < 499 THEN ' if it is a one way conversation
                IF currentprint < printmax THEN
                        LOCATE 16, 4
                        PRINT "Continue"
                        LOCATE 17, 4
                        PRINT "Stop"
                END IF

                IF currentprint >= printmax THEN

                                LOCATE 16, 4
                                PRINT "Resume game"

                END IF
        END IF
END IF
IF person > 499 THEN

        OPEN "talking.dat" FOR INPUT AS #1'get to the right segment
                DO
4078
                        INPUT #1, dataseg$
                        if dataseg$ = "====" THEN
                            CLOSE
                            GOTO 589
                        END IF
                        IF person = VAL(dataseg$) THEN
                                        INPUT #1, dataseg$
                                        IF dataseg$ <> "&" THEN GOTO 4078
                                DO
                                        INPUT #1, dataseg$

                                        IF dataseg$ = "^" THEN GOTO 3098

                                LOOP
                        END IF
                LOOP
3098


        'now we're reading the right part for choices so begin printing choices
                INPUT #1, maxchoice
                g = 0
                'clear old data
                FOR g = 1 TO 4
                        choice$(g) = ""
                        newperson(g) = 0
                NEXT
                FOR g = 1 TO maxchoice

                        INPUT #1, choice$(g)
                        INPUT #1, newperson(g)
                        IF dataseg$ = "*" THEN EXIT FOR
                NEXT
        CLOSE
        'remline later to add more possible choices
        'maxchoice = 2
        FOR g = 1 TO maxchoice
                LOCATE 15 + g, 4
                PRINT choice$(g)
        NEXT g

END IF

'load from keyboard
        DO


        IF kl = 1 THEN
                kl = 0
                DEF SEG = 0: k = INP(&H60)
                WHILE LEN(INKEY$): WEND
                SELECT CASE k
                CASE &HB9
                'nothing
                nospace = 0
                CASE &H50
                'down
                gselection = gselection + 1

                kl = 0
                klf = 0
                CASE &H48
                'up
                kl = 0
                klf = 0

                gselection = gselection - 1
                CASE &H39
                'space key
                IF nospace = 0 THEN
                        nospace = 1
                        EXIT DO
                END IF
                END SELECT
        END IF
        IF kl = 0 THEN klf = klf + 1
        IF klf > kc THEN kl = 1

        IF gselection > 2 THEN gselection = 2
        IF gselection < 1 THEN gselection = 1
 IF person < 500 THEN
        IF currentprint > printmax THEN gselection = 1

 END IF
IF person > 499 AND maxchoice = 1 THEN gselection = 1

IF gselection = 1 THEN LINE (15, 120)-(20, 125), 15, BF
IF gselection = 2 THEN LINE (15, 129)-(20, 134), 15, BF
IF gselection <> 1 THEN LINE (15, 120)-(20, 125), 0, BF
IF gselection <> 2 THEN LINE (15, 129)-(20, 134), 0, BF

LOOP
IF person < 500 THEN
        IF gselection = 1 THEN
                IF currentprint <= printmax THEN
                        currentprint = currentprint + 10
                        GOTO 568
                        ELSE
                                GOTO 589
                END IF
        END IF
END IF
IF person > 499 THEN
        IF gselection = 1 THEN person = newperson(1)
        IF gselection = 2 THEN person = newperson(2)
        IF person = 0 THEN GOTO 589
        nospace = 1
        GOTO 6926
END IF



589
ERASE saying$

battletime = 1
initialload = 1
greeter = 0
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