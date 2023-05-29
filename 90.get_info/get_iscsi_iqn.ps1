#
# ESXi IQN ¼öÁý Scripts
#
$device = "vmhba40"

. "$HOME/scripts/globalval.ps1"

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

