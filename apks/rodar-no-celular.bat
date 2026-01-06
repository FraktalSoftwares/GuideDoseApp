@echo off
echo ========================================
echo   RODAR APP NO CELULAR (HOT RELOAD)
echo   GUIDEDOSE - MODO DESENVOLVIMENTO
echo ========================================
echo.

REM Configura caminhos específicos do sistema
REM Flutter SDK
set FLUTTER_SDK=E:\flutter
set FLUTTER_PATH=%FLUTTER_SDK%\bin\flutter.bat

REM Android SDK Platform Tools
set ANDROID_SDK=C:\Users\giova\AppData\Local\Android\sdk
set ADB_PATH=%ANDROID_SDK%\platform-tools\adb.exe

REM Adiciona ao PATH temporariamente
set "PATH=%FLUTTER_SDK%\bin;%ANDROID_SDK%\platform-tools;%PATH%"

REM Verifica se os caminhos existem, caso contrário tenta encontrar automaticamente
if not exist "%FLUTTER_PATH%" (
    echo Flutter nao encontrado em: %FLUTTER_PATH%
    echo Tentando encontrar automaticamente...
    set FLUTTER_PATH=
    
    REM Procura em varios locais comuns
    if exist "G:\flutter\bin\flutter.bat" set FLUTTER_PATH=G:\flutter\bin\flutter.bat
    if exist "C:\src\flutter\bin\flutter.bat" set FLUTTER_PATH=C:\src\flutter\bin\flutter.bat
    if exist "C:\flutter\bin\flutter.bat" set FLUTTER_PATH=C:\flutter\bin\flutter.bat
    if exist "D:\flutter\bin\flutter.bat" set FLUTTER_PATH=D:\flutter\bin\flutter.bat
    if exist "E:\flutter\bin\flutter.bat" set FLUTTER_PATH=E:\flutter\bin\flutter.bat
    if exist "F:\flutter\bin\flutter.bat" set FLUTTER_PATH=F:\flutter\bin\flutter.bat
    if exist "%LOCALAPPDATA%\flutter\bin\flutter.bat" set FLUTTER_PATH=%LOCALAPPDATA%\flutter\bin\flutter.bat
    if exist "%USERPROFILE%\flutter\bin\flutter.bat" set FLUTTER_PATH=%USERPROFILE%\flutter\bin\flutter.bat
    if exist "%ProgramFiles%\flutter\bin\flutter.bat" set FLUTTER_PATH=%ProgramFiles%\flutter\bin\flutter.bat
    
    REM Tenta usar do PATH
    if "%FLUTTER_PATH%"=="" (
        where flutter >nul 2>&1
        if %ERRORLEVEL% EQU 0 (
            flutter --version >nul 2>&1
            if %ERRORLEVEL% EQU 0 set FLUTTER_PATH=flutter
        )
    )
    
    REM Se ainda nao encontrou, pede ao usuario
    if "%FLUTTER_PATH%"=="" (
        echo.
        echo ========================================
        echo   FLUTTER NAO ENCONTRADO!
        echo ========================================
        echo.
        echo Por favor, informe o caminho completo do Flutter:
        echo Exemplo: C:\flutter\bin\flutter.bat
        echo.
        set /p FLUTTER_PATH="Digite o caminho do Flutter: "
        
        if "%FLUTTER_PATH%"=="" (
            echo Caminho nao informado. Abortando...
            pause
            exit /b 1
        )
        
        if not exist "%FLUTTER_PATH%" (
            echo.
            echo ERRO: Caminho invalido: %FLUTTER_PATH%
            pause
            exit /b 1
        )
    )
)

if not exist "%ADB_PATH%" (
    echo ADB nao encontrado em: %ADB_PATH%
    echo Tentando encontrar automaticamente...
    set ADB_PATH=
    if exist "%LOCALAPPDATA%\Android\Sdk\platform-tools\adb.exe" set ADB_PATH=%LOCALAPPDATA%\Android\Sdk\platform-tools\adb.exe
    if exist "%USERPROFILE%\AppData\Local\Android\Sdk\platform-tools\adb.exe" set ADB_PATH=%USERPROFILE%\AppData\Local\Android\Sdk\platform-tools\adb.exe
    if exist "C:\Users\%USERNAME%\AppData\Local\Android\Sdk\platform-tools\adb.exe" set ADB_PATH=C:\Users\%USERNAME%\AppData\Local\Android\Sdk\platform-tools\adb.exe
    if exist "C:\Android\Sdk\platform-tools\adb.exe" set ADB_PATH=C:\Android\Sdk\platform-tools\adb.exe
    if "%ADB_PATH%"=="" (
        where adb >nul 2>&1
        if %ERRORLEVEL% EQU 0 set ADB_PATH=adb
    )
)

REM Verifica se encontrou Flutter
if "%FLUTTER_PATH%"=="" (
    echo ========================================
    echo   FLUTTER NAO ENCONTRADO!
    echo ========================================
    echo.
    echo Por favor, configure o caminho do Flutter no inicio deste arquivo.
    pause
    exit /b 1
)

echo Flutter: %FLUTTER_SDK%
if "%ADB_PATH%"=="" (
    echo ADB: Nao encontrado (usando do PATH)
) else (
    echo ADB: %ANDROID_SDK%\platform-tools
)
echo.

echo ========================================
echo   VERIFICANDO DISPOSITIVO
echo ========================================
echo.
echo Certifique-se de que:
echo - O celular esta conectado via USB
echo - A Depuracao USB esta ativada
echo - Voce autorizou o computador no celular
echo.

REM Verifica se há dispositivo conectado (tenta até 5 vezes com intervalo de 2 segundos)
set TENTATIVAS=0
:VERIFICA_DISPOSITIVO
set /a TENTATIVAS+=1

if exist "%ADB_PATH%" (
    "%ADB_PATH%" devices | find "device" > nul
) else (
    adb devices | find "device" > nul
)

if %ERRORLEVEL% EQU 0 (
    echo [OK] Dispositivo encontrado!
    goto DISPOSITIVO_ENCONTRADO
)

if %TENTATIVAS% LSS 5 (
    echo Aguardando dispositivo... (tentativa %TENTATIVAS%/5)
    timeout /t 2 /nobreak > nul
    goto VERIFICA_DISPOSITIVO
)

echo ========================================
echo   NENHUM DISPOSITIVO ENCONTRADO!
echo ========================================
echo.
echo Certifique-se de que:
echo - O celular esta conectado via USB
echo - A Depuracao USB esta ativada
echo - Voce autorizou o computador no celular
echo.
echo Tente novamente quando o dispositivo estiver conectado.
echo.
pause
exit /b 1

:DISPOSITIVO_ENCONTRADO

REM Lista dispositivos conectados
echo.
echo Dispositivos conectados:
if exist "%ADB_PATH%" (
    "%ADB_PATH%" devices
) else (
    adb devices
)
echo.

REM Muda para o diretório raiz do projeto
pushd "%~dp0\.."

echo ========================================
echo   INICIANDO APP NO CELULAR
echo ========================================
echo.
echo O app sera compilado e instalado automaticamente.
echo Apos iniciar, voce pode usar:
echo.
echo   [r] - Hot Reload (atualiza mudancas rapidamente)
echo   [R] - Hot Restart (reinicia o app)
echo   [q] - Quit (sair)
echo   [p] - Toggle Performance Overlay
echo   [o] - Toggle Platform
echo.
echo Aguarde enquanto o app e compilado...
echo.

REM Executa o Flutter run
if exist "%FLUTTER_PATH%" (
    "%FLUTTER_PATH%" run
) else (
    flutter run
)

REM Volta para o diretório original
popd

echo.
echo ========================================
echo   APP FINALIZADO
echo ========================================
echo.
pause


