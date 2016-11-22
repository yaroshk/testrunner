@ECHO OFF
::========================================
SET GITHUB_ACCOUNT=yaroshk
SET WS_DIR=Workspace
SET REPO_NAME=Single_Title_Validation_PFile
SET APP_VERSION=Title-null-jar-with-dependencies
SET MAIN_CLASS=core.HtmlUnit
SET ARGS_01=
::========================================

::========================================
SET GITHUB_ACCOUNT=%1
SET WS_DIR=%2
SET REPO_NAME=%3
SET APP_VERSION=%4
SET MAIN_CLASS=%5
SET ARGS_01=%6
::========================================

IF "%JAVA_HOME%" == "" GOTO EXIT_JAVA
ECHO Java installed
IF "%M2%" == "" GOTO EXIT_MVN
ECHO Maven installed
CALL git --version > nul 2>&1
IF NOT %ERRORLEVEL% == 0 GOTO EXIT_GIT
ECHO Git installed

GOTO NEXT

:NEXT
IF NOT EXIST C:\%WS_DIR% GOTO NO_WORKSPACE
IF EXIST C:\%WS_DIR%\%REPO_NAME% RMDIR /S /Q C:\%WS_DIR%\%REPO_NAME%
CD C:\%WS_DIR%
git clone git@github.com:yaroshk/Single_Title_Validation_PFile.git
CD %REPO_NAME%
ping 127.0.0.1 -n 4 > nul
CALL mvn package
ECHO.
ECHO GO TO RESOURCE FILE
CD C:\%WS_DIR%\%REPO_NAME%
ECHO Executing Java programm ...
java -cp C:\%WS_DIR%\%REPO_NAME%\target\%APP_VERSION%.jar %MAIN_CLASS% %ARG_01%
GOTO END

:EXIT_JAVA
ECHO No Java installed
GOTO END
:EXIT_MVN
ECHO No Maven installed
GOTO END
:EXIT_GIT
ECHO No Git installed
GOTO END
:NO_WORKSPACE
ECHO %WS_DIR% is not exists
GOTO END
:END
CD\