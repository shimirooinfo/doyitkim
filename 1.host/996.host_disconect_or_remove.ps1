#
# Remove host from vCenter
#

. "$HOME/scripts/globalval.ps1"

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.alias 
	Set-VMHost  $f.ip -State "Disconnect" -RunAsync -confirm:$false
	Get-VMhost $f.ip |Remove-VMHost -RunsAsync -confirm:$false
}
Disconnect-VIServer -Server * -Force -confirm:$false
