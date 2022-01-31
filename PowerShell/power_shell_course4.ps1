# Lesson about If-Else-Elseif

# -eq -lt -gt -le -ge as comparisson operators
# -not and ! are the same
# -and
$test = 1
if ($test -lt 10) {
    Write-Host "Test is less than 10"
}

if (-not $Error) {
    Write-Host "There are no errors"
}

if ($test -ge 1 -and -not $Error) {
    Write-Host "1 == 1 and not errors"
}

if ($test -eq 0 -and $Error) {
    Write-Host "This is false"
} elseif ($test -eq 1) {
    Write-Host "Testing elseif"
}