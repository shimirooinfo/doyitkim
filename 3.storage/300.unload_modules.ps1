#
# Unload module
#

$unload_module1="bnx2i"
$unload_module2="fcoe"

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
	$esxcli.system.module.set($false, $false, $unload_module1 ) 
	$esxcli.system.module.set($false, $false, $unload_module2 ) 
}

Disconnect-VIServer -Server * -Force -confirm:$false
