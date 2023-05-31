#
# Remove host from vCenter
#
# target 파일을 매개변수로 받을때 아래 주석 해제
#
#Param(
#        [Parameter(Mandatory=$True,Position=1)]
#        [string]$targetfile
#)
# target 파일을 매개변수로 받을때 아래 주석 처리

. "$HOME/scripts/globalval.ps1"

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.alias 
	Set-VMHost  $f.ip -State "Disconnect" -RunAsync -confirm:$false
	Get-VMhost $f.ip |Remove-VMHost -RunsAsync -confirm:$false
}
Disconnect-VIServer -Server * -Force -confirm:$false
