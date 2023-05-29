#
# set default path policy
#
. "$HOME/scripts/globalval.ps1"

$OutputFile ="../99.output/info-dpathpolicy.txt"

$testpath = test-path $OutputFile
if ($testpath)
{
	remove-item $OutputFile
}

# Connect to the vCenter Server
"{0} Connecting to vcenter server..."
foreach ($v in (import-csv -path $vcinfofile))
{
	Connect-VIServer -Server $v.vc -user $v.user -password $v.passwd -Protocol https
}

foreach ($f in (import-csv -path $TgtFile))
{
	echo "############################################" >> $OutputFile
 	echo $f.alias >> $OutputFile
	echo "############################################" >> $OutputFile
	$esxcli = Get-Esxcli -vmhost $f.alias
	$esxcli.storage.nmp.satp.list() |where-object {$_.Name -eq "VMW_SATP_ALUA"} >> $OutputFile
}

Disconnect-VIServer -Server * -Force -confirm:$false
