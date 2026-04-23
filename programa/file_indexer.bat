@echo off
REM File Indexer - Windows Launcher
REM Coloque este arquivo na mesma pasta que indexer.py e ui.html

setlocal
cd /d "%~dp0"

echo.
echo ========================================
echo        File Indexer  ^|  Windows
echo ========================================
echo.

set "PYCMD="

py -3 --version >nul 2>nul
if not errorlevel 1 set "PYCMD=py -3" & goto :found_py

py --version >nul 2>nul
if not errorlevel 1 set "PYCMD=py" & goto :found_py

python --version >nul 2>nul
if not errorlevel 1 set "PYCMD=python" & goto :found_py

echo [ERRO] Python 3 nao encontrado no PATH.
echo.
echo Se voce ja instalou, abra o Prompt de Comando e teste:
echo     py --version
echo     python --version
echo.
echo Se nenhum funcionar, instale em https://www.python.org/downloads/
echo e marque a opcao "Add Python to PATH" no instalador.
pause
exit /b 1

:found_py
echo Usando interpretador: %PYCMD%
echo Verificando dependencias...

%PYCMD% -c "import flask"    >nul 2>nul || %PYCMD% -m pip install flask --quiet
%PYCMD% -c "import pdfminer" >nul 2>nul || %PYCMD% -m pip install pdfminer.six --quiet
%PYCMD% -c "import docx"     >nul 2>nul || %PYCMD% -m pip install python-docx --quiet
%PYCMD% -c "import odf"      >nul 2>nul || %PYCMD% -m pip install odfpy --quiet
%PYCMD% -c "import chardet"  >nul 2>nul || %PYCMD% -m pip install chardet --quiet
REM pywin32 e opcional (habilita extracao de .doc via Word). Se falhar nao e erro.
%PYCMD% -c "import win32com.client" >nul 2>nul || %PYCMD% -m pip install pywin32 --quiet 2>nul

echo Dependencias OK.
echo.
echo Abrindo em: http://localhost:7432
echo Pressione Ctrl+C para parar.
echo.

%PYCMD% indexer.py

endlocal
