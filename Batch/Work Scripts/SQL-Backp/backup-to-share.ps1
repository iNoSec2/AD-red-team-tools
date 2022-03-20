$source = "C:\backups"
$destination = "X:\"
Copy-Item -Path $source\*.bak -Destination $destination -Force