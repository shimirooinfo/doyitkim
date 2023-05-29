#
# add dns
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

$DomainName = "virt.onkakao.net"
$DnsSvr = "10.20.30.40"

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.alias
	$vmHostNetworkInfo = Get-VmHostNetwork -Host $f.alias
	#Set-VmHostNetwork -Network $vmHostNetworkInfo -DomainName $DomainName -Dnsaddress $DnsSvr
	#Set-VmHostNetwork -HostName $f.hname -Network $vmHostNetworkInfo -DomainName $DomainName -Dnsaddress $DnsSvr
	Set-VmHostNetwork -HostName $f.hname -Network $vmHostNetworkInfo -DomainName $DomainName 
}
Disconnect-VIServer -Server * -Force -confirm:$false
