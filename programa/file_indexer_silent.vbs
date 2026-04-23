' File Indexer - Silent launcher
' Executa file_indexer.bat sem mostrar a janela do terminal.
' Use este arquivo (ou o atalho ".lnk" gerado por criar_atalho.bat)
' para abrir o programa em modo silencioso.

Option Explicit

Dim WshShell, fso, scriptDir, batPath

Set WshShell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

scriptDir = fso.GetParentFolderName(WScript.ScriptFullName)
batPath = scriptDir & "\file_indexer.bat"

If Not fso.FileExists(batPath) Then
    MsgBox "file_indexer.bat nao foi encontrado em:" & vbCrLf & scriptDir, _
           vbCritical, "File Indexer"
    WScript.Quit 1
End If

' Run com parametros: (comando, WindowStyle, WaitForReturn)
'   WindowStyle = 0  -> janela oculta
'   WaitForReturn = False -> nao bloqueia o script
WshShell.CurrentDirectory = scriptDir
WshShell.Run """" & batPath & """", 0, False

Set WshShell = Nothing
Set fso = Nothing
