# clone vm

Connect-VIServer -Server irvc01.iroo.int -user yhkim@lab -password vmware!0 -Protocol https
Get-VM | Where-Object {$_.PowerState -eq "PoweredOn"} | Get-CDDrive | Set-CDDrive -NoMedia -Confirm:$False
