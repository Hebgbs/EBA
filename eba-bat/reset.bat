@ECHO OFF

CD %~dp0 > NUL 2>&1
CD .. > NUL 2>&1
CD gfx > NUL 2>&1
ECHO Undoing changes to fxpage1.bmp
REN Fxpage1.bmp EBAFxpage1.bmp > NUL 2>&1
ECHO Making stock fxpage1 usable
DEL /Q Fxpage1.bmp > NUL 2>&1
REN PreEBAFxpage1.bmp Fxpage1.bmp > NUL 2>&1
CD %~dp0 > NUL 2>&1
CD .. > NUL 2>&1
CD models > NUL 2>&1
ECHO Undoing changes to beachball.m
DEL /Q beachball.m
ECHO Making stock beachball.m usable
REN PreEBAbeachball.m beachball.m
CD %~dp0 > NUL 2>&1
CD .. > NUL 2>&1
CD cars\misc > NUL 2>&1
ECHO Undoing changes to aerial files
REN Aerial.m EBAAerial.m
REN Aerialt.m EBAAerialt.m
DEL /Q Aerial* > NUL 2>&1
ECHO Making stock aerial files usable
REN PreEBAAerial.m Aerial.m
REN PreEBAAerialt.m Aerialt.m
