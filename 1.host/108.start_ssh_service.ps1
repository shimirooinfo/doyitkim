#
# ssh start to host
#
$VcInfoFile = "$HOME/scripts/0.target/vcenter_vc70.csv"
$TgtFile = "$HOME/scripts/0.target/tgt_d80_all.csv"
#
# Connect to the vCenter Server
"{0} Connecting to vcenter server..."
foreach ($VcInfo in (import-csv -path $VcInfoFile))
{
	Connect-VIServer -Server $VcInfo.vc -user $VcInfo.user -password $VcInfo.passwd -Protocol https
}

foreach ($f in (import-csv -path $TgtFile))
{
	echo $f.alias
	get-vmhost $f.alias |Get-VMHostService | Where {$_.Key -eq "TSM-SSH"} | Set-VMHostService -Policy "On" |Start-VMHostService
}
Disconnect-VIServer -Server * -Force -confirm:$false
