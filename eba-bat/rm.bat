@ECHO OFF

CD %~dp0 > NUL 2>&1
CD .. > NUL 2>&1
CD gfx > NUL 2>&1
DEL /Q Fxpage1.bmp
DEL /Q EBAFxpage1.bmp
REN PreEBAFxpage1.bmp Fxpage1.bmp
CD %~dp0 > NUL 2>&1
CD .. > NUL 2>&1
CD models > NUL 2>&1
DEL /Q beachball.m
DEL /Q sfbeachball.m
DEL /Q bfbeachball.m
REN PreEBAbeachball.m beachball.m
CD %~dp0 > NUL 2>&1
CD .. > NUL 2>&1
CD cars\misc > NUL 2>&1
DEL /Q Aerial*
DEL /Q EBA*
REN PreEBAAerial.m Aerial.m
REN PreEBAAerialt.m Aerialt.m
CD ..
CD ..
