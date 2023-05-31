#
# ESXi iSCSI Network Path Policy ¼öÁý Scripts
#

. $HOME/scripts/globalval.ps1

$outputfile = "C:\scripts.v5\00_output\info-pathpolicy.txt"

foreach ($f in (import-csv -path $targetfile))
{
	echo "############################################" >> $outputfile 
 	echo $f.alias >> $outputfile 
	echo "############################################" >> $outputfile 
	Get-VMhost $f.alias |Get-Scsilun -luntype disk | fl -property vmhost, runtimename, multipathpolicy >> $outputfile
}
Disconnect-VIServer -Server * -Force -confirm:$false
