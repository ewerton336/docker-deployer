@echo off
setlocal enabledelayedexpansion

REM Escolher entre Docker e Podman
:choose_tool
echo Choose container tool:
echo 1 - Docker
echo 2 - Podman
set /p TOOL_CHOICE="Enter option (1 or 2): "

if "%TOOL_CHOICE%"=="1" (
    set CONTAINER_TOOL=docker
) else if "%TOOL_CHOICE%"=="2" (
    set CONTAINER_TOOL=podman
) else (
    echo Invalid option. Try again.
    goto choose_tool
)

REM Solicitar o diretório do projeto
set /p PROJECT_DIR="Enter the project directory: "
if not exist "%PROJECT_DIR%" (
    echo Directory does not exist. Exiting...
    exit /b
)

REM Obter o nome da pasta como IMAGE_NAME
for %%i in ("%PROJECT_DIR%") do set IMAGE_NAME=%%~ni
set TAR_FILE=%IMAGE_NAME%.tar

REM Configurações do Servidor
set SERVER_USER=root
set SERVER_IP=51.79.39.251
set REMOTE_DIR=~/docker

REM Acessar o diretório do projeto
cd /d "%PROJECT_DIR%"

REM Construir a Imagem
echo Building %CONTAINER_TOOL% image...
%CONTAINER_TOOL% build -t %IMAGE_NAME% .

REM Salvar a Imagem como Arquivo Tar
echo Saving %CONTAINER_TOOL% image to tar file...
%CONTAINER_TOOL% save -o %TAR_FILE% %IMAGE_NAME%

REM Transferir a Imagem para o Servidor
echo Transferring image to remote server...
scp %TAR_FILE% %SERVER_USER%@%SERVER_IP%:%REMOTE_DIR%

REM Excluir a Imagem Local
echo Deleting local %CONTAINER_TOOL% image and tar file...
%CONTAINER_TOOL% rmi %IMAGE_NAME%
del %TAR_FILE%

echo Done!
pause
