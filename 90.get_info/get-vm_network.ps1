#
# VM IP 정보 수집 Scripts
#
$user = "seadmin@vsphere.local"
$password = "Vmware1!"
$vcenter = "10.141.252.247"
#
$targetfile ="C:\scripts.v5\01_target\target100.csv"
$outputfile = "C:\scripts.v5\00_output\info-vmnet.txt"


# Connect to the vCenter Server
"{0} Connecting to vcenter server..."
Connect-VIServer -Server $vcenter -user $user -password $password -Protocol https

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
