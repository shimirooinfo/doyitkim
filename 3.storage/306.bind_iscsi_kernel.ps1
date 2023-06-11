#
# Bind iscsi kernel 
#

. "$HOME/scripts/globalval.ps1"

$sw_iscsi = "vmhba64"
#
# get-vmhost irvs01.iroo.int|get-vmhosthba -type block |where {$_.Model -eq "PERC H730 Mini"} |Select -ExpandProperty Device -first 1
#

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.alias
	$esxcli = Get-Esxcli -vmhost $f.alias
	$esxcli.iscsi.networkportal.add($sw_iscsi,$true,"vmk2")
	$esxcli.iscsi.networkportal.add($sw_iscsi,$true,"vmk3")
}
Disconnect-VIServer -Server * -Force -confirm:$false
