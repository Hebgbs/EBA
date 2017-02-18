@ECHO OFF

CD %~dp0
CD ..
CD gfx
ECHO Deleting old fxpage1.bmp if it exists...
DEL /Q oldFxpage1.bmp
ECHO Saving present fxpage1.bmp (as oldfxpage1.bmp)...
REN Fxpage1.bmp oldFxpage1.bmp
ECHO Making ebafxpage1.bmp usable in-game
REN EBAFxpage1.bmp Fxpage1.bmp
