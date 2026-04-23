@echo off
REM ==================================================================
REM  File Indexer - Instalador completo (OFFLINE)
REM  Faz em sequencia:
REM    1. Instala o Python (se necessario) a partir do .exe em
REM       "instalacao_offline\"
REM    2. Instala as dependencias a partir da pasta
REM       "instalacao_offline\wheels\"
REM    3. Cria o atalho "File Indexer.lnk" na Area de Trabalho,
REM       apontando para "programa\file_indexer_silent.vbs"
REM ==================================================================

setlocal EnableDelayedExpansion
cd /d "%~dp0"

set "SCRIPT_DIR=%~dp0"
if "%SCRIPT_DIR:~-1%"=="\" set "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"

set "INSTALL_DIR=%SCRIPT_DIR%\instalacao_offline"
set "PROGRAMA_DIR=%SCRIPT_DIR%\programa"

echo.
echo ==========================================
echo   File Indexer - Instalacao completa
echo ==========================================
echo.

REM ==============================================================
REM  ETAPA 1/3 - Python
REM ==============================================================
echo [1/3] Verificando Python...
set "PYCMD="

py --version >nul 2>nul
if not errorlevel 1 (
    set "PYCMD=py"
    goto :py_ready
)

python --version >nul 2>nul
if not errorlevel 1 (
    set "PYCMD=python"
    goto :py_ready
)

REM Python nao instalado - procurar o .exe do instalador
echo Python nao encontrado. Procurando instalador...

set "PY_INSTALLER="
for %%F in ("%INSTALL_DIR%\python-*.exe") do set "PY_INSTALLER=%%F"

if "%PY_INSTALLER%"=="" (
    echo.
    echo [ERRO] Nenhum instalador do Python ^(python-*.exe^) encontrado em:
    echo   %INSTALL_DIR%
    echo.
    echo Baixe o instalador em https://www.python.org/downloads/
    echo e coloque dentro da pasta "instalacao_offline\",
    echo depois rode este instalador de novo.
    pause
    exit /b 1
)

echo Instalador encontrado: %PY_INSTALLER%
echo.
echo Instalando Python... ^(pode levar alguns minutos^)
echo.
REM /passive        -> barra de progresso, sem perguntas
REM InstallAllUsers=0 -> instala so para o usuario atual (nao precisa admin)
REM PrependPath=1   -> adiciona Python ao PATH
REM Include_test=0  -> pula suite de testes (arquivo menor)
REM Include_launcher=1 -> instala o "py" launcher
"%PY_INSTALLER%" /passive InstallAllUsers=0 PrependPath=1 Include_test=0 Include_launcher=1
if errorlevel 1 (
    echo.
    echo [ERRO] Falha ao instalar o Python. Codigo: %errorlevel%
    pause
    exit /b 1
)

REM Apos a instalacao, o PATH do cmd atual nao esta atualizado.
REM Procura o python.exe recem-instalado no diretorio padrao de usuario.
set "PY_HOME="
for /d %%D in ("%LOCALAPPDATA%\Programs\Python\Python*") do set "PY_HOME=%%D"

if "%PY_HOME%"=="" (
    echo [ERRO] Python foi instalado mas nao foi localizado em:
    echo   %LOCALAPPDATA%\Programs\Python\
    echo Reinicie o computador e execute o instalador novamente.
    pause
    exit /b 1
)

if not exist "%PY_HOME%\python.exe" (
    echo [ERRO] python.exe nao encontrado em %PY_HOME%
    pause
    exit /b 1
)

set "PYCMD=%PY_HOME%\python.exe"
echo Python instalado em: %PY_HOME%

:py_ready
echo Python OK: %PYCMD%
echo.

REM ==============================================================
REM  ETAPA 2/3 - Dependencias (pacotes Python)
REM ==============================================================
echo [2/3] Instalando dependencias do File Indexer...

if not exist "%INSTALL_DIR%\wheels" (
    echo.
    echo [ERRO] Pasta "wheels\" nao encontrada em:
    echo   %INSTALL_DIR%
    echo.
    echo Copie a pasta "wheels" ^(gerada pelo baixar_deps.bat na maquina
    echo com internet^) para dentro de "instalacao_offline\" antes de
    echo rodar o instalador.
    pause
    exit /b 1
)

echo   Instalando setuptools e wheel...
"%PYCMD%" -m pip install --no-index --find-links="%INSTALL_DIR%\wheels" setuptools wheel
if errorlevel 1 (
    echo.
    echo [ERRO] Falha ao instalar setuptools/wheel.
    echo Verifique se esses pacotes estao na pasta "instalacao_offline\wheels\".
    pause
    exit /b 1
)

echo.
echo   Instalando bibliotecas principais...
"%PYCMD%" -m pip install --no-index --find-links="%INSTALL_DIR%\wheels" flask pdfminer.six python-docx odfpy chardet
if errorlevel 1 (
    echo.
    echo [ERRO] Falha ao instalar as dependencias principais.
    echo Verifique se a versao do Python confere com os wheels.
    pause
    exit /b 1
)

echo.
echo   Instalando pywin32 ^(opcional, para arquivos .doc via Word^)...
"%PYCMD%" -m pip install --no-index --find-links="%INSTALL_DIR%\wheels" pywin32 2>nul
if errorlevel 1 (
    echo   [AVISO] pywin32 nao instalado. Arquivos .doc usarao extracao basica.
)

echo.
echo Dependencias OK.
echo.

REM ==============================================================
REM  ETAPA 3/3 - Atalho na Area de Trabalho
REM ==============================================================
echo [3/3] Criando atalho na Area de Trabalho...

if not exist "%PROGRAMA_DIR%\file_indexer_silent.vbs" (
    echo [ERRO] file_indexer_silent.vbs nao encontrado em:
    echo   %PROGRAMA_DIR%
    pause
    exit /b 1
)

if not exist "%PROGRAMA_DIR%\file_indexer.ico" (
    echo [ERRO] file_indexer.ico nao encontrado em:
    echo   %PROGRAMA_DIR%
    pause
    exit /b 1
)

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$wsh = New-Object -ComObject WScript.Shell;" ^
  "$desktop = [Environment]::GetFolderPath('Desktop');" ^
  "$sc = $wsh.CreateShortcut([System.IO.Path]::Combine($desktop, 'File Indexer.lnk'));" ^
  "$sc.TargetPath = 'wscript.exe';" ^
  "$sc.Arguments = '\"%PROGRAMA_DIR%\file_indexer_silent.vbs\"';" ^
  "$sc.WorkingDirectory = '%PROGRAMA_DIR%';" ^
  "$sc.IconLocation = '%PROGRAMA_DIR%\file_indexer.ico';" ^
  "$sc.Description = 'File Indexer - Indexador e buscador de arquivos';" ^
  "$sc.Save();" ^
  "Write-Host ('Atalho salvo em: ' + $desktop + '\File Indexer.lnk')"

if errorlevel 1 (
    echo [ERRO] Falha ao criar o atalho.
    pause
    exit /b 1
)

echo.
echo ==========================================
echo   Instalacao concluida com sucesso!
echo ==========================================
echo.
echo Procure pelo icone "File Indexer" na sua Area de Trabalho
echo e de duplo clique para abrir o programa.
echo.
echo ^(O programa roda em modo silencioso - nenhum terminal
echo  aparece. Para usar, abra http://localhost:7432 no navegador.^)
echo.
pause
endlocal
