================================================================
                   FILE INDEXER
       Indexador e buscador de arquivos locais
                Instruções de uso
================================================================


ÍNDICE
------
  1. O que é o programa
  2. O que vem na pasta
  3. Instalação em máquina COM internet
  4. Instalação em máquina SEM internet (offline) - UM CLIQUE SÓ
  5. Modo silencioso e atalho de espião
  6. Uso do dia a dia
  7. Indexar uma pasta no NAS (rede)
  8. Arquivos .doc antigos (Word 97-2003)
  9. Onde ficam os dados
 10. Problemas comuns e soluções


================================================================
1. O QUE É O PROGRAMA
================================================================

O File Indexer lê as pastas que você escolher, extrai o texto de
arquivos PDF, DOCX, ODT, TXT, CSV, HTML, código-fonte e até dentro
de ZIPs, e guarda tudo em um banco de dados local de busca rápida.

Depois, você abre uma página web local e pesquisa por qualquer
palavra — o programa mostra os arquivos que contêm o termo e um
trecho do texto com a palavra destacada. Você pode clicar para
abrir o arquivo direto no gerenciador do Windows.

Tudo roda na sua máquina, sem nenhuma conexão externa.


================================================================
2. O QUE VEM NA PASTA
================================================================

Ao abrir a pasta "file_indexer" você verá 2 arquivos soltos e
3 subpastas:

  [arquivo] instalador.bat
    Instalador completo offline - instala Python, dependências
    e cria o atalho no Desktop, tudo em um só clique

  [arquivo] INSTRUCOES.txt
    Este arquivo

  [pasta]   programa\
    Núcleo do programa - você não precisa mexer aqui:
      - indexer.py             Programa principal (Python)
      - ui.html                Interface web (HTML)
      - file_indexer.bat       Iniciador visível (modo debug)
      - file_indexer_silent.vbs Iniciador silencioso
      - file_indexer.ico       Ícone de espião

  [pasta]   instalacao_offline\
    Tudo relacionado à instalação sem internet:
      - baixar_deps.bat        Baixa as dependências (rode
                               numa máquina COM internet)
      - python-*.exe           VOCÊ precisa baixar e colocar
                               aqui (o instalador do Python)
      - wheels\                Pasta gerada pelo baixar_deps.bat
                               com os pacotes Python

  [pasta]   mac_linux\
    Scripts para quem vai usar em macOS/Linux:
      - iniciar.sh             Iniciador para Linux
      - FileIndexer.command    Iniciador para macOS (duplo clique)
      - README.md              Documentação técnica resumida


================================================================
3. INSTALAÇÃO EM MÁQUINA COM INTERNET
================================================================

PASSO 1 - Instalar o Python
  - Baixe em: https://www.python.org/downloads/
  - Escolha "Windows installer (64-bit)"
  - Execute o instalador e MARQUE a opção
    "Add Python to PATH" logo na primeira tela
  - Clique em "Install Now"

PASSO 2 - Conferir se instalou certo
  - Abra o Prompt de Comando (tecla Windows, digite "cmd")
  - Rode:
        py --version
  - Deve aparecer algo como "Python 3.14.0"

PASSO 3 - Iniciar o programa
  - Entre na subpasta "programa\"
  - Dê duplo clique em "file_indexer.bat"
  - Na primeira execução ele vai baixar as bibliotecas
    automaticamente (leva cerca de 1 minuto)
  - Depois, o navegador abre em http://localhost:7432

  DICA: para ter o atalho de espião no Desktop mesmo com
  internet, pode rodar o "instalador.bat" do jeito normal -
  ele pula a instalação do Python e dependências (que já
  estão presentes) e só cria o atalho no Desktop.


================================================================
4. INSTALAÇÃO EM MÁQUINA SEM INTERNET (OFFLINE) - UM CLIQUE SÓ
================================================================

O instalador único ("instalador.bat") faz TUDO em sequência:
  (1) Instala o Python (se ainda não estiver instalado)
  (2) Instala as bibliotecas a partir da pasta "wheels\"
  (3) Cria o atalho "File Indexer" na Área de Trabalho

Nenhuma ação manual entre as etapas. Nenhuma internet.

ATENÇÃO: a versão do Python na máquina offline precisa ser a
MESMA usada para baixar os wheels na máquina com internet. Se
você vai instalar Python 3.14 na máquina offline, baixe os
wheels também com Python 3.14 na máquina de preparo.

------------------------------------
PARTE A - Na máquina COM internet:
------------------------------------

  A1. Instale o Python (mesma versão que será usada na offline)

  A2. Copie a pasta "file_indexer" para essa máquina

  A3. Entre na subpasta "instalacao_offline\" e dê duplo clique
      em "baixar_deps.bat". Ele cria a pasta "wheels\" ali
      mesmo, com todos os pacotes dentro

  A4. Baixe o INSTALADOR DO PYTHON (.exe) em
      python.org/downloads (ex.: python-3.14.0-amd64.exe)
      e coloque dentro de "instalacao_offline\"

  A5. Copie a pasta "file_indexer" inteira (com as 3
      subpastas) para o pendrive. Confira que dentro de
      "instalacao_offline\" tem:
        - baixar_deps.bat
        - python-*.exe   (o que você colocou)
        - wheels\        (pasta com os pacotes)

------------------------------------
PARTE B - Na máquina SEM internet:
------------------------------------

  B1. Copie a pasta "file_indexer" inteira para o disco
      (ex.: C:\file_indexer)

  B2. Entre na pasta e dê duplo clique em "instalador.bat"
      Ele vai:
        [1/3] Instalar o Python a partir do
              "instalacao_offline\python-*.exe" (se já tiver
              Python, pula essa etapa)
        [2/3] Instalar as dependências de
              "instalacao_offline\wheels\"
        [3/3] Criar o atalho "File Indexer.lnk" na Área de
              Trabalho, apontando para
              "programa\file_indexer_silent.vbs"

  B3. Pronto. Procure pelo ícone "File Indexer" na Área de
      Trabalho e dê duplo clique para abrir o programa


================================================================
5. MODO SILENCIOSO E ATALHO DE ESPIÃO
================================================================

O atalho "File Indexer" criado pelo "instalador.bat" já roda o
programa em MODO SILENCIOSO — nenhuma janela preta de terminal
aparece na tela.

COMO ABRIR
  - Duplo clique no ícone "File Indexer" da Área de Trabalho
  - Aguarde alguns segundos
  - Abra http://localhost:7432 no navegador para usar o programa

PARA PARAR O PROGRAMA
  - Abra o Gerenciador de Tarefas (Ctrl+Shift+Esc)
  - Encontre o processo "python.exe" (ou "pythonw.exe")
  - Clique com o botão direito e escolha "Finalizar tarefa"

DICAS
  - Você pode clicar com o botão direito no atalho e escolher
    "Fixar na barra de tarefas" ou "Fixar em Iniciar"
  - O atalho pode ser copiado para qualquer lugar

COMO FUNCIONA POR DENTRO
  - O atalho aponta para "wscript.exe" passando o arquivo
    "file_indexer_silent.vbs" como argumento
  - O .vbs executa o "file_indexer.bat" com a janela escondida
  - O servidor Python roda em segundo plano

QUANDO USAR O MODO VISÍVEL (file_indexer.bat direto)
  - Se algo deu errado e você quer ver a mensagem de erro
  - Para parar com Ctrl+C em vez de usar o Gerenciador de
    Tarefas
  - Para acompanhar o progresso da primeira indexação em
    máquinas lentas

RECRIAR O ATALHO (se apagar sem querer)
  - Basta rodar o "instalador.bat" de novo - ele detecta que
    o Python e as dependências já estão instalados e só
    recria o atalho no Desktop


================================================================
6. USO DO DIA A DIA
================================================================

ABRIR
  - Duplo clique em "File Indexer.lnk" (ou no .bat direto)
  - Espere aparecer a mensagem "Abrindo em: http://localhost:7432"
  - O navegador abre automaticamente
  - Para parar, feche a janela preta do Prompt de Comando
    ou aperte Ctrl+C nela

INDEXAR UMA PASTA (primeiro uso)
  - Digite o caminho no campo de indexação
    (ex.: C:\Users\SeuNome\Documentos)
  - Clique em "Indexar"
  - Acompanhe o progresso na tela
  - Pode fechar a aba depois, o índice fica salvo

PESQUISAR
  - Digite no campo de busca
      palavra        -> busca qualquer arquivo com essa palavra
      "frase exata"  -> busca a frase exatamente
  - Use os filtros para restringir por:
      - Tipo de arquivo (.pdf, .docx, etc.)
      - Origem (arquivo direto ou dentro de ZIP)
  - Clique em qualquer resultado para ver detalhes
  - Clique em "Abrir" para abrir no Explorer

REINDEXAR
  - Quando você adicionar/modificar muitos arquivos, rode
    a indexação de novo na mesma pasta — ele atualiza o que
    mudou

MÚLTIPLAS PASTAS
  - Você pode indexar várias pastas diferentes
  - Todas ficam no mesmo índice e aparecem juntas na busca

ARQUIVOS PROTEGIDOS POR SENHA
  - Word (.docx/.doc), Excel e PowerPoint protegidos por
    senha são detectados automaticamente e PULADOS durante
    a indexação (não são adicionados ao índice)
  - Eles aparecem na lista de "erros/arquivos pulados" ao
    final da indexação, com a mensagem
       "protegido por senha — ignorado"
  - A indexação continua normalmente com os demais arquivos
  - Se no futuro você remover a senha do arquivo, basta
    rodar a indexação de novo na mesma pasta que ele é
    incluído


================================================================
7. INDEXAR UMA PASTA NO NAS (REDE)
================================================================

O indexador funciona tanto com pastas locais quanto com pastas
de rede (NAS, servidor compartilhado). O programa não precisa
de nenhuma configuração especial — basta o Windows enxergar o
NAS.

OPÇÃO 1 - Mapear drive de rede (recomendado)
  1. Abra o Explorador de Arquivos
  2. Clique com botão direito em "Este Computador"
  3. Escolha "Mapear unidade de rede"
  4. Escolha uma letra (ex.: Z:)
  5. No caminho, digite:
        \\nome-do-nas\pasta-compartilhada
     (ou com IP: \\192.168.1.100\dados)
  6. Marque "Conectar novamente ao entrar" para persistir
  7. Se pedir senha, marque também "Usar credenciais
     diferentes" e preencha
  8. No File Indexer, use "Z:\" como caminho

OPÇÃO 2 - Caminho UNC direto
  - No campo de diretório digite:
        \\nome-do-nas\pasta
  - Funciona desde que as credenciais já estejam salvas
    no Windows (senão use a Opção 1)

OBSERVAÇÕES
  - A indexação pela rede é mais lenta que a local
  - Evite indexar arquivos ZIP muito grandes via rede
  - Se a rede cair durante a indexação, o programa
    continua no próximo arquivo (não trava)


================================================================
8. ARQUIVOS .DOC ANTIGOS (WORD 97-2003)
================================================================

O formato .doc antigo (binário) é diferente do .docx moderno e
precisa de uma estratégia especial para ler o conteúdo. O File
Indexer tenta duas abordagens, nessa ordem:

ESTRATÉGIA 1 — VIA MICROSOFT WORD (melhor resultado)
  - Se o Windows tem o Microsoft Word instalado E o pacote
    "pywin32" está disponível, o indexador usa o próprio Word
    em segundo plano para extrair o texto
  - Extração 100% fiel, incluindo tabelas e formatação
  - O pywin32 é instalado automaticamente pelo file_indexer.bat
    quando tem internet, e pelo instalar_offline.bat quando
    você preparou os wheels

ESTRATÉGIA 2 — EXTRAÇÃO BÁSICA (fallback, sem Word)
  - Se não tem Word ou pywin32, o indexador faz uma extração
    "best effort" procurando trechos de texto legíveis no
    binário do arquivo
  - Resultado: a busca por palavras-chave funciona (você acha
    o arquivo), mas o preview pode vir com alguns caracteres
    estranhos entre as palavras
  - É suficiente para localizar arquivos antigos, só não é
    bonito de visualizar

VERIFICAR QUAL ESTRATÉGIA ESTÁ ATIVA
  - Abra o Prompt de Comando na pasta do programa e rode:
        py -c "import win32com.client; print('Word COM OK')"
  - Se aparecer "Word COM OK", você tem a estratégia 1
  - Se der erro, está usando a estratégia 2

FORÇAR MELHOR QUALIDADE
  - Em máquina COM internet, rode no Prompt de Comando:
        py -m pip install pywin32
  - Isso instala o componente e habilita o uso do Word

OBSERVAÇÃO IMPORTANTE
  - O Word COM abre o arquivo em segundo plano, então a
    indexação de .doc é um pouco mais lenta (cerca de 1 a 2
    segundos por arquivo)
  - Se você tiver muitos .doc (ex.: 1000+ arquivos), considere
    converter para .docx de uma vez pelo próprio Word ou
    LibreOffice para acelerar buscas futuras


================================================================
9. ONDE FICAM OS DADOS
================================================================

O índice (banco de dados com o conteúdo dos arquivos) fica em:

    C:\Users\SeuNome\.file_indexer\index.db

Os arquivos originais NÃO são movidos nem copiados — o índice
só guarda uma referência ao caminho e o texto extraído.

Para apagar todo o índice e começar do zero:
  - Feche o programa
  - Apague a pasta C:\Users\SeuNome\.file_indexer


================================================================
10. PROBLEMAS COMUNS E SOLUÇÕES
================================================================

"A janela abre e fecha na hora"
  - Pode ser arquivo .bat com formato de quebra de linha
    errado. Use os .bat que vieram nesta pasta
  - Rode pelo Prompt de Comando para ver a mensagem:
        cd caminho\para\a\pasta
        file_indexer.bat

"Python não foi encontrado"
  - Instale o Python em python.org/downloads
  - MARQUE "Add Python to PATH" no instalador
  - Reinicie o computador se ainda não reconhecer

"Erro de conexão ao instalar dependências"
  - Você está sem internet. Use o fluxo OFFLINE
    (seção 4 deste documento)

"else was unexpected at this time"
  - Arquivo .bat antigo. Substitua pelos .bat atualizados
    que vieram nesta pasta

"Cannot import setuptools.build_meta"
  - Falta o setuptools no seu Python 3.12+
  - Rode: py -m pip install setuptools wheel
  - Se estiver offline, o "instalador.bat" já trata esse
    caso automaticamente (instala setuptools e wheel antes
    das outras dependências)

"Nenhum instalador do Python (python-*.exe) encontrado"
  - O "instalador.bat" procura o .exe dentro da subpasta
    "instalacao_offline\"
  - Baixe em python.org/downloads e coloque o .exe dentro
    de "instalacao_offline\", depois rode o "instalador.bat"
    de novo

"Pasta wheels\ não encontrada"
  - O "instalador.bat" espera que a pasta "wheels\" esteja
    dentro de "instalacao_offline\"
  - Rode o "baixar_deps.bat" (que fica dentro de
    "instalacao_offline\") na máquina COM internet antes
    para gerar os wheels, depois copie a pasta raiz do
    File Indexer inteira para a máquina offline

"Porta 7432 em uso"
  - Outro programa (ou uma instância antiga do File Indexer)
    está usando a porta. Feche a outra janela preta do
    Prompt de Comando e tente de novo

"Não consigo acessar o NAS"
  - Teste no Explorador primeiro. Se o Windows não enxerga
    o NAS, o File Indexer também não vai enxergar
  - Veja a seção 7 para configurar o acesso

"Caracteres estranhos nos textos extraídos"
  - Arquivos em codificação rara podem vir com símbolos
    esquisitos. Isso é limitação da extração, não bug do
    programa. O resultado da busca ainda funciona.


================================================================
                   FIM DAS INSTRUÇÕES
================================================================
