#
# Change Subnet Mask
#
$VMOT_VMKNIC = "vmk1"
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
	#vmotion port group
	Get-VMHostNetworkadapter -Name $VMOT_VMKNIC -VMHost $f.alias|Set-VMHostNetworkadapter -IP $f.vmotion -subnetmask 255.255.248.0 -confirm:$false

}
Disconnect-VIServer -Server * -Force -confirm:$false
