#
# ESXi bnx2x Module 로딩 여부 수집 Scripts
#

. "$HOME/scripts/globalval.ps1"

$OutputFile = "../99.output/info-vib_list.txt"
#

foreach ($f in (import-csv -path $TgtFile))
{
	
	echo "--------------------------------------------------------------------------------------------" >> $OutputFile 
 	echo $f.alias >> $OutputFile 
	echo "--------------------------------------------------------------------------------------------" >> $OutputFile 

	echo $f.alias
	
	$ESXCLI = Get-EsxCli -VMHost $f.alias
	$ESXCLI.system.module.get("bnx2x").version >> $OutputFile
}

Disconnect-VIServer -Server * -Force -confirm:$false

