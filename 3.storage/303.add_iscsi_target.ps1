#
# Add an iSCSI target
#
# target 파일을 매개변수로 받을때 아래 주석 해제
#
#Param(
#        [Parameter(Mandatory=$True,Position=1)]
#        [string]$targetfile
#)
# target 파일을 매개변수로 받을때 아래 주석 처리

. "$HOME/scripts/globalval.ps1"

# Connect to the vCenter Server
foreach ($VcInfo in (import-csv -path $VcInfoFile))
{
        Write-host "Connecting to vCenter Server: " -ForegroundColor Green -NoNewline; Write-Host $VcInfo.vc -ForegroundColor Yellow
        Connect-VIServer -Server $VcInfo.vc -user $VcInfo.user -password $VcInfo.passwd -Protocol https
}

$sw_iscsi_dev = "vmhba64"

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.ip
	Get-VMHost $f.alias | get-vmhosthba -device $sw_iscsi_dev | New-IScsiHbaTarget -Address $f.tgt1 
	Get-VMHost $f.alias | get-vmhosthba -device $sw_iscsi_dev | New-IScsiHbaTarget -Address $f.tgt2
	Get-VMHost $f.alias | get-vmhosthba -device $sw_iscsi_dev | New-IScsiHbaTarget -Address $f.tgt3
	Get-VMHost $f.alias | get-vmhosthba -device $sw_iscsi_dev | New-IScsiHbaTarget -Address $f.tgt4
}
Disconnect-VIServer -Server * -Force -confirm:$false
