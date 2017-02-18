@ECHO OFF

CD %~dp0 > NUL 2>&1
CD .. > NUL 2>&1
CD gfx > NUL 2>&1
REN Fxpage1.bmp PreEBAFxpage1.bmp
CD %~dp0 > NUL 2>&1
CD .. > NUL 2>&1
CD models > NUL 2>&1
REN beachball.m PreEBAbeachball.m
CD %~dp0 > NUL 2>&1
CD .. > NUL 2>&1
CD cars\misc > NUL 2>&1
REN Aerial.m PreEBAAerial.m
REN Aerialt.m PreEBAAerialt.m
DEL /Q Aerial* > NUL 2>&1