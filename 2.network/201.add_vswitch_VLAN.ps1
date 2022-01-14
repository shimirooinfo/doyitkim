#
# add_vswitch
#
# target 파일을 매개변수로 받을때 아래 주석 해제
#
#Param(
#        [Parameter(Mandatory=$True,Position=1)]
#        [string]$targetfile
#)
# target 파일을 매개변수로 받을때 아래 주석 처리
$TgtFile = "../0.target/tgt_d80_all.csv"

#$VcInfoFile = "../0.target/vc_iroo.csv"
$VcInfoFile = "../0.target/vc_kko_vc70.csv"

# Connect to the vCenter Server
foreach ($VcInfo in (import-csv -path $VcInfoFile))
{
        Write-host "Connecting to vCenter Server: " -ForegroundColor Green -NoNewline; Write-Host $VcInfo.vc -ForegroundColor Yellow
        Connect-VIServer -Server $VcInfo.vc -user $VcInfo.user -password $VcInfo.passwd -Protocol https
}

$SVC1_PG_NAME = "service-for-v10"
$VMOT_PG_NAME = "mgmt-for-vmotion"
$MGMT_PG_NAME = "mgmt-for-vcenter"
$ISC1_PG_NAME = "service-for-iscsi1"
$ISC2_PG_NAME = "service-for-iscsi2"
$ISC1_PG_VLAN = "50"
$ISC2_PG_VLAN = "60"
$SVC1_PG_VLAN = "10"
#

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
