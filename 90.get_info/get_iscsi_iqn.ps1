#
# ESXi IQN ¼öÁý Scripts
#
$device = "vmhba40"

. "$HOME/scripts/globalval.ps1"

foreach ($f in (import-csv -path $TgtFile))
{
	echo "############################################" >> $OutputFile 
 	echo $f.alias >> $OutputFile 
	echo "############################################" >> $OutputFile 
	get-vmhosthba $f.ip -device $device | format-table -Autosize  VMHost,IScsiName >> $OutputFile
}
Disconnect-VIServer -Server * -Force -confirm:$false

