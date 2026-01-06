@echo off
echo ========================================
echo   VERIFICACAO DE CONFIGURACAO
echo   GUIDEDOSE
echo ========================================
echo.

REM Configura caminhos (do local.properties)
set FLUTTER_SDK=G:\flutter
set ANDROID_SDK=C:\Users\giova\AppData\Local\Android\sdk

echo [1/4] Verificando Flutter...
echo.
if exist "%FLUTTER_SDK%\bin\flutter.bat" (
    echo [OK] Flutter encontrado em: %FLUTTER_SDK%
    "%FLUTTER_SDK%\bin\flutter.bat" --version
) else (
    echo [ERRO] Flutter nao encontrado em: %FLUTTER_SDK%
    echo Verifique o caminho no local.properties
)
echo.

echo [2/4] Verificando Android SDK...
echo.
if exist "%ANDROID_SDK%" (
    echo [OK] Android SDK encontrado em: %ANDROID_SDK%
) else (
    echo [ERRO] Android SDK nao encontrado em: %ANDROID_SDK%
    echo Verifique o caminho no local.properties
)
echo.

echo [3/4] Verificando Platform-Tools (ADB)...
echo.
if exist "%ANDROID_SDK%\platform-tools\adb.exe" (
    echo [OK] ADB encontrado em: %ANDROID_SDK%\platform-tools
    "%ANDROID_SDK%\platform-tools\adb.exe" version
) else (
    echo [ERRO] ADB nao encontrado em: %ANDROID_SDK%\platform-tools
    echo.
    echo Para instalar:
    echo 1. Abra o Android Studio
    echo 2. Vá em Tools -^> SDK Manager
    echo 3. Aba SDK Tools
    echo 4. Marque Android SDK Platform-Tools
    echo 5. Clique em Apply
)
echo.

echo [4/4] Verificando dispositivos conectados...
echo.
if exist "%ANDROID_SDK%\platform-tools\adb.exe" (
    "%ANDROID_SDK%\platform-tools\adb.exe" devices
    echo.
    echo Se nenhum dispositivo aparecer:
    echo - Conecte o celular via USB
    echo - Ative a Depuracao USB
    echo - Autorize o computador no celular
) else (
    echo Nao foi possivel verificar dispositivos (ADB nao encontrado)
)
echo.

echo ========================================
echo   VERIFICACAO CONCLUIDA
echo ========================================
echo.
pause


