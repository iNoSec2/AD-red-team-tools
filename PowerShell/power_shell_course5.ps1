# Course about Switch

# Color codes chrome, VSCode, and powershell process
# Turns other processes to yellow
# Counts how manny of each processes are running and the amount of memmory they are using
$processes = Get-Process
$google_proc = 0
$google_mem = 0
$vscode_proc = 0
$vscode_mem = 0
$powershell_proc = 0
$powershell_mem = 0

foreach ($proc in $processes) {
    Switch ($proc.ProcessName) {
        chrome {
            Write-Host "Found Google Process called $_" -ForegroundColor red
            $google_proc = $google_proc + 1
            $google_mem = $google_mem + $proc.WoringSet
        }
        Code {
            Write-Host "Found VSCode Process called $_" -ForegroundColor blue
            $vscode_proc = $vscode_proc + 1
            $vscode_mem = $vscode_mem + $proc.WorkingSet
        }
        powershell {
            Write-Host "Found Powershell Process called $_" -ForegroundColor green
            $powershell_proc = $powershell_proc + 1
            $powershell_mem = $powershell_mem + $proc.WorkingSet
        }
        default {
            Write-Host "No Worry" -ForegroundColor yellow
        }
    }
}
Write-Host "There are $google_proc Google processes`n$vscode_proc VSCode Processes`n$powershell_proc Powershell Processes"
$total_mem = "{0:N2}" -f (($google_mem + $vscode_mem + $powershell_mem)/1gb)
Write-Host "Total memory used by google, VScode and Powershell is $total_mem mb"