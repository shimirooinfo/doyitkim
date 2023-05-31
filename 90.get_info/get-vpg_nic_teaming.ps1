#
# ESXi NIC Teaming 설정 정책 수집 Scripts 
#

$targetfile ="C:\scripts.v5\01_target\target100.csv"
$outputfile ="C:\scripts.v5\00_output\info-vpg-nicteam.txt"

foreach ($f in (import-csv -path $targetfile ))
{
	echo "############################################" >> $outputfile 
 	echo $f.alias >> $outputfile 
	echo "############################################" >> $outputfile 
 	get-vmhost $f.alias | Get-VirtualPortGroup -name *iscsi* | Get-NicTeamingPolicy >> $outputfile 
}
Disconnect-VIServer -Server * -Force -confirm:$false




