$rootfolder =  $env:USERPROFILE+"\Wästbygg Gruppen AB"

$json = @{
user = $env:UserName
computer = $env:ComputerName
totalNumberFiles = (Get-ChildItem $rootfolder -Recurse ).count
folders = (Get-ChildItem $rootfolder -Directory | ForEach-Object { [pscustomobject]@{name=$_.name; numFiles=($_ | Get-ChildItem -File -Recurse).count} } )
} | ConvertTo-Json

Invoke-WebRequest -Uri http://postit.evryway.se/Home/Postit -Method POST -Body $json  -ContentType "application/json"
