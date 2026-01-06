@echo off
echo ========================================
echo   INSTALANDO GUIDEDOSE
echo ========================================
echo.

REM Configura caminho do ADB (do local.properties)
set ANDROID_SDK=C:\Users\giova\AppData\Local\Android\sdk
set ADB_PATH=%ANDROID_SDK%\platform-tools\adb.exe

REM Adiciona ao PATH temporariamente
set "PATH=%ANDROID_SDK%\platform-tools;%PATH%"

REM Verifica se existe, caso contrário tenta encontrar automaticamente
if not exist "%ADB_PATH%" (
    set ADB_PATH=
    if exist "%LOCALAPPDATA%\Android\Sdk\platform-tools\adb.exe" set ADB_PATH=%LOCALAPPDATA%\Android\Sdk\platform-tools\adb.exe
    if exist "%USERPROFILE%\AppData\Local\Android\Sdk\platform-tools\adb.exe" set ADB_PATH=%USERPROFILE%\AppData\Local\Android\Sdk\platform-tools\adb.exe
    if exist "C:\Users\%USERNAME%\AppData\Local\Android\Sdk\platform-tools\adb.exe" set ADB_PATH=C:\Users\%USERNAME%\AppData\Local\Android\Sdk\platform-tools\adb.exe
    if exist "C:\Android\Sdk\platform-tools\adb.exe" set ADB_PATH=C:\Android\Sdk\platform-tools\adb.exe
    if "%ADB_PATH%"=="" (
        where adb >nul 2>&1
        if %ERRORLEVEL% EQU 0 (
            set ADB_PATH=adb
        ) else (
            echo ERRO: ADB nao encontrado!
            echo Configure o caminho no inicio deste arquivo.
            pause
            exit /b 1
        )
    )
)

REM Muda para o diretório raiz do projeto (pasta pai do script)
pushd "%~dp0\.."

REM Verifica se o APK existe (debug ou release)
set APK_FILE=build\app\outputs\flutter-apk\app-debug.apk
if not exist "%APK_FILE%" (
    set APK_FILE=build\app\outputs\flutter-apk\app-release.apk
    if not exist "%APK_FILE%" (
        echo ERRO: APK nao encontrado!
        echo.
        echo Execute primeiro: build-debug-apk.bat
        echo Ou execute: build-e-instalar.bat
        echo.
        pause
        exit /b 1
    )
)

echo Conecte o celular via USB e ative a Depuracao USB
echo Pressione qualquer tecla para continuar...
pause > nul
echo.

echo Verificando dispositivo conectado...
REM Tenta usar o caminho completo, se não funcionar usa do PATH
if exist "%ADB_PATH%" (
    "%ADB_PATH%" devices
) else (
    adb devices
)
echo.

REM Verifica se há dispositivo conectado
if exist "%ADB_PATH%" (
    "%ADB_PATH%" devices | find "device" > nul
) else (
    adb devices | find "device" > nul
)
if %ERRORLEVEL% NEQ 0 (
    echo ========================================
    echo   NENHUM DISPOSITIVO ENCONTRADO!
    echo ========================================
    echo.
    echo Certifique-se de que:
    echo - O celular esta conectado via USB
    echo - A Depuracao USB esta ativada
    echo - Voce autorizou o computador no celular
    echo.
    pause
    exit /b 1
)

echo Instalando APK...
REM Tenta usar o caminho completo, se não funcionar usa do PATH
if exist "%ADB_PATH%" (
    "%ADB_PATH%" install -r "%APK_FILE%"
) else (
    adb install -r "%APK_FILE%"
)
echo.
echo ========================================
if %ERRORLEVEL% EQU 0 (
    echo   INSTALACAO CONCLUIDA COM SUCESSO!
) else (
    echo   ERRO NA INSTALACAO
    echo.
    echo Tente instalar manualmente:
    echo 1. Copie o APK para o celular
    echo 2. Abra o arquivo no celular
    echo 3. Toque em Instalar
)

REM Volta para o diretório original (se estava em um)
if exist "%CD%" popd

echo ========================================
echo.
pause
