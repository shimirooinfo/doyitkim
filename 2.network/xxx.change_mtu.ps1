#
# Change MTU
#

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.alias
	$esxcli = Get-Esxcli -vmhost $f.alias
	$esxcli.network.ip.interface.set("true", "vmk2", "1500")
	$esxcli.network.ip.interface.set("true", "vmk3", "1500")
}

Disconnect-VIServer -Server * -Force -confirm:$false
