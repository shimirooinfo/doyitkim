#
# ESXi NIC Teaming 설정 정책 수집 Scripts 
#

#
$targetfile ="C:\scripts.v5\01_target\target100.csv"
$outputfile ="C:\scripts.v5\00_output\info-vsw-nicteam.txt"

foreach ($f in (import-csv -path $targetfile ))
{
	echo "############################################" >> $outputfile 
 	echo $f.alias >> $outputfile 
	echo "############################################" >> $outputfile
 	get-vmhost $f.alias | Get-Virtualswitch -name vSwitch1 | Get-NicTeamingPolicy | format-table -Autosize VirtualSwitch, LoadBalancingPolicy, ActiveNic  >> $outputfile 
}
Disconnect-VIServer -Server * -Force -confirm:$false




