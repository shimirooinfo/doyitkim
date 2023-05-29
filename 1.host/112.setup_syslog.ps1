#
# Disable SSH Warning Message 
#
# D80 적용하지 않음
#
# target 파일을 매개변수로 받을때 아래 주석 해제
#
#Param(
#        [Parameter(Mandatory=$True,Position=1)]
#        [string]$targetfile
#)
# target 파일을 매개변수로 받을때 아래 주석 처리
$TgtFile = "$HOME/scripts/0.target/tgt_d80_all.csv"

#$VcInfoFile = "$HOME/scripts/0.target/vc_iroo.csv"
$VcInfoFile = "$HOME/scripts/0.target/vc_kko_vc70.csv"

# Connect to the vCenter Server
foreach ($VcInfo in (import-csv -path $VcInfoFile))
{
        Write-host "Connecting to vCenter Server: " -ForegroundColor Green -NoNewline; Write-Host $VcInfo.vc -ForegroundColor Yellow
        Connect-VIServer -Server $VcInfo.vc -user $VcInfo.user -password $VcInfo.passwd -Protocol https
}

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.alias
	Set-VMHostSyslogServer -SyslogServer 10.15.73.147:514 -VMhost $f.alias

}
Disconnect-VIServer -Server * -Force -confirm:$false
