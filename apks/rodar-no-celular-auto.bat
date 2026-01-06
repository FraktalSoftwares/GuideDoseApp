@echo off
REM Script wrapper que evita erro ao executar de dentro da pasta apks
REM Este script pode ser executado de qualquer lugar sem erros

REM Obtém o diretório onde este script está
set SCRIPT_DIR=%~dp0

REM Muda para o diretório raiz do projeto (evita erro se já estiver em apks)
cd /d "%SCRIPT_DIR%\.." 2>nul

REM Executa o script principal
call "%SCRIPT_DIR%rodar-no-celular.bat"


