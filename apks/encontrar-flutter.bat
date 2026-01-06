@echo off
echo Procurando Flutter instalado...
echo.

REM Procura Flutter em varios locais
set FLUTTER_PATH=

REM Locais comuns
if exist "G:\flutter\bin\flutter.bat" set FLUTTER_PATH=G:\flutter\bin\flutter.bat
if exist "C:\src\flutter\bin\flutter.bat" set FLUTTER_PATH=C:\src\flutter\bin\flutter.bat
if exist "%LOCALAPPDATA%\flutter\bin\flutter.bat" set FLUTTER_PATH=%LOCALAPPDATA%\flutter\bin\flutter.bat
if exist "%USERPROFILE%\flutter\bin\flutter.bat" set FLUTTER_PATH=%USERPROFILE%\flutter\bin\flutter.bat
if exist "%ProgramFiles%\flutter\bin\flutter.bat" set FLUTTER_PATH=%ProgramFiles%\flutter\bin\flutter.bat
if exist "C:\flutter\bin\flutter.bat" set FLUTTER_PATH=C:\flutter\bin\flutter.bat
if exist "D:\flutter\bin\flutter.bat" set FLUTTER_PATH=D:\flutter\bin\flutter.bat
if exist "E:\flutter\bin\flutter.bat" set FLUTTER_PATH=E:\flutter\bin\flutter.bat
if exist "F:\flutter\bin\flutter.bat" set FLUTTER_PATH=F:\flutter\bin\flutter.bat

REM Tenta usar do PATH
if "%FLUTTER_PATH%"=="" (
    where flutter >nul 2>&1
    if %ERRORLEVEL% EQU 0 (
        flutter --version >nul 2>&1
        if %ERRORLEVEL% EQU 0 set FLUTTER_PATH=flutter
    )
)

if "%FLUTTER_PATH%"=="" (
    echo Flutter nao encontrado!
    echo.
    echo Por favor, informe o caminho completo do Flutter:
    echo Exemplo: C:\flutter\bin\flutter.bat
    echo.
    set /p FLUTTER_PATH="Digite o caminho: "
    
    if not exist "%FLUTTER_PATH%" (
        echo.
        echo Caminho invalido!
        pause
        exit /b 1
    )
)

echo Flutter encontrado: %FLUTTER_PATH%
echo.
"%FLUTTER_PATH%" --version
echo.

REM Salva o caminho encontrado
echo set FLUTTER_PATH=%FLUTTER_PATH%> "%TEMP%\flutter_path.txt"
echo Caminho salvo em: %TEMP%\flutter_path.txt

pause


