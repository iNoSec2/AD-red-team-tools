"C:\Program Files (x86)\WinSCP\WinSCP.com" /script=R:\commands-pull.txt

if %ERRORLEVEL% neq 0 goto error
 
rem Connection succeeded, moving local files

exit /b 0
 
:error
rem Connection failed, nothing happened
exit /b 1