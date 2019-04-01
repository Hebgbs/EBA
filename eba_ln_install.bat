@ECHO OFF
CD %~dp0
REM | Program files check; Only important for people who installed retail copy to default path.
IF EXIST "%programfiles(x86)%" SET prgm="%programfiles(x86)%"
IF NOT EXIST "%programfiles(x86)%" SET prgm="%programfiles%"
REM | !!! Don't forget to use %pgrm% for program files; x86_64 Windows users have two!

REM | User-adjustable paremetres
REM | !!! For the end-user. Encourage them to play with this if necessary.
REM | If you are the end-user, hi! Nice to see you. There is no need for you
REM | to touch anything after line 24 if the developer wrote everything correctly.
SET des_ln=%prgm%\Acclaim\Re-Volt
REM | ----------------------------------
REM | End of user-adjustable paremetres.
REM | Begin developer parametres.
REM | ----------------------------------
REM | Exit behaviour; Change this to include /b if you want cmd to remain open. Useful for development.
SET exitCmd=EXIT /b

ECHO Requesting for administrative privileges...
cd /d "%~dp0" && (if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs") && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit )
ECHO.
ECHO Privileges received!
ECHO.
IF NOT EXIST %~dp0\.installed GOTO eba_ln_init
IF EXIST %~dp0\.installed GOTO eba_modinst

:eba_modinst
ECHO What would you like to do?
ECHO.
ECHO 1. Update aerials
ECHO 2. Replace Beachball
ECHO 3. Completely remove EBA mods
ECHO.
CHOICE /N /C:123 /M "Selection: "
IF ERRORLEVEL 1 SET MOD=1
IF ERRORLEVEL 2 SET MOD=2
IF ERRORLEVEL 3 SET MOD=3
IF %MOD%==1 GOTO eba_upd
IF %MOD%==2 GOTO bbupd
IF %MOD%==3 GOTO eba_rm

:eba_upd
ECHO.
ECHO Updating aerials...
ECHO -------------------
CALL :eba_A
ECHO.
ECHO Update FxPage1.bmp?
ECHO Note: Any manual changes you've made will be superseded.
ECHO       If you manually copied Fxpage1.bmp, you may want to edit it yourself.
ECHO.
CHOICE /N /C:yn /M "[Y/n]: "
IF ERRORLEVEL 1 SET FX1=Y
IF ERRORLEVEL 2 SET FX1=N
IF %FX1%==Y CALL :eba_G
IF %FX1%==N GOTO fin_ln

GOTO fin_ln

:bbupd
COPY NUL > %~dp0\.bbupd
GOTO bbmenu

:eba_ln_init
ECHO This script will install via links assets for ElectricBee's Aerials.
ECHO Note: This script will back up original content affected for removal.
ECHO       This will also remove assets for Iron Bob's Aerials.
ECHO.
ECHO To continue, press any key.
PAUSE > NUL
CLS
ECHO Model object behaviour
ECHO ----------------------
ECHO Depending on partition configuration, you may want to choose
ECHO one option over another. What each option does is explained below.
ECHO.
ECHO 1. Create symbolic links
ECHO    These will reference absolute file path.
ECHO 2. Create hard links
ECHO    These will reference NTFS file index.
ECHO.
ECHO Option 2 requires all files to be on the same NTFS partition. If you
ECHO are not sure about this, select option 1; it is compatible on more
ECHO partition configurations, but will break if source files are moved.
ECHO.
CHOICE /N /C:12 /M "Selection: "
IF ERRORLEVEL 1 SET LNB=1
IF ERRORLEVEL 2 SET LNB=2
IF %LNB%==1 SET mln=MKLINK
IF %LNB%==2 SET mln=MKLINK /h

:bbmenu
CLS
ECHO Beachball selection
ECHO -------------------
ECHO There are two types of beachball included with the ElectricBee's
ECHO Aerials pack which use zero-point mapping to resolve colour issues
ECHO with the original beachball; Options explained below:
ECHO.
ECHO 1. Blockfix
ECHO    Remapped and End-user customizable by modifying FxPage1.bmp
ECHO 2. Scalefix
ECHO    Maps to different, non-customizable areas of FxPage1.bmp.
ECHO.
ECHO Blockfix beachball can be coloured to preference by modifying the
ECHO small island of colour at the bottom right of FxPage1.bmp.
ECHO.
CHOICE /N /C:12 /M "Selection: "
IF ERRORLEVEL 1 SET PBB=1
IF ERRORLEVEL 2 SET PBB=2
IF %PBB%==1 SET bbfix=blockfix.m
IF %PBB%==2 SET bbfix=scalefix.m

IF EXIST %~dp0\.bbupd GOTO eba_onlybb
IF NOT EXIST %~dp0\.bbbupd GOTO eba_rdy

:eba_onlybb
ECHO.
ECHO Updating beachball...
ECHO ---------------------
CALL :eba_B
DEL %~dp0\.bbupd
GOTO fin_ln

:eba_rdy
CLS
ECHO Behaviours selected. Press any key to proceed.
ECHO (Alternatively, close this window or hold [Ctrl] and press C to break script.)
PAUSE > NUL
CLS
GOTO msg_ln
:msg_ln
IF EXIST %~dp0\.installed (
  COPY NUL > %~dp0\.remove
  ECHO.
  ECHO Removing assets
  ECHO ------------------
  GOTO do_ln
)
IF NOT EXIST ~%dp0\.installed (
  ECHO Writing assets
  ECHO -----------------
  GOTO do_ln
)

:do_ln
CALL :eba_A
CALL :eba_B
CALL :eba_G
IF NOT EXIST %~dp0\.installed COPY NUL > %~dp0\.installed
GOTO fin_ln

:eba_A
SET src_eba=%~dp0\Aerials
SET des_eba=%des_ln%\cars\misc
IF EXIST %~dp0\.remove (
  ECHO Restoring stock aerial...
  DEL /q %des_eba%\Aerial*.m
  DEL /q %des_eba%\eba*.m
  REN %des_eba%\Aerial.old Aerial.m
  REN %des_eba%\AerialT.old AerialT.m
  EXIT /b
)
IF NOT EXIST %~dp0\.remove (
  ECHO Renaming stock aerials...
  IF NOT EXIST %des_eba%\Aerial.old REN %des_eba%\Aerial.m Aerial.old
  IF NOT EXIST %des_eba%\AerialT.old REN %des_eba%\AerialT.m AerialT.old
  ECHO Deleting Iron Bob's aerials ^(if applicable^)...
  DEL /q %des_eba%\Aerial*.m > NUL 2>&1
  DEL /q %des_eba%\eba*.m > NUL 2>&1
  ECHO Populating replacement IBA files via mklink...
  %mln% %des_eba%\Aerial.m %src_eba%\EBAAerial.m
  %mln% %des_eba%\AerialT.m %src_eba%\EBAAerialt.m
  %mln% %des_eba%\AerialA.m %src_eba%\EBAs-FF8000.m
  %mln% %des_eba%\AerialTA.m %src_eba%\EBAt-101010.m
  %mln% %des_eba%\AerialB.m %src_eba%\EBAs-00FF00.m
  %mln% %des_eba%\AerialTB.m %src_eba%\EBAt-101010.m
  %mln% %des_eba%\AerialC.m %src_eba%\EBAs-FFFF00.m
  %mln% %des_eba%\AerialTC.m %src_eba%\EBAt-101010.m
  %mln% %des_eba%\AerialD.m %src_eba%\EBAs-2020FF.m
  %mln% %des_eba%\AerialTD.m %src_eba%\EBAt-101010.m
  %mln% %des_eba%\AerialE.m %src_eba%\EBAs-910404.m
  %mln% %des_eba%\AerialTE.m %src_eba%\EBAt-101010.m
  %mln% %des_eba%\AerialF.m %src_eba%\EBAs-FFFFFF.m
  %mln% %des_eba%\AerialTF.m %src_eba%\EBAt-101010.m
  %mln% %des_eba%\AerialG.m %src_eba%\EBAs-FF00C4.m
  %mln% %des_eba%\AerialTG.m %src_eba%\EBAt-101010.m
  %mln% %des_eba%\AerialH.m %src_eba%\EBAAerial.m
  %mln% %des_eba%\AerialTH.m %src_eba%\EBAt-FF8000.m
  %mln% %des_eba%\AerialI.m %src_eba%\EBAAerial.m
  %mln% %des_eba%\AerialTI.m %src_eba%\EBAt-00FF00.m
  %mln% %des_eba%\AerialJ.m %src_eba%\EBAAerial.m
  %mln% %des_eba%\AerialTJ.m %src_eba%\EBAt-FFFF00.m
  %mln% %des_eba%\AerialK.m %src_eba%\EBAAerial.m
  %mln% %des_eba%\AerialTK.m %src_eba%\EBAt-2020FF.m
  %mln% %des_eba%\AerialL.m %src_eba%\EBAAerial.m
  %mln% %des_eba%\AerialTL.m %src_eba%\EBAt-FFFFFF.m
  %mln% %des_eba%\AerialM.m %src_eba%\EBAAerial.m
  %mln% %des_eba%\AerialTM.m %src_eba%\EBAt-FF00C4.m
  %mln% %des_eba%\AerialN.m %src_eba%\EBAs-FFFFFF.m
  %mln% %des_eba%\AerialTN.m %src_eba%\EBAt-FF8000.m
  %mln% %des_eba%\AerialO.m %src_eba%\EBAs-FFFFFF.m
  %mln% %des_eba%\AerialTO.m %src_eba%\EBAt-00FF00.m
  %mln% %des_eba%\AerialP.m %src_eba%\EBAs-FFFFFF.m
  %mln% %des_eba%\AerialTP.m %src_eba%\EBAt-FFFF00.m
  %mln% %des_eba%\AerialQ.m %src_eba%\EBAs-FFFFFF.m
  %mln% %des_eba%\AerialTQ.m %src_eba%\EBAt-2020FF.m
  %mln% %des_eba%\AerialR.m %src_eba%\EBAs-FFFFFF.m
  %mln% %des_eba%\AerialTR.m %src_eba%\EBAt-EBAAerialt.m
  %mln% %des_eba%\AerialS.m %src_eba%\EBAs-FFFFFF.m
  %mln% %des_eba%\AerialTS.m %src_eba%\EBAt-FF00C4.m
  ECHO Populating EBA aerials via mklink...
  %mln% %des_eba%\EBAs-C0C0C0.m %src_eba%\EBAs-C0C0C0.m
  %mln% %des_eba%\EBAt-C0C0C0.m %src_eba%\EBAt-C0C0C0.m
  %mln% %des_eba%\EBAs-00FFFF.m %src_eba%\EBAs-00FFFF.m
  %mln% %des_eba%\EBAt-00FFFF.m %src_eba%\EBAt-00FFFF.m
  %mln% %des_eba%\EBAs-8000FF.m %src_eba%\EBAs-8000FF.m
  %mln% %des_eba%\EBAt-8000FF.m %src_eba%\EBAt-8000FF.m
  %mln% %des_eba%\EBAs-0080FF.m %src_eba%\EBAs-0080FF.m
  %mln% %des_eba%\EBAt-0080FF.m %src_eba%\EBAt-0080FF.m
  %mln% %des_eba%\EBAs-FF0000.m %src_eba%\EBAs-FF0000.m
  %mln% %des_eba%\EBAt-FF0000.m %src_eba%\EBAt-FF0000.m
  %mln% %des_eba%\EBAs-01AEF0.m %src_eba%\EBAs-01AEF0.m
  %mln% %des_eba%\EBAt-01AEF0.m %src_eba%\EBAt-01AEF0.m
  %mln% %des_eba%\EBAs-F68121.m %src_eba%\EBAs-F68121.m
  %mln% %des_eba%\EBAt-F68121.m %src_eba%\EBAt-F68121.m
  %mln% %des_eba%\EBAs-C3FFAB.m %src_eba%\EBAs-C3FFAB.m
  %mln% %des_eba%\EBAt-C3FFAB.m %src_eba%\EBAt-C3FFAB.m
  %mln% %des_eba%\EBAs-804000.m %src_eba%\EBAs-804000.m
  %mln% %des_eba%\EBAt-804000.m %src_eba%\EBAt-804000.m
  %mln% %des_eba%\EBAs-BA1515.m %src_eba%\EBAs-BA1515.m
  %mln% %des_eba%\EBAt-BA1515.m %src_eba%\EBAt-BA1515.m
  %mln% %des_eba%\EBAs-B6BCF4.m %src_eba%\EBAs-B6BCF4.m
  %mln% %des_eba%\EBAt-B6BCF4.m %src_eba%\EBAt-B6BCF4.m
  %mln% %des_eba%\EBAs-FFBF40.m %src_eba%\EBAs-FFBF40.m
  %mln% %des_eba%\EBAt-FFBF40.m %src_eba%\EBAt-FFBF40.m
  %mln% %des_eba%\EBAs-402000.m %src_eba%\EBAs-402000.m
  %mln% %des_eba%\EBAt-402000.m %src_eba%\EBAt-402000.m
  %mln% %des_eba%\EBAs-BFBFBF.m %src_eba%\EBAs-BFBFBF.m
  %mln% %des_eba%\EBAt-BFBFBF.m %src_eba%\EBAt-BFBFBF.m
  %mln% %des_eba%\EBAs-FF6000.m %src_eba%\EBAs-FF6000.m
  %mln% %des_eba%\EBAt-FF6000.m %src_eba%\EBAt-FF6000.m
  %mln% %des_eba%\EBAs-BF7F40.m %src_eba%\EBAs-BF7F40.m
  %mln% %des_eba%\EBAt-BF7F40.m %src_eba%\EBAt-BF7F40.m
  %mln% %des_eba%\EBAs-40BF80.m %src_eba%\EBAs-40BF80.m
  %mln% %des_eba%\EBAt-40BF80.m %src_eba%\EBAt-40BF80.m
  %mln% %des_eba%\EBAs-BF0000.m %src_eba%\EBAs-BF0000.m
  %mln% %des_eba%\EBAt-BF0000.m %src_eba%\EBAt-BF0000.m
  %mln% %des_eba%\EBAs-BF6000.m %src_eba%\EBAs-BF6000.m
  %mln% %des_eba%\EBAt-BF6000.m %src_eba%\EBAt-BF6000.m
  %mln% %des_eba%\EBAs-BFBF00.m %src_eba%\EBAs-BFBF00.m
  %mln% %des_eba%\EBAt-BFBF00.m %src_eba%\EBAt-BFBF00.m
  %mln% %des_eba%\EBAs-00BF00.m %src_eba%\EBAs-00BF00.m
  %mln% %des_eba%\EBAt-00BF00.m %src_eba%\EBAt-00BF00.m
  %mln% %des_eba%\EBAs-00BFBF.m %src_eba%\EBAs-00BFBF.m
  %mln% %des_eba%\EBAt-00BFBF.m %src_eba%\EBAt-00BFBF.m
  %mln% %des_eba%\EBAs-0000BF.m %src_eba%\EBAs-0000BF.m
  %mln% %des_eba%\EBAt-0000BF.m %src_eba%\EBAt-0000BF.m
  %mln% %des_eba%\EBAs-3060BF.m %src_eba%\EBAs-3060BF.m
  %mln% %des_eba%\EBAt-3060BF.m %src_eba%\EBAt-3060BF.m
  %mln% %des_eba%\EBAs-6000BF.m %src_eba%\EBAs-6000BF.m
  %mln% %des_eba%\EBAt-6000BF.m %src_eba%\EBAt-6000BF.m
  %mln% %des_eba%\EBAs-454545.m %src_eba%\EBAs-454545.m
  %mln% %des_eba%\EBAt-454545.m %src_eba%\EBAt-454545.m
  %mln% %des_eba%\EBAs-4C4C4C.m %src_eba%\EBAs-4C4C4C.m
  %mln% %des_eba%\EBAt-4C4C4C.m %src_eba%\EBAt-4C4C4C.m
  %mln% %des_eba%\EBAs-686868.m %src_eba%\EBAs-686868.m
  %mln% %des_eba%\EBAt-686868.m %src_eba%\EBAt-686868.m
  %mln% %des_eba%\EBAs-727272.m %src_eba%\EBAs-727272.m
  %mln% %des_eba%\EBAt-727272.m %src_eba%\EBAt-727272.m
  %mln% %des_eba%\EBAs-E6C033.m %src_eba%\EBAs-E6C033.m
  %mln% %des_eba%\EBAt-E6C033.m %src_eba%\EBAt-E6C033.m
  %mln% %des_eba%\EBAs-63F741.m %src_eba%\EBAs-63F741.m
  %mln% %des_eba%\EBAt-63F741.m %src_eba%\EBAt-63F741.m
  %mln% %des_eba%\EBAs-0C18C8.m %src_eba%\EBAs-0C18C8.m
  %mln% %des_eba%\EBAt-0C18C8.m %src_eba%\EBAt-0C18C8.m
  %mln% %des_eba%\EBAs-0B4350.m %src_eba%\EBAs-0B4350.m
  %mln% %des_eba%\EBAt-0B4350.m %src_eba%\EBAt-0B4350.m
  %mln% %des_eba%\EBAs-D38A00.m %src_eba%\EBAs-D38A00.m
  %mln% %des_eba%\EBAt-D38A00.m %src_eba%\EBAt-D38A00.m
  %mln% %des_eba%\EBAs-0000FF.m %src_eba%\EBAs-0000FF.m
  %mln% %des_eba%\EBAt-0000FF.m %src_eba%\EBAt-0000FF.m
  %mln% %des_eba%\EBAs-FFC200.m %src_eba%\EBAs-FFC200.m
  %mln% %des_eba%\EBAt-FFC200.m %src_eba%\EBAt-FFC200.m
  %mln% %des_eba%\EBAt-rainbowCCW.m %src_eba%\EBAt-rainbowCCW.m
  %mln% %des_eba%\EBAt-rainbowCW.m %src_eba%\EBAt-rainbowCW.m
  EXIT /b
)
:eba_B
SET src_eba=%~dp0\Beachballs
SET des_eba=%des_ln%\models
IF EXIST %~dp0\.remove (
  ECHO Restoring stock beachball...
  DEL %des_eba%\beachball.m
  REN %des_eba%\beachball.old beachball.m
  EXIT /b
)
IF NOT EXIST %~dp0\.remove (
  IF EXIST %des_eba%\beachball.old DEL %des_eba%\beachball.m
  ECHO Applying selected beachball fix...
  IF NOT EXIST %des_eba%\beachball.old REN %des_eba%\beachball.m beachball.old
  %mln% %des_eba%\beachball.m %src_eba%\%bbfix%
  EXIT /b
)
:eba_G
SET src_eba=%~dp0\EBAgfx
SET des_eba=%des_ln%\gfx
IF EXIST %~dp0\.remove (
  ECHO Restoring stock texture map...
  DEL %des_eba%\FxPage1.bmp
  REN %des_eba%\FxPage1.old FxPage1.bmp
  EXIT /b
)
IF NOT EXIST %~dp0\.remove (
  IF EXIST %des_eba%\FxPage1.old DEL %des_eba%\FxPage1.bmp
  ECHO Applying replacement texture map...
  IF NOT EXIST %des_eba%\FxPage1.old REN %des_eba%\FxPage1.bmp FxPage1.old
  %mln% %des_eba%\FxPage1.bmp %src_eba%\FxPage1.bmp
  EXIT /b
)

:eba_rm
ECHO.
ECHO This script will REMOVE the symbolic links originally created
ECHO by the file linking routine previously executed through it.
ECHO.
ECHO If you wish to continue, press any key now.
ECHO Otherwise, hold [Ctrl] and press C to break script,
ECHO or close this window.
PAUSE > NUL
GOTO msg_ln

:fin_ln
ECHO.
ECHO Finished! Run Re-Volt and select any affected vehicle to see your changes!
ECHO Press any key to exit this script.
IF EXIST %~dp0\.remove (
  DEL %~dp0\.installed
  DEL %~dp0\.remove
)
IF EXIST ~%dp0\.installed (
  ECHO.
  ECHO The next time you run this script, it will present a menu with actions
  ECHO you can exercise to update or modify your current installation.
)
PAUSE > NUL
%exitCmd%
