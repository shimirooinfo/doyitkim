#
# add_vswitch
#

. "$HOME/scripts/globalval.ps1"

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.alias
	#vmotion port group
	New-VMHostNetworkAdapter -VMHost $f.alias -VirtualSwitch vSwitch0 -PortGroup $VMOT_PG_NAME  -IP $f.vmotion -SubnetMask 255.255.255.0 -VMotionEnabled $true
	Get-VirtualPortGroup -Name $VMOT_PG_NAME -VMHost $f.alias|set-virtualportgroup -VlanID $MGMT_PG_VLAN
	# 
	New-VirtualSwitch -VMHost $f.alias -Name vSwitch1 -Nic vmnic4,vmnic5 -Mtu 9000
	Get-VMhost $f.alias|Get-VirtualSwitch -Name vSwitch1|New-VirtualPortGroup -Name $SVC1_PG_NAME -VlanID $SVC1_PG_VLAN
	New-VMHostNetworkAdapter -VMHost $f.alias -VirtualSwitch vSwitch1 -PortGroup $ISC1_PG_NAME -IP $f.iscsi1 -SubnetMask 255.255.255.0
	New-VMHostNetworkAdapter -VMHost $f.alias -VirtualSwitch vSwitch1 -PortGroup $ISC2_PG_NAME -IP $f.iscsi2 -SubnetMask 255.255.255.0
	Get-VirtualPortGroup -Name $ISC1_PG_NAME -VMHost $f.alias|set-virtualportgroup -VlanID $ISC1_PG_VLAN
	Get-VirtualPortGroup -Name $ISC2_PG_NAME -VMHost $f.alias|set-virtualportgroup -VlanID $ISC2_PG_VLAN

	#
	# remove "vm network" portgroup
	Get-vmhost $f.alias | get-virtualportgroup -name "vm network" | remove-virtualportgroup -Confirm:$false
	# change management network porgroup name
	get-vmhost $f.alias | get-virtualportgroup -name "management network" | set-virtualportgroup -name $MGMT_PG_NAME
}
Disconnect-VIServer -Server * -Force -confirm:$false
