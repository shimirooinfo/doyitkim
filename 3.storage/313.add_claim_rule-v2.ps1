#
# Add Claim rule
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

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.ip
	$esxcli = Get-Esxcli -vmhost $f.alias -V2
	$satpArgs = $esxcli.storage.nmp.satp.rule.add.createArgs()
	$satpArgs.vendor = "DGC"
	$satpArgs.satp = "VMW_SATP_ALUA_CX"
	$satpArgs.psp = "VMW_PSP_RR"
	$satpArgs.pspoption = "iops=1"
	$satpArgs.claimoption = "tpgs_on"
	$esxcli.storage.nmp.satp.rule.add.invoke($satpArgs)
	$esxcli.storage.nmp.satp.rule.remove.invoke($satpArgs)
}
Disconnect-VIServer -Server * -Force -confirm:$false
