#
# set jubmo frame for iscsi vmk
#

. "$HOME/scripts/globalval.ps1"

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.alias
	$esxcli = Get-Esxcli -vmhost $f.alias
	$esxcli.network.ip.interface.set("true", "vmk2", "9000")
	$esxcli.network.ip.interface.set("true", "vmk3", "9000")
	$esxcli.network.vswitch.standard.set("listen", "9000", "vSwitch1")
}
Disconnect-VIServer -Server * -Force -confirm:$false
