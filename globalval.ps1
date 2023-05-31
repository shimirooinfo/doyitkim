#
# PowerShell Script based for Mac
#
# vCenter 정보와 작업 대상 ESXi 서버에 사용될 정보를 저장한 파일을 지정한다.
#
#
$TgtFile = "$HOME/scripts/0.target/target.csv"
$VcInfoFile = "$HOME/scripts/0.target/vc_iroo.csv"

# Connect to the vCenter Server
foreach ($VcInfo in (import-csv -path $VcInfoFile))
{
        Write-host "Connecting to vCenter Server: " -ForegroundColor Green -NoNewline; Write-Host $VcInfo.vc -ForegroundColor Yellow
        Connect-VIServer -Server $VcInfo.vc -user $VcInfo.user -password $VcInfo.passwd -Protocol https
}
