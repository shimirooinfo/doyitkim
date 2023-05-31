#
#
#
$VcInfoFile = "../0.target/vc_iroo.csv"
$TgtFile = "../0.target/tgt_iroo.csv"
$OutFile = "../99.output/vmnet.txt"

foreach ($f in (import-csv -path $TgtFile))
{

	Write-host "Deploying VM " -ForegroundColor Green -NoNewline; Write-Host $vm -ForegroundColor Yellow

	echo "############################################" >> $OutFile 
 	echo $f.alias >> $OutFile 
	echo "############################################" >> $OutFile 
	$vms = get-vmhost $f.alias |get-vm
	foreach($vm in $vms)
	{
#		get-vmguest -VM $vm |select IPAddress, HostName, VmName
		#get-vmguestNetworkinterface -vm $vm -GuestUser root -GuestPassword vmware1! |select VM, Defaultgateway >> $OutFile
		get-vmguestNetworkinterface -vm $vm -GuestUser root -GuestPassword vmware1! |export-csv $OutFile
	}
}
Disconnect-VIServer -Server * -Force -confirm:$false
