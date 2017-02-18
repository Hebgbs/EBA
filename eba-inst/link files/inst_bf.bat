@ECHO OFF

CD %~dp0 > NUL 2>&1
CD .. > NUL 2>&1
CD .. > NUL 2>&1
ECHO Doing initial setup
CALL eba-bat\init.bat
CD %~dp0 > NUL 2>&1
CD .. > NUL 2>&1
CD .. > NUL 2>&1
ECHO Linking EBA aerials for IBA compatibiility
CALL eba-bat\ln.bat
CD %~dp0 > NUL 2>&1
CD .. > NUL 2>&1
ECHO Setting up beachball (blockfix)
CALL eba-bat\ln_ballconf_bf.bat
ECHO --^> To use scalefix after, do sh eba-bat\ln_ballconf_bf.bat
CD ..
