@echo off
setlocal enabledelayedexpansion

REM Definir IP do Servidor
set SERVER_IP=51.79.39.251

REM Solicitar Nome do Container
set /p CONTAINER_NAME="Enter the container name: "

REM Solicitar Nome da Imagem
set /p IMAGE_NAME="Enter the image name: "

REM Solicitar Porta da Aplicação
set /p CONTAINER_PORT="Enter the port for the application: "

REM Exibindo as configurações
echo ========================================
echo Server IP: %SERVER_IP%
echo Container Name: %CONTAINER_NAME%
echo Image Name: %IMAGE_NAME%
echo Application Port: %CONTAINER_PORT%
echo ========================================

REM Conectando ao servidor via SSH e executando os comandos
ssh root@%SERVER_IP% ^
"cd docker && ^
docker load -i %CONTAINER_NAME%.tar && ^
docker run -d -p %CONTAINER_PORT%:%CONTAINER_PORT% --name %CONTAINER_NAME% %IMAGE_NAME%"

pause