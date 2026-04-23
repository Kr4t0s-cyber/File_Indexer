#!/bin/bash
# File Indexer - macOS/Linux Launcher
# Este arquivo fica na pasta "mac_linux/" do File Indexer.
# O programa em si (indexer.py / ui.html) fica em "../programa/".

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DIR="$(cd "$SCRIPT_DIR/../programa" && pwd)"
cd "$DIR"

echo ""
echo "╔══════════════════════════════════════╗"
echo "║     📂  File Indexer  macOS          ║"
echo "╚══════════════════════════════════════╝"
echo ""

# Check Python
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 não encontrado. Instale via: brew install python"
    exit 1
fi

# Install dependencies if needed
echo "🔍 Verificando dependências..."
python3 -c "import flask" 2>/dev/null || pip3 install flask --quiet
python3 -c "import pdfminer" 2>/dev/null || pip3 install pdfminer.six --quiet
python3 -c "import docx" 2>/dev/null || pip3 install python-docx --quiet
python3 -c "import odf" 2>/dev/null || pip3 install odfpy --quiet
python3 -c "import chardet" 2>/dev/null || pip3 install chardet --quiet

echo "✅ Dependências OK"
echo ""
echo "🌐 Abrindo em: http://localhost:7432"
echo "   Pressione Ctrl+C para parar"
echo ""

python3 indexer.py
