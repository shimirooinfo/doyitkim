#
# ESXi IQN ¼öÁý Scripts
#
$device = "vmhba40"
$VcInfoFile = "../0.target/vcenter_vc70.csv"
$TgtFile = "../0.target/tgt_s80_all.csv"
#
# Connect to the vCenter Server
"{0} Connecting to vcenter server..."
foreach ($VcInfo in (import-csv -path $VcInfoFile))
{
	Connect-VIServer -Server $VcInfo.vc -user $VcInfo.user -password $VcInfo.passwd -Protocol https
}

# Connect to the vCenter Server
"{0} Connecting to vcenter server..."
Connect-VIServer -Server $vcenter -user $user -password $password -Protocol https

foreach ($f in (import-csv -path $TgtFile))
{
	echo "############################################" >> $OutputFile 
 	echo $f.alias >> $OutputFile 
	echo "############################################" >> $OutputFile 
	get-vmhosthba $f.ip -device $device | format-table -Autosize  VMHost,IScsiName >> $OutputFile
}
Disconnect-VIServer -Server * -Force -confirm:$false

