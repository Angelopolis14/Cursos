Write-Host "ACCION PROGRAMADA, PARA HACER LA ELIMINACION DE ARCHIVOS INNECESARIOS DE SQL"
$path="C:\Users\Alguien\Documents\Diego\prue" 
$daystobearchived="-30"  
$currentdate=Get-Date  
$datetobedeleted=$currentdate.AddDays(-$daystobearchived)  
$files=Get-ChildItem $path -Recurse | Where-Object { $_.LastWriteTime -lt $datetobedeleted }
Foreach ($file in $files){ 
Remove-Item $file.FullName |out-null 
Write-Host "Cleared the file "$file 
}

##trigget to schedule job daily at specific time
$trigger = New-JobTrigger -Weekly -DaysOfWeek 1,2,3,4,5 -At 09:15
$options = New-ScheduledJobOption -StartIfOnBattery
Register-ScheduledJob -Name DeleteDump -ScriptBlock {Get-Process} `
-Trigger $trigger -ScheduledJobOption $options

Write-Host "this jobs was running at: "$CurrentDate
Read-Host "Press Enter to continue..."