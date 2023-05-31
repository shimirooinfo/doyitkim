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

. "$HOME/scripts/globalval.ps1"

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
