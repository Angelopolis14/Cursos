Read-Host "ACCION PROGRAMADA, PARA HACER LA ELIMINACION DE ARCHIVOS INNECESARIOS DE SQL
           Press Enter to continue..."
$path="C:\Users\Alguien\Documents\Diego\prue" 
$t=New-JobTrigger -Weekly -DaysOfWeek 1,2,3,4,5 -At 13:00
Register-ScheduledJob -Name Test-HelpFiles1 -FilePath C:\DELETEDUMP\delete.ps1 -Trigger $t
$daystobearchived="-30"  
$currentdate=Get-Date  
$datetobedeleted=$currentdate.AddDays(-$daystobearchived)  
$files=Get-ChildItem $path -Recurse | Where-Object { $_.LastWriteTime -lt $datetobedeleted }
Foreach ($file in $files){ 
Remove-Item $file.FullName |out-null 
Write-Host "Cleared the file "$file 
}
$powershellArguments ="./delete.ps1"
PS C:\Users\Alguien\Documents\Diego> $app = Start-Process "powershell.exe" -ArgumentList $powershellArguments -PassThru
Read-Host "Press Enter to continue..."