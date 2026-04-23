@echo off
REM File Indexer - Download de dependencias para instalacao OFFLINE
REM Rode este script numa maquina Windows COM internet.
REM Ele cria uma pasta "wheels\" AQUI DENTRO de "instalacao_offline\"
REM com todos os pacotes Python necessarios.
REM
REM Depois copie a pasta raiz do File Indexer inteira (com as 3
REM subpastas) para a maquina offline e rode "instalador.bat" la.

setlocal
cd /d "%~dp0"

echo.
echo ========================================
echo  File Indexer - Baixando dependencias
echo ========================================
echo.

set "PYCMD="

py -3 --version >nul 2>nul
if not errorlevel 1 set "PYCMD=py -3" & goto :found_py

py --version >nul 2>nul
if not errorlevel 1 set "PYCMD=py" & goto :found_py

python --version >nul 2>nul
if not errorlevel 1 set "PYCMD=python" & goto :found_py

echo [ERRO] Python 3 nao encontrado nesta maquina.
pause
exit /b 1

:found_py
echo Usando: %PYCMD%
echo.
echo Baixando pacotes na pasta "wheels\"...
echo ^(pode demorar alguns minutos^)
echo.

if not exist wheels mkdir wheels

%PYCMD% -m pip download -d wheels flask pdfminer.six python-docx odfpy chardet setuptools wheel pip pywin32
if errorlevel 1 (
    echo.
    echo [ERRO] Falha ao baixar os pacotes.
    pause
    exit /b 1
)

echo.
echo ========================================
echo  Download concluido com sucesso!
echo ========================================
echo.
echo Agora falta so UMA coisa nesta pasta:
echo.
echo   - Baixe o instalador do Python ^(.exe^) em
echo     https://www.python.org/downloads/
echo     e coloque nesta mesma pasta "instalacao_offline\".
echo.
echo Depois, copie a pasta RAIZ do File Indexer inteira
echo ^(com as 3 subpastas^) para o pendrive e leve para a
echo maquina offline. La, dentro da pasta raiz, rode o
echo "instalador.bat" para instalar tudo de uma vez.
echo.
pause
endlocal
