#
# add dns
#

. "$HOME/scripts/globalval.ps1"

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.alias
	$vmHostNetworkInfo = Get-VmHostNetwork -Host $f.alias
	#Set-VmHostNetwork -Network $vmHostNetworkInfo -DomainName $DomainName -Dnsaddress $DnsSvr
	#Set-VmHostNetwork -HostName $f.hname -Network $vmHostNetworkInfo -DomainName $DomainName -Dnsaddress $DnsSvr
	Set-VmHostNetwork -HostName $f.hname -Network $vmHostNetworkInfo -DomainName $DomainName 
}
Disconnect-VIServer -Server * -Force -confirm:$false
