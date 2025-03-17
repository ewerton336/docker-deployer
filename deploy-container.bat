@echo off
setlocal enabledelayedexpansion

REM Definir IP do Servidor
set SERVER_IP=51.79.39.251

REM Solicitar o diretório do projeto
set /p PROJECT_DIR="Enter the project directory: "
if not exist "%PROJECT_DIR%" (
    echo Directory does not exist. Exiting...
    exit /b
)

REM Obter o nome da pasta como CONTAINER_NAME e IMAGE_NAME
for %%i in ("%PROJECT_DIR%") do set CONTAINER_NAME=%%~ni

REM Converter o nome do container para minúsculas
for /f %%a in ('powershell -Command "$('%CONTAINER_NAME%'.ToLower())"') do set CONTAINER_NAME=%%a

REM Solicitar Porta da Aplicação
set /p CONTAINER_PORT="Enter the port for the application: "

REM Solicitar Porta Interna da Aplicação
set /p INTERNAL_PORT="Enter the internal port for the application: "

REM Exibindo as configurações
echo ========================================
echo Server IP: %SERVER_IP%
echo Project Directory: %PROJECT_DIR%
echo Container Name: %CONTAINER_NAME%
echo Application Port: %CONTAINER_PORT%
echo Application Internal Port: %INTERNAL_PORT%
echo ========================================

REM Conectando ao servidor via SSH e executando os comandos
ssh root@%SERVER_IP% "cd ~/docker && ls -lah && docker load -i %CONTAINER_NAME%.tar && docker run -d -p %CONTAINER_PORT%:%INTERNAL_PORT% --name %CONTAINER_NAME% %CONTAINER_NAME%"

echo Done!
pause
