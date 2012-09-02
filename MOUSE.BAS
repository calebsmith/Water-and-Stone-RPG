'Future.Library Mouse Support
'

REM $INCLUDE: 'future.bi'

Set640x400 8'set 640x400 svga screen

FOR i% = 0 TO 255 'copy mouse shape DATA into a string
READ C%
C$ = C$ + CHR$(C%)
NEXT

Future.MouseShape SADD(C$), SSEG(C$)'parse DATA string to the mouse

SetMouseMaskColor 0 'set transparent color to 0

Future.MouseOn 'turn on svga mouse

DO
Future.PRINT 0, 0, "Pos X:" + STR$(Future.MouseX) + " ", 1, 0
Future.PRINT 0, 16, "Pos Y:" + STR$(Future.MouseY) + " ", 2, 0
Future.PRINT 0, 32, "ButtonL:" + STR$((Future.MouseB AND 1) = 1) + " ", 4, 0
Future.PRINT 0, 48, "ButtonR:" + STR$((Future.MouseB AND 2) = 2) + " ", 5, 0
Future.UpdateMouse      'update mouse
LOOP UNTIL INKEY$ = CHR$(27)

Future.MouseOff 'turn off svga mouse
ResetScreen 'set the screen back in text mode


'Cursor data
DATA 1,1,0,0,0,0,0,15,15,0,0,0,0,0,4,4
DATA 1,1,0,0,0,0,15,9,7,15,0,0,0,0,4,4
DATA 0,0,0,0,0,15,0,9,7,0,15,0,0,0,0,0
DATA 0,0,0,0,15,0,0,9,7,0,0,15,0,0,0,0
DATA 0,0,0,15,0,0,0,9,7,0,0,0,15,0,0,0
DATA 0,0,15,0,0,0,0,9,7,0,0,0,0,15,0,0
DATA 0,15,0,0,0,0,0,9,7,0,0,0,0,0,15,0
DATA 15,6,6,6,6,6,6,9,6,6,6,6,6,6,6,15
DATA 15,8,8,8,8,8,8,8,7,8,8,8,8,8,8,15
DATA 0,15,0,0,0,0,0,9,7,0,0,0,0,0,15,0
DATA 0,0,15,0,0,0,0,9,7,0,0,0,0,15,0,0
DATA 0,0,0,15,0,0,0,9,7,0,0,0,15,0,0,0
DATA 0,0,0,0,15,0,0,9,7,0,0,15,0,0,0,0
DATA 0,0,0,0,0,15,0,9,7,0,15,0,0,0,0,0
DATA 2,2,0,0,0,0,15,9,7,15,0,0,0,0,3,3
DATA 2,2,0,0,0,0,0,15,15,0,0,0,0,0,3,3


