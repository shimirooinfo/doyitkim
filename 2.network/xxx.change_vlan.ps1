#
# Change VLAN
#
$SVC1_PG_NAME = "service-for-v10"
$SVC2_PG_NAME = "service-for-v20"
$VMOT_PG_NAME = "mgmt-for-vmotion"
$MGMT_PG_NAME = "mgmt-for-vcenter"
$ISC1_PG_NAME = "service-for-iscsi1"
$ISC2_PG_NAME = "service-for-iscsi2"
$ISC1_PG_VLAN = "50"
$ISC2_PG_VLAN = "60"
#

foreach ($f in (import-csv -path $TgtFile))
{
	
	Get-VirtualPortGroup -Name $ISC1_PG_NAME -VMHost $f.alias|set-virtualportgroup -VlanID $ISC1_PG_VLAN
	Get-VirtualPortGroup -Name $ISC2_PG_NAME -VMHost $f.alias|set-virtualportgroup -VlanID $ISC2_PG_VLAN

}
Disconnect-VIServer -Server * -Force -confirm:$false
