#
# PowerShell Script based for Mac
#
# vCenter 정보와 작업 대상 ESXi 서버에 사용될 정보를 저장한 파일을 지정한다.
#
#
$TgtFile = "$HOME/scripts/0.target/target.csv"
$VcInfoFile = "$HOME/scripts/0.target/vc_iroo.csv"

# ntp server
$time1 = "time1.daumkakao.io"
$time2 = "time2.daumkakao.io"
$time3 = "time3.daumkakao.io"

# domain name
$DomainName = "virt.onkakao.net"
$DnsSvr = "10.20.30.40"

# portgroup
$SVC1_PG_NAME = "service-for-v10"
$VMOT_PG_NAME = "mgmt-for-vmotion"
$MGMT_PG_NAME = "mgmt-for-vcenter"
$ISC1_PG_NAME = "service-for-iscsi1"
$ISC2_PG_NAME = "service-for-iscsi2"

# vlan portgroup
$ISC1_PG_VLAN = "50"
$ISC2_PG_VLAN = "60"
$SVC1_PG_VLAN = "10"

# unload module
$unload_module1="bnx2i"
$unload_module2="fcoe"

# Connect to the vCenter Server
foreach ($VcInfo in (import-csv -path $VcInfoFile))
{
        Write-host "Connecting to vCenter Server: " -ForegroundColor Green -NoNewline; Write-Host $VcInfo.vc -ForegroundColor Yellow
        Connect-VIServer -Server $VcInfo.vc -user $VcInfo.user -password $VcInfo.passwd -Protocol https
}
