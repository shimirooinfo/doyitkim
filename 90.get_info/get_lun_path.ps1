# 
# get ESXi LUN Path infomation
#

$user = "seadmin@vsphere.local"
$password = "Vmware1!"
$vcenter = "10.141.252.247"
#

. "$HOME/scripts/globalval.ps1"

# Connect to the vCenter Server
"{0} Connecting to vcenter server..."
Connect-VIServer -Server $vcenter -user $user -password $password -Protocol https

foreach ($f in (import-csv -path $TgtFile))
{
	echo "############################################" >> $OutputFile 
 	echo $f.alias >> $OutputFile 
	echo "############################################" >> $OutputFile
	get-scsilun -vmhost $f.alias -luntype disk |get-scsilunpath |where-object {$_.Name -match "vmhba40*"} >> $OutputFile
}

Disconnect-VIServer -Server * -Force -confirm:$false
