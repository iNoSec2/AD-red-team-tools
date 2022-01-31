# Lesson about how to use ForEach-Object
# Workd with PIPES
# Import CSV file

$object_array = Import-Csv .\Processes.csv
$total_set = 0
# Loop through each item on the array and print them.
$object_array | ForEach-Object {
    Write-Host 'The name of the object is:' $_.'Process Name'
    $total_set = $total_set + $_.'Working Set'
}
$total_set