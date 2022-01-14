#
# ESXi bnx2x Module 로딩 여부 수집 Scripts
#
$VcInfoFile = "../0.target/vcenter_vc70.csv"
$TgtFile = "../0.target/tgt_d80_all.csv"
$OutputFile = "../99.output/info-vib_list.txt"
#
# Connect to the vCenter Server
"{0} Connecting to vcenter server..."
foreach ($VcInfo in (import-csv -path $VcInfoFile))
{
	Connect-VIServer -Server $VcInfo.vc -user $VcInfo.user -password $VcInfo.passwd -Protocol https
}


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

