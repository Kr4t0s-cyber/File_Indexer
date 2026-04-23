#!/bin/bash
# ╔══════════════════════════════════════════╗
# ║     📂  File Indexer — macOS launcher   ║
# ╚══════════════════════════════════════════╝
# Este arquivo fica em "mac_linux/" e o programa em "../programa/".
# Dê duplo clique para iniciar!

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DIR="$(cd "$SCRIPT_DIR/../programa" && pwd)"
cd "$DIR"

clear
echo ""
echo "╔══════════════════════════════════════════╗"
echo "║     📂  File Indexer  —  macOS          ║"
echo "╚══════════════════════════════════════════╝"
echo ""

if ! command -v python3 &> /dev/null; then
    echo "❌  Python 3 não encontrado."
    echo ""
    echo "Instale via Homebrew:"
    echo "   /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    echo "   brew install python"
    echo ""
    read -p "Pressione Enter para fechar..."
    exit 1
fi

PYTHON=$(command -v python3)

echo "🐍  Python: $($PYTHON --version)"
echo ""

install_if_missing() {
    local module=$1
    local package=$2
    if ! $PYTHON -c "import $module" 2>/dev/null; then
        echo "📦  Instalando $package..."
        $PYTHON -m pip install "$package" --quiet --disable-pip-version-check
    fi
}

echo "🔍  Verificando dependências..."
install_if_missing "flask"     "flask"
install_if_missing "pdfminer"  "pdfminer.six"
install_if_missing "docx"      "python-docx"
install_if_missing "odf"       "odfpy"
install_if_missing "chardet"   "chardet"
echo "✅  Dependências OK"
echo ""

if [ ! -f "$DIR/indexer.py" ]; then
    echo "❌  indexer.py não encontrado em: $DIR"
    echo "    Certifique-se de que indexer.py e ui.html estão na mesma pasta."
    read -p "Pressione Enter para fechar..."
    exit 1
fi

if [ ! -f "$DIR/ui.html" ]; then
    echo "❌  ui.html não encontrado em: $DIR"
    read -p "Pressione Enter para fechar..."
    exit 1
fi

if lsof -i :7432 -sTCP:LISTEN &>/dev/null; then
    echo "⚠️   Porta 7432 já está em uso — o app pode já estar rodando."
    echo "🌐  Abrindo http://localhost:7432 ..."
    open "http://localhost:7432"
    echo ""
    read -p "Pressione Enter para fechar..."
    exit 0
fi

echo "🚀  Iniciando File Indexer..."
echo "🌐  Acesse: http://localhost:7432"
echo ""
echo "────────────────────────────────────────────"
echo "  Pressione Ctrl+C para parar o servidor"
echo "────────────────────────────────────────────"
echo ""

$PYTHON "$DIR/indexer.py"

echo ""
echo "👋  File Indexer encerrado."
read -p "Pressione Enter para fechar..."
