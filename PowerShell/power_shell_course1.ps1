# Declaring an array.
$array = @()

# Getting all system processes.
$processes = Get-Process

# Loop through processes and find anything > 100mb
# then store is in array by turning it to Psobjects.
ForEach($proc in $processes) {
    if($proc.WS/1mb -gt 100) {
        $array += New-Object psobject -Property @{'Process Name' = $proc.ProcessName; 'Working Set' = $proc.WS}
    }
}

# Export content of array to CSV file.
$array | Select-Object 'Process Name', 'Working Set' | Export-Csv .\Processes.csv -NoTypeInformation

# Import CSV file.
$csv_import = @()
$csv_import = Import-Csv .\Processes.csv

# Loop through content of CSV file.
ForEach($item in $csv_import) {
    Write-Host 'Process Name:' $item.processname 'Working Set:' $item.workingset
}

$csv_import | Format-Table -AutoSize