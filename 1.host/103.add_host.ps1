#
# add host to vcenter
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
	echo $f.alias
	#
	#  add host with domain name
	#
	Add-VMHost $f.alias -Location $f.cluster -User root -Password VMware1! -force:$true -confirm:$false
	#
	# add host with ip address
	#
	#Add-VMHost $f.ip -Location $f.cluster -User root -Password VMware1! -force:$true -confirm:$false
}
Disconnect-VIServer -Server * -Force -confirm:$false
