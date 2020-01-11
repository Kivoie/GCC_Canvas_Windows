@echo off
:MAIN
cls
REM GCC for Windows ASCII banner
ECHO  _       __       __
ECHO ^| ^|     / /___   / /_____ ____   ____ ___   ___  
ECHO ^| ^| /^| / // _ \ / // ___// __ \ / __ `__ \ / _ \ 		     	       Written by Danny Vuong
ECHO ^| ^|/ ^|/ //  __// // /__ / /_/ // / / / / //  __/			  	    CU 101040331
ECHO ^|__/^|__/ \___//_/ \___/ \____//_/ /_/ /_/ \___/  		   	  	    AC 040871275
ECHO   ______          ______            
ECHO  /_  __/____     / ____/  __     __ 
ECHO   / /  / __ \   / / __ __/ /_ __/ /_
ECHO  / /  / /_/ /  / /_/ //_  __//_  __/
ECHO /_/   \____/   \____/  /_/    /_/
ECHO  _       __ _             __                     
ECHO ^| ^|     / /(_)____   ____/ /____  _      __ _____
ECHO ^| ^| /^| / // // __ \ / __  // __ \^| ^| /^| / // ___/
ECHO ^| ^|/ ^|/ // // / / // /_/ // /_/ /^| ^|/ ^|/ /(__  )			  gcc (MinGW.org GCC-8.2.0-5) 8.2.0
ECHO ^|__/^|__//_//_/ /_/ \__,_/ \____/ ^|__/^|__//____/			  Copyright (C) 2018 Free Software Foundation, Inc.
ECHO.
ECHO You are in directory C:\Users\danny\Documents\GCC Canvas
ECHO Do not change directory! This directory is reserved as a testing environment.
ECHO Press CTRL + C anytime to terminate the script.
:MENU
REM Menu selection
ECHO.
ECHO ==================== MENU ====================
ECHO [1] Compile .cpp file to executable     [6] List all files within all subdirectories
ECHO [2] Run an executable                   [7] Help
ECHO [3] Compile .cpp file and run executable[8] Open a c/cpp file in notepad++
ECHO [4] Go to top (Clear screen)            [9] Exit
ECHO [5] View the contents in this wd
REM User input. ERRORLEVELs must be in reverse order.
CHOICE /C:123456789 /n /m "Please select an option: "
IF ERRORLEVEL 9 GOTO EOF
IF ERRORLEVEL 8 GOTO OPEN
IF ERRORLEVEL 7 GOTO HELP
IF ERRORLEVEL 6 tree /F && pause
IF ERRORLEVEL 5 dir && pause
IF ERRORLEVEL 4 GOTO MAIN
IF ERRORLEVEL 3 GOTO CHKFILE
IF ERRORLEVEL 2 GOTO RUN
IF ERRORLEVEL 1 GOTO COMPILE
ECHO.
GOTO MENU
:HELP
REM Boilerplate and help message
ECHO.
ECHO 		gcc (MinGW.org GCC-8.2.0-5) 8.2.0
ECHO 	Copyright (C) 2018 Free Software Foundation, Inc.
ECHO.
ECHO This batch file is an interface for Windows GCC to compile and run C/C++ code.
ECHO Press CTRL + C to terminate the script. If prompted with compiling and/or
ECHO running a file, type "/b" without quotation marks to return to the menu.
ECHO.
GOTO MENU
:CHKFILE
REM Compile .c or .cpp into a .exe and run in command line
SET /P gccFile="Please enter the file you would like to compile and run (Type /b to go back): "
IF %gccFile%==/b GOTO MENU
IF EXIST %gccFile% g++ %gccFile% -o %gccFile%.exe && ECHO. && ECHO -------- Running '%gccFile%'. . . -------- && %gccFile%.exe && ECHO -------- '%gccFile%' has completed its runtime. -------- && GOTO CRLOG
IF NOT EXIST %gccFile% ECHO File '%gccFile%' does not exist. && GOTO CHKFILE
:RUN
REM Run .exe in command line
SET /P gccRun="Please enter the file you would like to run (Type /b to go back): "
IF %gccRun%==/b GOTO MENU
IF EXIST %gccRun% ECHO. && ECHO -------- Running '%gccRun%'. . . -------- && %gccRun% && ECHO -------- '%gccRun%' has completed its runtime. -------- && GOTO RLOG
IF NOT EXIST %gccRun% ECHO File '%gccRun%' does not exist. && GOTO RUN
:COMPILE
REM Compile .c or .cpp into a .exe
SET /P gccCompile="Please enter the file you would like to compile (Type /b to go back): "
IF %gccCompile%==/b GOTO MENU
IF EXIST %gccCompile% g++ %gccCompile% -o %gccCompile%.exe && ECHO '%gccCompile%' has compiled successfully. && GOTO CLOG
IF NOT EXIST %gccCompile% ECHO File '%gccCompile%' does not exist. && GOTO COMPILE
REM logging labels. log\gcc_log.txt and log\gcc_log.txt.BAK
:CLOG
set timestamp=[%DATE:/=-%@%TIME::=:%]
set timestamp=%timestamp: =%
ECHO %timestamp% Successfully compiled '%gccCompile%' to '%gccCompile%.exe'.>> logs\gcc_log.txt
COPY logs\gcc_log.txt logs\gcc_log.txt.BAK
GOTO MENU
:RLOG
set timestamp=[%DATE:/=-%@%TIME::=:%]
set timestamp=%timestamp: =%
ECHO %timestamp% Successfully ran %gccRun%.>> logs\gcc_log.txt
COPY logs\gcc_log.txt logs\gcc_log.txt.BAK
GOTO MENU
:CRLOG
set timestamp=[%DATE:/=-%@%TIME::=:%]
set timestamp=%timestamp: =%
ECHO %timestamp% Successfully compiled '%gccFile%' into '%gccFile%.exe' and successfully ran '%gccFile%'>> logs\gcc_log.txt
COPY logs\gcc_log.txt logs\gcc_log.txt.BAK
GOTO MENU
:OPEN
SET /P gccOpen="Please enter the file you would like to edit (Type /b to go back): "
IF %gccOpen%==/b GOTO MENU
IF EXIST %gccOpen% "C:\Program Files\Notepad++\notepad++.exe" %gccOpen% && GOTO Menu
IF NOT EXIST %gccOpen% ECHO File '%gccOpen%' does not exist. && GOTO OPEN
cmd /k