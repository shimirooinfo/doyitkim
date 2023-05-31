#
# Change Subnet Mask
#
$VMOT_VMKNIC = "vmk1"
#

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.alias
	#vmotion port group
	Get-VMHostNetworkadapter -Name $VMOT_VMKNIC -VMHost $f.alias|Set-VMHostNetworkadapter -IP $f.vmotion -subnetmask 255.255.248.0 -confirm:$false

}
Disconnect-VIServer -Server * -Force -confirm:$false
