#
# Remove host from vCenter
#

. "$HOME/scripts/globalval.ps1"

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.ip 
	Set-VMHost  $f.ip -State "Maintenance" -confirm:$false
	Remove-VMHost $f.ip -confirm:$false
}
Disconnect-VIServer -Server * -Force -confirm:$false
