#
# change vmotion ip & remove vlan
#
$VMOT_PG_NAME = "mgmt-for-vmotion"
$VMOT_VMKNIC = "vmk1"
$VMOT_VLAN = "90"
#
#

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.alias
	#vmotion port group
	Get-VMHostNetworkadapter -Name $VMOT_VMKNIC -VMHost $f.alias|Set-VMHostNetworkadapter -IP $f.vmotion
	Get-VirutalPortGroup -Name $VMOT_PG_NAME -VMHost $f.alias|Set-VirtualPortGroup -VLanId 0
	# 
}
Disconnect-VIServer -Server * -Force -confirm:$false
