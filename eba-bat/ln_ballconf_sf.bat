@ECHO OFF

CD %~dp0 > NUL 2>&1
CD .. > NUL 2>&1
CD models > NUL 2>&1
DEL /Q beachball.m > NUL 2>&1
MKLINK /H beachball.m sfbeachball.m > NUL 2>&1
