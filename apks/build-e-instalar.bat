@echo off
echo ========================================
echo   BUILD E INSTALACAO AUTOMATICA
echo   GUIDEDOSE
echo ========================================
echo.

REM Configura caminhos específicos do sistema
REM Flutter SDK (atualizado para E:\flutter)
set FLUTTER_SDK=E:\flutter
set FLUTTER_PATH=%FLUTTER_SDK%\bin\flutter.bat

REM Android SDK Platform Tools
set ANDROID_SDK=C:\Users\giova\AppData\Local\Android\sdk
set ADB_PATH=%ANDROID_SDK%\platform-tools\adb.exe

REM Adiciona ao PATH temporariamente para facilitar execução
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

REM Verifica se encontrou ADB
if "%ADB_PATH%"=="" (
    echo ========================================
    echo   ADB NAO ENCONTRADO!
    echo ========================================
    echo.
    echo Por favor, configure o caminho do ADB no inicio deste arquivo.
    pause
    exit /b 1
)

echo Flutter: %FLUTTER_SDK%
echo ADB: %ANDROID_SDK%\platform-tools
echo.

REM Confirma que o ADB está disponível
if exist "%ADB_PATH%" (
    echo [OK] ADB configurado corretamente
) else (
    echo [AVISO] ADB nao encontrado no caminho configurado
    echo Tentando usar do PATH...
)
echo.

echo [1/3] Gerando APK...
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

if %ERRORLEVEL% NEQ 0 (
    echo ========================================
    echo   ERRO AO GERAR APK!
    echo ========================================
    echo.
    echo Verifique se o Flutter esta instalado corretamente.
    popd
    pause
    exit /b 1
)

echo ========================================
echo   APK GERADO COM SUCESSO!
echo ========================================
echo.
echo APK location: %APK_FILE%
echo.

REM Verifica se o APK existe (com split-per-abi, pode haver múltiplos APKs)
REM Prioriza arm64-v8a (mais comum), depois armeabi-v7a, depois x86_64
set APK_FILE=
if exist "build\app\outputs\flutter-apk\app-armeabi-v7a-debug.apk" (
    set APK_FILE=build\app\outputs\flutter-apk\app-armeabi-v7a-debug.apk
)
if exist "build\app\outputs\flutter-apk\app-arm64-v8a-debug.apk" (
    set APK_FILE=build\app\outputs\flutter-apk\app-arm64-v8a-debug.apk
)
if exist "build\app\outputs\flutter-apk\app-x86_64-debug.apk" (
    if "%APK_FILE%"=="" set APK_FILE=build\app\outputs\flutter-apk\app-x86_64-debug.apk
)
REM Fallback para APK universal (se não usar split)
if "%APK_FILE%"=="" (
    set APK_FILE=build\app\outputs\flutter-apk\app-debug.apk
    if not exist "%APK_FILE%" (
        set APK_FILE=build\app\outputs\flutter-apk\app-release.apk
        if not exist "%APK_FILE%" (
            echo ERRO: APK nao encontrado!
            popd
            pause
            exit /b 1
        )
    )
)

echo [2/3] Verificando dispositivo conectado...
echo.
echo Procurando dispositivo automaticamente...
echo Certifique-se de que o celular esta conectado via USB com Depuracao USB ativada
echo.

REM Tenta usar o caminho completo, se não funcionar usa do PATH
if exist "%ADB_PATH%" (
    "%ADB_PATH%" devices
) else (
    adb devices
)
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
echo O APK foi gerado com sucesso em:
echo %APK_FILE%
echo.
    echo Voce pode instalar manualmente copiando o APK para o celular.
    echo.
    popd
    pause
    exit /b 0

:DISPOSITIVO_ENCONTRADO

echo [3/3] Instalando APK no dispositivo...
echo.
REM Tenta usar o caminho completo, se não funcionar usa do PATH
if exist "%ADB_PATH%" (
    "%ADB_PATH%" install -r "%APK_FILE%"
) else (
    adb install -r "%APK_FILE%"
)
echo.

if %ERRORLEVEL% EQU 0 (
    echo ========================================
    echo   INSTALACAO CONCLUIDA COM SUCESSO!
    echo ========================================
    echo.
    echo O app foi instalado no seu celular!
    echo.
    echo Pressione qualquer tecla para fechar...
    pause > nul
)

REM Volta para o diretório original
popd else (
    echo ========================================
    echo   ERRO NA INSTALACAO
    echo ========================================
    echo.
    echo O APK foi gerado com sucesso em:
    echo %APK_FILE%
    echo.
    echo Tente instalar manualmente:
    echo 1. Copie o APK para o celular
    echo 2. Abra o arquivo no celular
    echo 3. Toque em Instalar
    echo.
    echo Pressione qualquer tecla para fechar...
    pause > nul
)

REM Volta para o diretório original
popd
