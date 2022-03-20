cd C:
ren X:\*.x12* "ca%date:~4,2%%date:~7,2%%time:~-11,2%%time:~3,2%%time:~6,2%%ip.01"

"C:\Program Files (x86)\WinSCP\WinSCP.com" /script=X:\commands-put.txt

if %ERRORLEVEL% neq 0 goto error
 
rem Upload succeeded, moving local files
move X:\*.01* "X:\Destination Folder"
exit /b 0
 
:error
rem Upload failed, keeping local files
exit /b 1