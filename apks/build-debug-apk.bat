@echo off
echo ========================================
echo   BUILDING GUIDEDOSE APK
echo ========================================
echo.

REM Configura caminho do Flutter (atualizado para E:\flutter)
set FLUTTER_SDK=E:\flutter
set FLUTTER_PATH=%FLUTTER_SDK%\bin\flutter.bat

REM Adiciona ao PATH temporariamente
set "PATH=%FLUTTER_SDK%\bin;%PATH%"

REM Verifica se existe, caso contrário tenta encontrar automaticamente
if not exist "%FLUTTER_PATH%" (
    set FLUTTER_PATH=
    if exist "G:\flutter\bin\flutter.bat" set FLUTTER_PATH=G:\flutter\bin\flutter.bat
    if exist "C:\src\flutter\bin\flutter.bat" set FLUTTER_PATH=C:\src\flutter\bin\flutter.bat
    if exist "%LOCALAPPDATA%\flutter\bin\flutter.bat" set FLUTTER_PATH=%LOCALAPPDATA%\flutter\bin\flutter.bat
    if exist "%USERPROFILE%\flutter\bin\flutter.bat" set FLUTTER_PATH=%USERPROFILE%\flutter\bin\flutter.bat
    if exist "%ProgramFiles%\flutter\bin\flutter.bat" set FLUTTER_PATH=%ProgramFiles%\flutter\bin\flutter.bat
    if "%FLUTTER_PATH%"=="" (
        where flutter >nul 2>&1
        if %ERRORLEVEL% EQU 0 (
            set FLUTTER_PATH=flutter
        ) else (
            echo ERRO: Flutter nao encontrado!
            echo Configure o caminho no inicio deste arquivo.
            pause
            exit /b 1
        )
    )
)

echo Building APK...
echo.
echo NOTA: Gerando APK DEBUG (nao requer assinatura)
echo Para gerar APK RELEASE, configure o keystore em android/key.properties
echo.

REM Muda para o diretório raiz do projeto (pasta pai do script)
pushd "%~dp0\.."

REM Tenta usar o caminho completo, se não funcionar usa do PATH
REM Usando --split-per-abi para gerar APKs otimizados por arquitetura
REM Isso reduz o tamanho de ~174MB para ~50-60MB por APK
if exist "%FLUTTER_PATH%" (
    "%FLUTTER_PATH%" build apk --split-per-abi --debug
) else (
    flutter build apk --split-per-abi --debug
)
echo.
if %ERRORLEVEL% EQU 0 (
    echo ========================================
    echo   BUILD COMPLETED SUCCESSFULLY!
    echo ========================================
    echo.
    echo APKs gerados (split por arquitetura):
    if exist "build\app\outputs\flutter-apk\app-arm64-v8a-debug.apk" (
        echo   - app-arm64-v8a-debug.apk (64-bit ARM - mais comum)
    )
    if exist "build\app\outputs\flutter-apk\app-armeabi-v7a-debug.apk" (
        echo   - app-armeabi-v7a-debug.apk (32-bit ARM)
    )
    if exist "build\app\outputs\flutter-apk\app-x86_64-debug.apk" (
        echo   - app-x86_64-debug.apk (64-bit x86)
    )
    echo.
    echo Tamanho reduzido de ~174MB para ~50-60MB por arquitetura
    echo Para instalar no celular, copie o APK apropriado para o dispositivo.
) else (
    echo ========================================
    echo   BUILD FAILED!
    echo ========================================
    echo.
    echo Certifique-se de que o Flutter esta instalado e no PATH.
    echo Ou configure a variavel FLUTTER_PATH no script.
)

REM Volta para o diretório original (se estava em um)
popd

echo.
pause
