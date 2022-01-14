# 
# ESXi LUN Path 정보 수집 Scripts
#
$VcInfoFile = "../0.target/vcenter_vc70.csv"
$TgtFile = "../0.target/tgt_s80_all.csv"
$OutputFile ="../99.output/info-lunpath.txt"

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

foreach ($f in (import-csv -path $targetfile))
{
	echo "############################################" >> $OutputFile 
 	echo $f.ip >> $OutputFile 
	echo "############################################" >> $OutputFile 
	get-scsilun -vmhost $f.alias -luntype disk |where-object {$_.Model -eq "VV"} | get-scsilunpath|measure-object  >> $OutputFile
}

Disconnect-VIServer -Server * -Force -confirm:$false

