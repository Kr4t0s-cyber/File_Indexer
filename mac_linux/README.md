# 📂 File Indexer — macOS / Windows / Linux

Indexador e buscador de arquivos local multiplataforma. Indexa PDFs, DOCX, ODT, TXT, HTML, CSV, Markdown, código-fonte e muito mais — inclusive arquivos **dentro de ZIPs**.

---

## 🚀 Como usar

### 1. Pré-requisitos
- Python 3.8+
- pip

### 2. Instalar e rodar

**macOS / Linux:**
```bash
chmod +x iniciar.sh
./iniciar.sh
```

**Windows:** dê um duplo-clique em `iniciar.bat` (ou rode no Prompt de Comando):
```bat
iniciar.bat
```

O script instala as dependências automaticamente e abre `http://localhost:7432` no navegador.

Ou rode direto (qualquer SO):
```bash
pip install flask pdfminer.six python-docx odfpy chardet
python indexer.py
```

---

## 🗂 Formatos suportados

| Categoria | Extensões |
|-----------|-----------|
| Documentos | PDF, DOCX, DOC, ODT, ODS, ODP, RTF |
| Texto | TXT, MD, CSV, TSV, LOG, NFO |
| Web | HTML, HTM, XML |
| Código | PY, JS, TS, CSS, JAVA, C, CPP, H, RS, GO, RB, PHP |
| Config | JSON, YAML, YML, TOML, INI, CFG, CONF |
| Outros | TEX, RST, SRT, VTT |
| **Compactados** | **ZIP** (indexa o conteúdo internamente!) |

---

## ✨ Funcionalidades

- **Pesquisa full-text** com destaque do trecho encontrado
- **Dashboard interativo** com colunas redimensionáveis pelo mouse
- **Filtro por tipo** de arquivo e por origem (arquivo direto vs. dentro de ZIP)
- **Paginação** nos resultados
- **Estatísticas** detalhadas por extensão
- **Abrir no gerenciador de arquivos** (Finder / Explorer / Files) diretamente da busca
- **Múltiplos diretórios** podem ser indexados
- **Histórico** de diretórios indexados
- Banco de dados SQLite com **FTS5** (ultra-rápido)
- Índice salvo em `~/.file_indexer/index.db`

---

## 💡 Dicas de pesquisa

- `contrato` → busca arquivos que contêm essa palavra
- `contrato social` → busca o trecho exato (entre aspas internamente)
- Use os filtros para restringir por tipo de arquivo
- Clique em qualquer linha para ver detalhes no painel lateral
- Clique nos cabeçalhos das colunas para ordenar
- **Arraste a borda das colunas** para redimensioná-las

---

## 🏗 Arquitetura

```
indexer.py    → Backend Flask (API REST + extração de texto)
ui.html       → Frontend (HTML/CSS/JS puro, sem dependências externas)
iniciar.sh    → Script de inicialização macOS / Linux
iniciar.bat   → Script de inicialização Windows
~/.file_indexer/index.db → Banco SQLite com índice FTS5
    (no Windows fica em C:\Users\<voce>\.file_indexer\index.db)
```
