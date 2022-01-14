#
# ESXi iSCSI Network Path Policy ¼öÁý Scripts
#

$user = "seadmin@vsphere.local"
$password = "Vmware1!"
$vcenter = "10.141.252.247"
#
$targetfile ="C:\scripts.v5\01_target\target100.csv"
$outputfile = "C:\scripts.v5\00_output\info-pathpolicy.txt"

# Connect to the vCenter Server
"{0} Connecting to vcenter server..."
Connect-VIServer -Server $vcenter -user $user -password $password -Protocol https

foreach ($f in (import-csv -path $targetfile))
{
	echo "############################################" >> $outputfile 
 	echo $f.alias >> $outputfile 
	echo "############################################" >> $outputfile 
	Get-VMhost $f.alias |Get-Scsilun -luntype disk | fl -property vmhost, runtimename, multipathpolicy >> $outputfile
}
Disconnect-VIServer -Server * -Force -confirm:$false
