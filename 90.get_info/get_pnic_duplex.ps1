#
# Get NIC Duplex Information
#
$OutputFile = "/Users/yhkim/Documents/scripts.v5/99.Output/pnic_duplex.txt"
#
$ScriptRoot = "/Users/yhkim/Documents/scripts.v5/"

. "$HOME/scripts/globalval.ps1"

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
	echo "############################################" >> $OutputFile 
 	echo $f.alias >> $OutputFile 
	echo "############################################" >> $OutputFile 
	$esxcli = Get-EsxCli -VMHost $f.alias
	$esxcli.network.nic.list() |select Name, Speed, Duplex, Link >> $OutputFile
}
Disconnect-VIServer -Server * -Force -confirm:$false
