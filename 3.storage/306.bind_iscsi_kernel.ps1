#
# Bind iscsi kernel 
#

. "$HOME/scripts/globalval.ps1"

$sw_iscsi = "vmhba64"

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.alias
	$esxcli = Get-Esxcli -vmhost $f.alias
	$esxcli.iscsi.networkportal.add($sw_iscsi,$true,"vmk2")
	$esxcli.iscsi.networkportal.add($sw_iscsi,$true,"vmk3")
}
Disconnect-VIServer -Server * -Force -confirm:$false
