# 
# ESXi LUN Path 정보 수집 Scripts
#

. "$HOME/scripts/globalval.ps1"

$OutputFile ="../99.output/info-lunpath.txt"

$testpath = test-path $OutputFile
if ($testpath)
{
	remove-item $OutputFile
}

foreach ($f in (import-csv -path $targetfile))
{
	echo "############################################" >> $OutputFile 
 	echo $f.ip >> $OutputFile 
	echo "############################################" >> $OutputFile 
	get-scsilun -vmhost $f.alias -luntype disk |where-object {$_.Model -eq "VV"} | get-scsilunpath|measure-object  >> $OutputFile
}

Disconnect-VIServer -Server * -Force -confirm:$false

