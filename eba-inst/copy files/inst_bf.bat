@ECHO OFF

CD %~dp0 > NUL 2>&1
CD .. > NUL 2>&1
CD .. > NUL 2>&1
ECHO Doing initial setup
CALL eba-bat\init.bat
CD %~dp0 > NUL 2>&1
CD .. > NUL 2>&1
CD .. > NUL 2>&1
ECHO Copying EBA aerials for IBA compatibiility
CALL eba-bat\cp.bat
CD %~dp0 > NUL 2>&1
CD .. > NUL 2>&1
ECHO Setting up beachball (blockfix)
CALL eba-bat\cp_ballconf_bf.bat
ECHO --^> To use scalefix after, do eba-bat\cp_ballconf_bf.bat
CD ..
