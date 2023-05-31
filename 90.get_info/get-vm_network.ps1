#
# VM IP 정보 수집 Scripts
#
#

. "$HOME/scripts/globalval.ps1"

$outputfile = "C:\scripts.v5\00_output\info-vmnet.txt"

foreach ($f in (import-csv -path $targetfile))
{
	echo "############################################" >> $outputfile 
 	echo $f.alias >> $outputfile 
	echo "############################################" >> $outputfile 
	$vms = get-vmhost $f.alias |get-vm
	foreach($vm in $vms)
	{
		get-vmguest -VM $vm |select IPAddress, HostName, VmName
		#get-vmguestNetworkinterface -vm $vm -GuestUser root -GuestPassword vmware1! |select VM, Defaultgateway >> $outputfile
		get-vmguestNetworkinterface -vm $vm -GuestUser root -GuestPassword vmware1! |export-csv $outputfile
	}
}
Disconnect-VIServer -Server * -Force -confirm:$false
