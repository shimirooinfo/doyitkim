#
# Set a path selection policy
#

. "$HOME/scripts/globalval.ps1"

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.alias
	#get-vmhost $f.ip |Get-ScsiLun -LunType disk | Where-Object {$_.Model -eq "MD38xxi"} | Set-ScsiLun -MultipathPolicy "RoundRobin"
	get-vmhost $f.alias |Get-ScsiLun -LunType disk | Where-Object {$_.Canonicalname -like "naa.600*"} | Set-ScsiLun -MultipathPolicy "RoundRobin"
}
Disconnect-VIServer -Server * -Force -confirm:$false
