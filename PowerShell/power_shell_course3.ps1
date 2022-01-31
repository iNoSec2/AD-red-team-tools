# Lesson about foreach
# Does not work with PIPES

$object_array = Import-Csv .\Processes.csv

foreach($object in $object_array) {
    Write-Host "The name of the oject is:" $object.'Process Name' -ForegroundColor Red
}

$total_ws = 0
foreach($object in $object_array) {
    $total_ws = $total_ws + $object.'Working Set'
}
Write-Host 'The total value of Worsking Set is:' $total_ws -ForegroundColor Blue

