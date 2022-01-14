#
# Change MTU
#
$VcInfoFile = "../0.target/vcenter_vc70.csv"
$TgtFile = "../0.target/tgt_d80_all.csv"
#
# Connect to the vCenter Server
"{0} Connecting to vcenter server..."
foreach ($VcInfo in (import-csv -path $VcInfoFile))
{
	Connect-VIServer -Server $VcInfo.vc -user $VcInfo.user -password $VcInfo.passwd -Protocol https
}

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.alias
	$esxcli = Get-Esxcli -vmhost $f.alias
	$esxcli.network.ip.interface.set("true", "vmk2", "1500")
	$esxcli.network.ip.interface.set("true", "vmk3", "1500")
}

Disconnect-VIServer -Server * -Force -confirm:$false
